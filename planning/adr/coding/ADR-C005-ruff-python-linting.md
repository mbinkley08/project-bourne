# ADR-C005 — ruff over flake8 for Python linting
**Date:** 2026-04-09
**Status:** Accepted

## Decision
Use ruff as the Python linter for `ai-service`. Run it in CI as `ruff check .` from the `ai-service/` directory.

## Context
Issue #12 required a lint stage in the ai-service CI pipeline. The two mainstream Python linters are flake8 (established) and ruff (modern). A choice had to be made before wiring up the workflow.

## Alternatives Considered

**flake8:** The long-standing standard. Wraps pyflakes, pycodestyle, and mccabe. Large plugin ecosystem. Pure Python, which means slower on large codebases. Maintenance mode — active development has largely shifted to ruff.

**pylint:** More comprehensive than flake8 (detects more categories of issues), but significantly more opinionated and noisy out of the box. High false positive rate without heavy configuration. Too much setup overhead for a CI gate.

## Reasoning
Ruff is a drop-in replacement for flake8 — same rules, same `# noqa` suppression syntax, same output format. There is no migration cost. The speed advantage (Rust vs Python) is irrelevant at ai-service's current size, but the ecosystem alignment matters: FastAPI and Pydantic, both used in this project, have standardized on ruff. Choosing ruff is consistent with the direction of the Python tooling ecosystem in 2026.

## Tradeoffs
- flake8's plugin ecosystem is larger; if a specific flake8 plugin is needed in the future, the equivalent ruff rule may not exist yet.
- ruff is newer and its rule coverage, while broad, is still growing.
- At Phase 0 these tradeoffs are theoretical — no plugins are needed, and ruff's default ruleset is sufficient.
