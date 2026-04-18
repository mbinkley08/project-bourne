# Architecture Decision Records

A running index of all ADRs for Project Bourne. Each decision is documented before the code is written.

ADRs in `adr/` cover architectural and system-level decisions.
ADRs in `adr/coding/` cover implementation-level decisions.

## Architecture ADRs

| # | Title | Status | Date |
|---|---|---|---|
| [ADR-001](ADR-001-mono-repo.md) | Mono-repo vs multi-repo | Accepted | 2026-04-05 |
| [ADR-002](ADR-002-tech-stack.md) | Tech stack selection | Accepted | 2026-04-05 |
| [ADR-003](ADR-003-domain-taxonomy.md) | Domain taxonomy design | Accepted | 2026-04-17 |
| ADR-004 | Job posting ingestion strategy | Pending | — |
| ADR-005 | Match scoring algorithm | Pending | — |
| ADR-006 | LLM provider selection | Pending | — |
| ADR-007 | Frontend component library | Pending | — |
| ADR-008 | ECS vs EKS deployment | Pending | — |

## Coding ADRs

| # | Title | Status | Date |
|---|---|---|---|
| [ADR-C001](coding/ADR-C001-jwt-storage.md) | JWT storage: httpOnly cookie vs localStorage | Accepted | 2026-04-05 |
| [ADR-C002](coding/ADR-C002-playwright-base-image.md) | ai-service Phase 2 Dockerfile: official Playwright base image | Accepted | 2026-04-07 |
| [ADR-C003](coding/ADR-C003-jwt-signing-algorithm.md) | JWT signing algorithm: RS256 over HS256 | Accepted | 2026-04-07 |
| [ADR-C004](coding/ADR-C004-checkstyle-spotbugs.md) | Checkstyle + SpotBugs for lint and static analysis | Accepted | 2026-04-09 |
| [ADR-C005](coding/ADR-C005-ruff-python-linting.md) | ruff over flake8 for Python linting | Accepted | 2026-04-09 |
