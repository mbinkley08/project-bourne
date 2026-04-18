# ESLint for React + TypeScript (Vite)

**Issue covered in:** #13 (Frontend CI)

---

## ELI5

ESLint is a linter — it reads your code without running it and flags things that look wrong, inconsistent, or dangerous. For a React + TypeScript project it catches things like: using a variable before it's defined, violating React hook rules, or importing something that doesn't exist. It's the first line of defense before the code even compiles.

---

## Core Concepts

### Config file format

ESLint 8 supports several config file formats. For a project with `"type": "module"` in `package.json`, Node treats `.js` files as ES modules — but ESLint's legacy config format is CommonJS. The fix is to use `.eslintrc.cjs` (the explicit CommonJS extension), which forces Node to treat it as CommonJS regardless of the `"type"` setting.

```
package.json has "type": "module"
  → .eslintrc.js  ❌  Node tries to parse it as ESM, ESLint crashes
  → .eslintrc.cjs ✅  Node treats it as CommonJS, ESLint works
```

### Standard config for React + TypeScript

```js
// .eslintrc.cjs
module.exports = {
  root: true,
  env: { browser: true, es2020: true },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
  ],
  ignorePatterns: ['dist', '.eslintrc.cjs'],
  parser: '@typescript-eslint/parser',
  plugins: ['react-refresh'],
  rules: {
    'react-refresh/only-export-components': ['warn', { allowConstantExport: true }],
  },
}
```

**Why each piece:**
- `@typescript-eslint/parser` — teaches ESLint to understand TypeScript syntax
- `@typescript-eslint/recommended` — type-aware rules: unused vars, unsafe `any`, etc.
- `react-hooks/recommended` — enforces Rules of Hooks (no hooks inside conditionals, etc.)
- `react-refresh` — warns when a file exports non-components alongside components (breaks HMR)
- `ignorePatterns: ['dist']` — don't lint compiled output

### Required devDependencies

```json
{
  "@typescript-eslint/eslint-plugin": "^7.0.0",
  "@typescript-eslint/parser": "^7.0.0",
  "eslint": "^8.0.0",
  "eslint-plugin-react-hooks": "^4.0.0",
  "eslint-plugin-react-refresh": "^0.4.0"
}
```

---

## Common Gotchas

**`ESLint couldn't find a configuration file`** — the config file is missing entirely, or has the wrong extension for the module type. Check: does `package.json` have `"type": "module"`? If yes, name the config `.eslintrc.cjs`.

**`npm run lint` fails on Windows with `'eslint' is not recognized`** — the `node_modules/.bin/eslint` entry is a symlink that doesn't resolve correctly in Git Bash on Windows. This is a local-only problem. `npm run lint` works fine in CI (Linux). If you need to run ESLint locally in Git Bash, use: `node node_modules/eslint/bin/eslint.js . --ext ts,tsx`.

**Rollup native binary missing after Node upgrade** — If you see `Cannot find module @rollup/rollup-win32-x64-msvc`, your `node_modules` was installed under a different Node version or on a different platform. Fix: delete `node_modules` and run `npm install` again. The lock file is fine — npm resolves platform-specific optional deps on reinstall.

---

## Interview Knowledge

**Q: What's the difference between ESLint and TypeScript's type checker?**
TypeScript (`tsc`) checks types — it catches type mismatches, missing properties, wrong function signatures. ESLint checks code patterns and style — it catches unused variables, hook violations, unreachable code. They're complementary: tsc for correctness, ESLint for quality. In CI, run both.

**Q: What are the Rules of Hooks?**
React hooks must be called at the top level of a function component — never inside loops, conditions, or nested functions. The `react-hooks/recommended` plugin enforces this. Violating them causes bugs where hook state gets out of sync across renders.

---

## Project Bourne Usage

- Config lives at `frontend/.eslintrc.cjs` — `.cjs` required because `frontend/package.json` has `"type": "module"`
- CI runs `npm run lint` which maps to `eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0`
- `--max-warnings 0` means lint warnings are treated as errors in CI — zero tolerance
- Local lint via Git Bash: `node node_modules/eslint/bin/eslint.js . --ext ts,tsx` (symlink workaround)
