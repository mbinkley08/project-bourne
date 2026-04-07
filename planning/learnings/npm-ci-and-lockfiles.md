# npm ci and package-lock.json

**Issue covered in:** #7 (Full stack — frontend Dockerfile build failure)

---

## ELI5

`npm install` is like telling a chef "make me a pasta dish — your call on which pasta and sauce." `npm ci` is like handing the chef a recipe card that says exactly which brand of pasta, which exact sauce, and which exact quantities — and the chef must follow it precisely. The recipe card is `package-lock.json`. If the recipe card doesn't exist, `npm ci` refuses to start.

---

## npm install vs npm ci

| | `npm install` | `npm ci` |
|---|---|---|
| Uses lockfile? | Optional — generates/updates it | **Required** — fails without it |
| Updates lockfile? | Yes, if deps changed | Never — read-only |
| Installs exact versions? | Resolves semver ranges | Yes — exact versions from lockfile |
| Deletes node_modules first? | No | Yes — always starts clean |
| Speed | Slower (resolves ranges) | Faster (no resolution needed) |
| Reproducible? | Not guaranteed | Guaranteed |
| Use in CI/Docker? | No | Yes |

---

## What is package-lock.json?

`package.json` declares *ranges*: `"react": "^18.0.0"` means "react 18.anything." Today that resolves to 18.3.1. In six months it might resolve to 18.4.0.

`package-lock.json` is the resolved snapshot: "on this exact date, `^18.0.0` resolved to `18.3.1`, which itself depends on these exact packages at these exact versions." It locks the entire dependency tree — not just top-level packages, but everything they depend on too.

### Why it belongs in git

Without `package-lock.json` in git:
- Developer A's `npm install` resolves to react 18.3.1
- Developer B runs it a month later, gets react 18.4.0
- CI gets yet another version
- Docker build gets another version

With `package-lock.json` in git:
- Everyone gets exactly the same dependency tree
- `npm ci` enforces it

---

## The Problem We Hit (Issue #7)

The frontend `Dockerfile` used `npm ci`:

```dockerfile
COPY package*.json .
RUN npm ci          # requires package-lock.json
COPY . .
```

But `package-lock.json` had never been generated — it wasn't in the repo. `npm ci` failed immediately with a usage error.

### How We Fixed It

Generated the lockfile by running `npm install` inside a temporary Docker container (Node isn't installed locally):

```bash
MSYS_NO_PATHCONV=1 docker run --rm \
  -v "C:/Users/mbink/IdeaProjects/Project Bourne/frontend:/app" \
  -w /app node:20-alpine npm install
```

This wrote `package-lock.json` to the `frontend/` directory on the host. We then committed it to git so all future `docker compose build` runs (and eventually CI) can use `npm ci` reliably.

---

## Why Use npm ci in Docker (Not npm install)

1. **Reproducibility** — Docker builds should be identical every time. `npm install` can silently pull newer patch versions.
2. **Speed** — `npm ci` is faster because it skips dependency resolution.
3. **Safety** — If `package.json` and `package-lock.json` are out of sync, `npm ci` errors immediately rather than silently fixing it.
4. **Clean slate** — `npm ci` deletes `node_modules` before installing. No stale packages from a previous layer.

---

## package-lock.json and .dockerignore

`package-lock.json` should be in git and copied into the Docker build context. It should NOT be in `.dockerignore`.

`node_modules` should be in `.dockerignore` — Docker never needs your locally-installed modules, it installs its own via `npm ci`.

```
# frontend/.dockerignore
node_modules    ← exclude this
dist            ← exclude this

# package-lock.json is NOT listed here — Docker needs it
```
