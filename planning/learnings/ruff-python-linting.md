# Ruff — Python Linting

**Issue covered in:** #12 (ai-service CI)

---

## ELI5

Ruff is a Python linter written in Rust. It checks your Python code for style problems and common mistakes — the same things flake8 checks for — but runs dramatically faster because it's not written in Python. Same rules, same output, just much quicker.

---

## Core Concepts

### What ruff replaces

Ruff is designed as a drop-in replacement for several Python tools:

| Tool | What it did | Ruff equivalent |
|---|---|---|
| flake8 | Style and logic lint | `ruff check` |
| isort | Import sorting | `ruff check --select I` |
| pycodestyle | PEP 8 style | included |
| pyflakes | Logic errors | included |
| pydocstyle | Docstring style | included (optional) |

Instead of installing and configuring multiple tools, you install one.

### Basic usage

```bash
ruff check .              # lint the current directory
ruff check . --fix        # auto-fix fixable violations
ruff check . --watch      # watch mode — re-lints on save
```

### Configuration

Ruff uses `pyproject.toml` or `ruff.toml`. For a minimal setup, no config file is needed — the defaults are sensible.

```toml
# pyproject.toml (optional)
[tool.ruff]
line-length = 100
```

### `# noqa` suppression

Same syntax as flake8:
```python
import os  # noqa: F401   — suppress "imported but unused"
```

This matters for drop-in migration: if you already have `# noqa` comments from flake8, they work unchanged in ruff.

---

## ruff vs flake8 — The Key Differences

| | flake8 | ruff |
|---|---|---|
| Written in | Python | Rust |
| Speed | Slow on large codebases | 10–100x faster |
| Plugin support | Large ecosystem | Growing, built-in rules cover most cases |
| Config | `setup.cfg` / `.flake8` | `pyproject.toml` / `ruff.toml` |
| Auto-fix | No (plugins may add it) | Yes, `--fix` flag built in |
| Ecosystem direction | Legacy, maintenance mode | Active, adopted by FastAPI/Pydantic/Astral |

**The practical difference:** For a project this size the speed gap doesn't matter. The reason to choose ruff is ecosystem alignment — FastAPI and Pydantic (which Project Bourne uses) both use ruff. It's the direction Python tooling is moving in 2026.

---

## Common Gotchas

**Speed is irrelevant at small scale** — The Rust-vs-Python speed advantage only matters on large codebases with thousands of files. On a small service like `ai-service`, both tools complete in under a second. Choose ruff for ecosystem reasons, not speed.

**flake8 plugins don't transfer** — If a project relies on flake8 plugins (flake8-bugbear, flake8-annotations, etc.), those don't automatically work in ruff. Ruff has its own built-in equivalents, but the migration isn't always automatic.

**Not a formatter** — Ruff is a linter, not a code formatter. For formatting (Black-style), use `ruff format` (separate command) or Black itself.

---

## Project Bourne Usage

- `ai-service` uses ruff as its linter (installed via `requirements-dev.txt`)
- CI runs `ruff check .` from `./ai-service` as the first pipeline stage
- No `pyproject.toml` ruff config currently — defaults are sufficient for Phase 0
- flake8 was considered and rejected in favor of ruff; see ADR-C005
