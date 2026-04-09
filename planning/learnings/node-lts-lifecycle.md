# Node.js LTS Lifecycle

**Issue covered in:** CI fixes session

---

## ELI5

Node.js releases new major versions every year. Not all versions are equal — some get long-term support (LTS), meaning bug fixes and security patches for years. Others are short-lived. Choosing a non-LTS version for production is like building on sand — it goes EOL fast and stops getting security patches.

---

## Release Cadence

Node.js releases a new major version every **October**. Versions follow a predictable pattern:

| Version type | Which numbers | Active support | Security-only | Total lifespan |
|---|---|---|---|---|
| **LTS (Long-Term Support)** | Even: 18, 20, 22, 24 | ~18 months | ~12 months | ~3 years |
| **Current (non-LTS)** | Odd: 19, 21, 23 | ~6 months | None | ~8 months |

**Rule of thumb:** Always use even-numbered versions in production and CI. Odd versions are for trying out upcoming features — never for anything that needs to stay running.

### LTS lifecycle stages

1. **Current** — latest release, active development
2. **Active LTS** — in long-term support, gets new features + bug fixes
3. **Maintenance** — security and critical bug fixes only
4. **EOL (End of Life)** — no more patches at all; stop using immediately

---

## Node 20 EOL

Node.js 20 reached EOL in **April 2026**. After EOL:
- No more security patches
- GitHub Actions deprecates it as the action runner version
- Docker images still exist but aren't updated
- You'll get deprecation warnings in CI

**Node.js 24** is the current LTS (as of mid-2026). Use it for new projects.

---

## GitHub Actions and Node.js

GitHub Actions runs action scripts (like `actions/checkout`, `actions/setup-node`) on a specific Node.js version internally. This is separate from your app's Node.js version. GitHub deprecates older runner versions on roughly the same schedule as Node.js EOL.

### When you see this warning:
```
Node.js 20 actions are deprecated. Please update...
```

**Fix option 1 — Force the runner to use Node.js 24:**
```yaml
jobs:
  my-job:
    env:
      FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true
```

**Fix option 2 — Upgrade the app's Node.js version** (separate concern, but also worth doing):
```yaml
- uses: actions/setup-node@v4
  with:
    node-version: '24'   # was '20'
```

Note: changing `node-version` does NOT silence the runner deprecation warning. You need both.

---

## Checking the Current LTS

- Official schedule: nodejs.org/en/about/previous-releases
- Always check before starting a new project — the current LTS changes over time

---

## Project Bourne Decision

Explicitly upgraded from Node.js 20 to **Node.js 24** at the start of Phase 0 rather than waiting for Node 20 to fully break things. Node 20 was EOL in April 2026 when this decision was made.

Principle applied: "do it right, not fast" — start on supported infrastructure from day one rather than carrying technical debt that forces a future upgrade.
