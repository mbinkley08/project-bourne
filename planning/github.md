# GitHub — Project Bourne

---

## Repository

`mbinkley08/project-bourne` — mono-repo, one repo for all services.

---

## Branching Strategy

Trunk-based development. All work merges directly to `main`. No long-lived feature branches.

- `main` — the default branch; deployable at all times
- Short-lived branches are acceptable for larger chunks of work, but should be merged quickly
- No release branches in V1 — tags mark releases

---

## Commit Message Format

```
Title: Phase X, brief description of overall goal

* Bullet one — what was done
* Bullet two — what was done
* Bullet three — what was done

closes #N
```

**Rules:**
- Subject line: `Title: Phase X, brief goal` — capitalize the title word, no em dashes
- Body: bulleted list using `*`, one bullet per logical change
- No periods at the end of bullets
- No em dashes anywhere in the message — use commas or plain phrasing instead
- Always end with `closes #N` — this is the only format GitHub recognizes for auto-closing issues on merge
  - Multiple issues: `closes #6, closes #7`
  - "Issue 6" or "#6" alone do NOT trigger auto-close

**Why this matters:** GitHub only auto-closes an issue when a commit merged to the default branch contains a recognized closing keyword (`closes`, `fixes`, `resolves`) followed by `#N`. Any other phrasing is ignored.

---

## Issue Tracking

- One GitHub Issue per deliverable (mapped to plan.md)
- Labels: `phase-0`, `phase-1`, etc. + type labels (`feature`, `infra`, `planning`, `chore`, `security`)
- Issues are closed automatically via commit message `closes #N` on merge to `main`
- Never close issues manually unless the work was done outside a commit (e.g., a planning-only issue)

---

## Pull Requests

- PRs are not required for solo work — direct commits to `main` are acceptable in V1
- When PRs are used, they should reference the issue in the description: `closes #N`
- Branch protection on `main`: CI must pass before merge (enforced via GitHub Actions)

---

## Branch Protection (main)

- Require status checks to pass before merging (all three CI pipelines)
- No force pushes to `main`
- No branch deletion of `main`

---

## Tags & Releases

- Tag format: `v0.1.0`, `v0.2.0`, etc. — semantic versioning
- Tags mark end-of-phase milestones
- GitHub Releases created at each tag with a summary of what the phase delivered

---

## README Requirements

Every service directory (`backend/`, `ai-service/`, `frontend/`) must have a `README.md` with:
- What the service does
- How to run it locally (standalone and via Docker Compose)
- Key environment variables
- How to run the tests

The root `README.md` covers the full system: architecture overview, `docker compose up` instructions, and links to planning docs.
