# ADR-001 — Mono-repo vs Multi-repo
**Date:** 2026-04-05
**Status:** Accepted

## Decision
Use a single Git repository (mono-repo) with services separated by directory: `backend/`, `ai-service/`, `frontend/`, `infra/`, `planning/`.

## Context
Project Bourne is a three-service system built by a single developer. Before writing any code, a repository structure decision had to be made. The two realistic options were a mono-repo (one repo, subdirectories per service) or a multi-repo (one repo per service).

The project uses three different languages and runtimes — Java, Python, and TypeScript — which have no shared code. Services communicate only over HTTP. This means the code is already decoupled by design regardless of repo structure.

## Alternatives Considered
**Multi-repo:** One GitHub repository per service (`project-bourne-backend`, `project-bourne-ai-service`, `project-bourne-frontend`). Each service versions independently. Standard approach for large teams or when services have different release cadences.

Ruled out because:
- Adds coordination overhead with no benefit for a solo developer
- Cross-service changes require synchronized PRs across repos
- CI/CD setup must be duplicated across repos from day one
- Local development requires cloning and running multiple repos
- Fragments the portfolio story — a recruiter would need to find and navigate three separate repos

## Reasoning
The mono-repo was chosen for three reasons:

1. **The code is already decoupled.** Java, Python, and TypeScript share no code. Services only communicate over HTTP APIs. The decoupling is enforced by the architecture, not by the repo structure. A mono-repo does not introduce coupling risk.

2. **Extraction is a low-cost future operation.** If the project grows to a team size where multi-repo is warranted, splitting is a `git subtree split` operation — a DevOps task, not a code refactoring. The key is maintaining service boundaries during development. If the backend never imports frontend logic and the AI service never bleeds into core API business logic, extraction will be clean whenever it is needed.

3. **CI/CD is designed service-by-service from day one.** Each service has its own GitHub Actions workflow, scoped to trigger only on changes to its own directory. This means the pipelines are already structured for eventual extraction — splitting the repo would require copying and reconfiguring the workflows, not rewriting them.

## Tradeoffs
- Single version tag applies to all services. If services need independent release cadences at scale, a mono-repo becomes a source of friction.
- At team scale, a mono-repo means coordinating permissions across services in one place. Not a concern for a solo project.
- `git log` and `git blame` are noisier when changes span multiple services. Mitigated by scoped, descriptive commit messages.
