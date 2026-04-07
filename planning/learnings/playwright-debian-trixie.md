# Playwright on Debian Trixie — Build Failure and Deferral Decision

**Issue covered in:** #7 (Full stack — ai-service Dockerfile build failure)

---

## ELI5

Playwright is a library for controlling a headless web browser from code — useful for scraping websites that require JavaScript to render. When you install it, it tries to also install all the system packages (fonts, libraries) the browser needs. On the version of Debian our Docker base image uses, some of those font packages were renamed and no longer exist under the old names. The install failed. We decided to remove Playwright from Phase 0 entirely since it's not needed until Phase 2.

---

## What Playwright Does

Playwright is a browser automation library (similar to Selenium). In Project Bourne, it's planned for Phase 2 as the Layer 3 fallback in the job posting ingestion strategy — for job listings that require JavaScript rendering (can't be fetched with a simple HTTP request).

---

## The Failure

The `ai-service` Dockerfile had:

```dockerfile
FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    chromium \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install chromium --with-deps   # ← this failed
```

The `--with-deps` flag tells Playwright to also install all OS-level dependencies the browser needs (fonts, shared libraries, etc.). It does this by running `apt-get install` with its own list of required packages.

The error:

```
E: Package 'ttf-unifont' has no installation candidate
E: Package 'ttf-ubuntu-font-family' has no installation candidate
Failed to install browsers
Error: Installation process exited with code: 100
```

---

## Why It Failed — Debian Trixie

`python:3.12-slim` currently uses Debian Trixie (Debian 13), the latest release. Playwright's dependency list includes font packages — `ttf-unifont` and `ttf-ubuntu-font-family` — that existed in older Debian releases (Bullseye, Bookworm) but were renamed in Trixie:

- `ttf-unifont` → replaced by `fonts-unifont`
- `ttf-ubuntu-font-family` → removed or restructured

Playwright's `--with-deps` script hadn't yet been updated to account for these changes in Trixie. The packages it tried to install simply don't exist under those names anymore.

---

## The Decision — Defer Playwright to Phase 2

Rather than hacking around the Trixie package names (patching someone else's install script), we asked: *does Phase 0 actually need Playwright?*

The `ai-service` at Phase 0 contains only a single `/health` endpoint. No LLM calls. No browser automation. Playwright is a Phase 2 dependency — it won't be used until the job posting ingestion layer is built.

Installing a large, complex dependency before you need it is a cost with no benefit:
- Bigger Docker image
- Longer build time
- Fragile dependency on OS package availability
- Something that can break on base image updates

**Fix applied:**
- Removed `playwright==1.44.0` from `requirements.txt`
- Removed the `apt-get install chromium` and `playwright install chromium --with-deps` steps from the Dockerfile
- Added a comment in both files noting Playwright will be added in Phase 2
- The `ai-service` Dockerfile now builds in seconds instead of minutes

---

## What the Fix Will Look Like in Phase 2

When Playwright is actually needed, the right approach will be to use the official Playwright Docker base image rather than trying to install Playwright on top of a generic Python image:

```dockerfile
FROM mcr.microsoft.com/playwright/python:v1.x-noble
```

Microsoft maintains this image with all browser dependencies pre-installed and correctly configured. It's the supported, stable way to run Playwright in Docker — not manually managing system packages.

---

## Lesson

**Don't install what you don't use yet.** Especially in Phase 0, which is about getting the skeleton running — not about having all future dependencies present. Dependencies carry a cost: build time, image size, and surface area for breakage. Add them when the feature that needs them is being built.
