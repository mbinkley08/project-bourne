# Docker Build Context and .dockerignore

**Issue covered in:** #7 (Full stack — frontend build failure)

---

## ELI5

When you run `docker build`, Docker doesn't just read the Dockerfile — it first packages up everything in the build directory and sends it to the Docker daemon. That package is called the **build context**. If your directory has gigabytes of files (like `node_modules`), Docker tries to send all of it before even starting the build. A `.dockerignore` file tells Docker what to leave out.

---

## What Is the Build Context?

The build context is the directory you pass to `docker build` (or the `build:` path in `docker-compose.yml`). Docker tarballs everything in that directory and sends it to the daemon. This happens *before* any Dockerfile instructions run.

```yaml
# In docker-compose.yml:
backend:
  build: ./backend    # ./backend is the build context
frontend:
  build: ./frontend   # ./frontend is the build context
```

The Dockerfile lives inside the build context. `COPY` and `ADD` instructions can only reference files within the build context — they can't reach outside it.

---

## Why .dockerignore Matters

### The Problem We Hit (Issue #7)

We generated `node_modules` locally by running `npm install` inside the `frontend/` directory (via a Docker container). That put a `node_modules` folder with hundreds of megabytes of files directly on disk in the build context.

When Docker tried to send the build context, it attempted to process every file in `node_modules` — including symlinks and binary files. It choked with:

```
invalid file request node_modules/.bin/baseline-browser-mapping
```

The fix: add a `.dockerignore` that excludes `node_modules`.

### The Fix

```
# frontend/.dockerignore
node_modules
dist
```

Once Docker knows to skip those directories, the build context is just source files — small and fast.

---

## .dockerignore Syntax

Works like `.gitignore`. Common patterns for a frontend:

```
node_modules        # never send node_modules
dist                # compiled output — rebuilt inside Docker
.env                # never send secrets
.env.local
coverage            # test coverage reports
*.log
```

---

## Why node_modules Shouldn't Be in the Image Anyway

The Dockerfile already runs `npm ci` inside the container, which installs dependencies fresh from `package-lock.json`. Sending your local `node_modules` would:

1. Slow down the build context transfer massively
2. Risk using packages built for your host OS (wrong architecture, wrong binaries)
3. Override what `npm ci` would have installed

The image should always build its own clean dependencies. That's the whole point of having `npm ci` in the Dockerfile.

---

## Best Practice: Always Have a .dockerignore

Every service directory should have a `.dockerignore`. At minimum:

**Node/Frontend:**
```
node_modules
dist
.env*
coverage
```

**Python:**
```
__pycache__
*.pyc
.venv
venv
.env*
.pytest_cache
```

**Java/Maven:**
```
target
.env*
*.log
```

---

## Project Bourne Fix

Added `frontend/.dockerignore` with `node_modules` and `dist` excluded. This resolved the build context failure that was causing `docker compose build` to crash before the frontend Dockerfile could even start executing.
