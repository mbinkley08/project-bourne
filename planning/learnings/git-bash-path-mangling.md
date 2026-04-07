# Git Bash Path Mangling on Windows

**Issue covered in:** #7 (Full stack — generating package-lock.json via Docker container)

---

## ELI5

Git Bash on Windows secretly translates Unix-style paths (like `/app`) into Windows-style paths (like `C:/Program Files/Git/app`) before passing them to programs. This is helpful when you're working with local files, but it causes problems when you're passing a path to a tool (like Docker) that expects to receive it unchanged and interpret it inside a Linux container. The fix is an environment variable that tells Git Bash to stop translating.

---

## What Happened

We ran this command to generate `package-lock.json` inside a Docker container:

```bash
docker run --rm \
  -v "C:/Users/mbink/.../frontend:/app" \
  -w /app \
  node:20-alpine npm install
```

Docker failed with:

```
the working directory 'C:/Program Files/Git/app' is invalid
```

Git Bash saw `-w /app` and converted `/app` to `C:/Program Files/Git/app` — the Windows path of the Git installation directory. Docker received a Windows path and tried to use it as the working directory inside a Linux container. That path doesn't exist in Linux.

---

## Why Git Bash Does This

Git Bash runs on MSYS2 (a Unix-like environment for Windows). It was designed to make Unix tools work on Windows by automatically converting paths. When it sees an argument that looks like an absolute Unix path (`/something`), it prepends the MSYS2 root — which is where Git for Windows is installed (`C:/Program Files/Git`).

This is helpful for things like:
```bash
cat /etc/hosts    # Git Bash translates this to C:/Program Files/Git/etc/hosts
```

But it's a problem when the path is meant for a Linux container — Docker passes it straight through to the container's filesystem, not to the Windows filesystem.

---

## The Fix: MSYS_NO_PATHCONV=1

Setting `MSYS_NO_PATHCONV=1` before the command tells Git Bash: *don't translate paths for this command*.

```bash
MSYS_NO_PATHCONV=1 docker run --rm \
  -v "C:/Users/mbink/.../frontend:/app" \
  -w /app \
  node:20-alpine npm install
```

With this set, `-w /app` is passed to Docker as-is, which is exactly what Docker expects — a Linux path inside the container.

---

## The Volume Mount Still Uses a Windows Path

Notice that the volume mount (`-v`) still uses a Windows-style path for the host side:

```bash
-v "C:/Users/mbink/.../frontend:/app"
```

This is correct and intentional. The `-v` flag format is `host_path:container_path`. Docker Desktop on Windows expects the host path to be a Windows path. Only the container path (`/app`) is a Linux path — and that's the one Git Bash was mangling.

---

## When to Use MSYS_NO_PATHCONV=1

Use it any time you're passing a Linux path argument to a tool that talks to something Linux-based (Docker containers, WSL, SSH commands, etc.) and Git Bash is likely to mangle it.

Common triggers:
- `-w /some/path` (working directory flag for Docker)
- URL paths: `curl http://host/path` (usually fine, but can cause issues)
- Environment variable values containing paths passed via `-e`

---

## Alternative: Use PowerShell or CMD

PowerShell and CMD don't do path conversion at all. If a command is consistently problematic in Git Bash, running it in PowerShell is a clean escape hatch. But `MSYS_NO_PATHCONV=1` is the targeted fix — it solves the problem without switching your entire shell.

---

## Quick Reference

```bash
# Problem: Git Bash mangles /app → C:/Program Files/Git/app
docker run -w /app ...

# Fix: disable path conversion for this command
MSYS_NO_PATHCONV=1 docker run -w /app ...

# Alternative: use // prefix (MSYS2 trick, less reliable)
docker run -w //app ...
```
