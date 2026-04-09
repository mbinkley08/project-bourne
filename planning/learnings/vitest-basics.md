# Vitest

**Issue covered in:** #13 (frontend CI), CI fixes session

---

## ELI5

Vitest is a test runner built specifically for Vite projects. It runs your JavaScript/TypeScript tests fast because it reuses the same build pipeline Vite already set up — no separate configuration needed to understand TypeScript or ESM modules. Think of it as Jest but designed for the Vite ecosystem.

---

## Core Concepts

### How it relates to Vite
Vitest piggybacks on `vite.config.ts`. You can add a `test:` block to that config file, or Vitest will use sensible defaults. Because it reuses Vite's transformer, you don't need Babel or separate TS compilation just for tests.

### Where test files go
By default, Vitest looks for files matching:
- `**/*.test.ts` / `**/*.test.tsx`
- `**/*.spec.ts` / `**/*.spec.tsx`

Convention: put the test file next to the file it tests.
```
src/
  utils/format.ts
  utils/format.test.ts
```

### Running modes

| Command | What it does |
|---|---|
| `vitest` | Starts in watch mode — re-runs tests when files change |
| `vitest run` | Runs once and exits — used in CI |
| `vitest run --passWithNoTests` | Runs once, exits 0 even if no test files are found |

In `package.json` the script is usually just `"test": "vitest"`. In CI you call it as:
```bash
npm test -- --run --passWithNoTests
```
The `--` separates npm script args from vitest args.

### `--passWithNoTests`
Without this flag, Vitest exits with error code 1 if it finds zero test files. This breaks CI before any tests are written. Adding `--passWithNoTests` makes it exit 0 in that case.

**This is the correct CI approach:** wire the test step into the pipeline from day one with `--passWithNoTests`. As tests are added, the flag becomes a no-op. You never have to change the pipeline shape — you just add test files.

---

## Testing React Components

To render React components in tests you need a browser-like environment. Vitest doesn't include one by default — you have to install and configure it.

**Options:**
- `jsdom` — simulates a browser DOM in Node.js (most common, Jest's default)
- `happy-dom` — faster than jsdom, less complete compatibility

**Setup required:**
1. Install: `npm install -D jsdom` (or `happy-dom`)
2. Configure in `vite.config.ts`:
   ```ts
   export default defineConfig({
     test: {
       environment: 'jsdom',
       setupFiles: ['./src/test-setup.ts'],
     },
   })
   ```
3. Setup file (`src/test-setup.ts`):
   ```ts
   import '@testing-library/jest-dom'
   ```

**Without this setup:** tests that call `render()` from `@testing-library/react` will fail because there's no `document` or `window` in a plain Node.js environment.

---

## Basic Test Structure

```ts
import { describe, it, expect, beforeEach } from 'vitest'

describe('MyComponent', () => {
  beforeEach(() => {
    // runs before each test
  })

  it('renders the title', () => {
    // test body
    expect(something).toBe(true)
  })
})
```

---

## Common Gotchas

**`npm test -- --run` vs `vitest run`** — Both do the same thing. The double-dash `--` is required when passing args through `npm run` — everything after `--` goes to the underlying command, not to npm.

**No config file found** — Vitest works with zero config. If you have a `vite.config.ts`, it will use that. Add a `test:` block only when you need non-default behavior (environment, coverage, setup files).

**`@testing-library/jest-dom` matchers** — These (`.toBeInTheDocument()`, `.toHaveTextContent()`, etc.) must be imported in a setup file. If you get "toBeInTheDocument is not a function" errors, your setup file isn't wired up.

---

## Project Bourne Usage

- Frontend uses Vitest as the unit test runner
- CI uses `--run --passWithNoTests` so the test step is live from Phase 0
- `jsdom` + `@testing-library/react` setup will be added when frontend component tests are written (Phase 1+)
- E2E tests use Playwright separately under `npm run test:e2e` (deferred to Phase 2)
