# ADR-C002 — ai-service Phase 2 Dockerfile: Official Playwright Base Image

**Date:** 2026-04-07
**Status:** Accepted

## Decision

When Playwright is added to the ai-service in Phase 2, the Dockerfile base image will change from `python:3.12-slim` to the official Microsoft Playwright Python image (`mcr.microsoft.com/playwright/python`). Playwright will not be installed on top of a generic Python image.

## Context

During Phase 0 (issue #7), the ai-service Dockerfile attempted to install Playwright on `python:3.12-slim`:

```dockerfile
FROM python:3.12-slim
RUN apt-get install -y chromium
RUN playwright install chromium --with-deps
```

This failed. `python:3.12-slim` now uses Debian Trixie (Debian 13), and Playwright's `--with-deps` script references font packages (`ttf-unifont`, `ttf-ubuntu-font-family`) that were renamed or removed in Trixie. The build broke with package-not-found errors.

Playwright was deferred to Phase 2 (the phase where job posting ingestion via headless browser is implemented). At that point, the Dockerfile strategy needs to be decided. Two approaches were evaluated.

## Alternatives Considered

**Option A: Stay on python:3.12-slim, manually install Playwright dependencies**
Pin the base image to Debian Bookworm (`python:3.12-slim-bookworm`) where the font packages exist, or manually map Playwright's dependency list to the correct Trixie package names.

Rejected. This means maintaining a manually-curated list of OS packages that Playwright needs, and updating it every time Playwright or the base image upgrades. Playwright's dependency list is not a stable API — it changes across versions. This is permanent maintenance work for something already maintained by someone else.

**Option B: Use the official Microsoft Playwright Python base image**
Microsoft publishes and maintains `mcr.microsoft.com/playwright/python`, a Docker image with Python and all Playwright browser dependencies pre-installed and validated. It is the documented, supported way to run Playwright in Docker.

Accepted.

## Reasoning

The official Playwright image exists specifically to solve this problem. It is tested against each Playwright release, kept up to date with the correct OS-level dependencies for each browser, and eliminates the need to manage browser dependencies manually.

Using it means:
- No fragile package list to maintain
- No Debian release tracking to worry about
- The image is validated by the Playwright team against the exact browser version being used

## Tradeoffs

- The official Playwright image is larger than `python:3.12-slim`. This is accepted — it's a runtime that drives a full browser; the image size is appropriate.
- We lock to Microsoft's release cadence for the base image. This is acceptable since Playwright itself is already a Microsoft-maintained dependency.
- The ai-service will use a different base image in Phase 2 than it does in Phase 0. This is a deliberate, documented change — not drift.

## Phase 2 Implementation Note

When adding Playwright in Phase 2, the ai-service Dockerfile opening line changes from:

```dockerfile
FROM python:3.12-slim
```

to:

```dockerfile
FROM mcr.microsoft.com/playwright/python:v<version>-noble
```

The specific version tag should be pinned at the time of implementation and matched to the `playwright` version in `requirements.txt`.
