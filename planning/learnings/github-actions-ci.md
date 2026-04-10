# GitHub Actions CI

**Issue covered in:** #9 (health checks), #11/#12/#13 (CI pipelines), CI fixes session

---

## ELI5

GitHub Actions is GitHub's built-in automation system. Every time you push code, it can automatically run scripts — tests, linters, builds, deployments — on a fresh Linux (or Windows/Mac) machine. You define the automation in YAML files inside `.github/workflows/`. No separate CI server to run or maintain.

---

## Core Concepts

### Trigger (`on`)
Defines what event starts the workflow. Combine `push` and `pull_request` with `paths` filters so the workflow only runs when relevant files change — avoids running the backend pipeline when you only touched the frontend.

```yaml
on:
  push:
    paths:
      - 'frontend/**'
  pull_request:
    paths:
      - 'frontend/**'
```

### Jobs
A workflow has one or more jobs. Each job runs on its own fresh runner machine. Jobs run in parallel by default unless you declare `needs:` dependencies between them.

```yaml
jobs:
  test-and-build:
    runs-on: ubuntu-latest
```

### Steps
Steps run sequentially inside a job. Each step either uses a pre-built action (`uses:`) or runs a shell command (`run:`).

```yaml
steps:
  - uses: actions/checkout@v4          # checks out your code
  - name: Run tests
    run: mvn test -B
```

### `uses` vs `run`
- `uses: actions/checkout@v4` — runs a pre-packaged action (someone else's reusable script)
- `run: npm ci` — runs a shell command directly

### `working-directory`
Changes the directory a `run` step executes in. Essential in a mono-repo where each service has its own folder.

```yaml
- name: Install dependencies
  working-directory: ./frontend
  run: npm ci
```

### Environment Variables (`env`)
Set at workflow level, job level, or step level. Job-level env is available to all steps in that job.

```yaml
jobs:
  test-and-build:
    env:
      FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true  # job-level
    steps:
      - run: mvn test
        env:
          JWT_SECRET: test-only-value            # step-level
```

### Services
Sidecar containers that start before your steps and are available on `localhost`. Used for databases, caches, etc. that your tests need.

```yaml
services:
  postgres:
    image: postgres:16-alpine
    env:
      POSTGRES_DB: mydb
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - 5432:5432
    options: >-
      --health-cmd pg_isready
      --health-interval 10s
      --health-timeout 5s
      --health-retries 5
```

The service is reachable at `localhost:5432` from any step. The `options` block adds a Docker health check so the service is ready before your tests run.

---

## Two Different "Node.js versions" in the Same Workflow

This trips people up. There are **two separate Node.js versions** at play:

| | What it is | Set by |
|---|---|---|
| **Action runner Node.js** | The Node.js version GitHub uses to *execute* action scripts (`actions/checkout`, `actions/setup-node`) | Determined by action version; forced with `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` |
| **App Node.js** | The Node.js version your *application* builds and runs with | `node-version:` in `actions/setup-node` |

```yaml
env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true   # action runner → use Node 24

steps:
  - uses: actions/setup-node@v4
    with:
      node-version: '24'                     # app → build with Node 24
```

Changing `node-version: '20'` to `node-version: '24'` only affects what Node version your app uses. It does NOT stop the deprecation warning about the action runner itself — that requires the env var.

---

## Common Gotchas

**`npm ci` requires `package-lock.json`** — If the lockfile doesn't exist in the repo, `npm ci` will fail immediately. Always commit the lockfile.

**`cache-dependency-path`** — When caching `npm` dependencies in a mono-repo, point this at the specific `package-lock.json` for that service, not the root.

```yaml
- uses: actions/setup-node@v4
  with:
    cache: 'npm'
    cache-dependency-path: frontend/package-lock.json
```

**Services vs Testcontainers** — If your tests use Testcontainers to spin up their own database, the `services:` block in the workflow is redundant (but harmless). Testcontainers starts its own container and `@DynamicPropertySource` wires it in — it doesn't use the service container at all.

**Action runner Node.js deprecation** — GitHub periodically deprecates the Node.js version used to run action scripts. When this warning appears, add `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true` at the job level. The underlying actions (`@v4`) don't need to change.

---

## Python CI Pattern (`ai-service`)

Split dependencies into two requirements files:

```
requirements.txt       # runtime deps (FastAPI, httpx, anthropic, etc.)
requirements-dev.txt   # dev-only deps (ruff, pytest)
```

Install both in CI, neither in the Docker image:

```yaml
- name: Install dependencies
  working-directory: ./ai-service
  run: |
    pip install -r requirements.txt
    pip install -r requirements-dev.txt

- name: Build Docker image
  run: docker build -t project-bourne-ai-service ./ai-service
```

The Dockerfile only copies and installs `requirements.txt` — linters and test runners never end up in the production image.

### `cache: pip` vs `cache-dependency-path`

For Python, `cache: pip` is sufficient — pip's cache is keyed automatically on the requirements files found. You don't need to specify `cache-dependency-path` the way you do for npm.

---

## Project Bourne Usage

- Each service (`backend`, `ai-service`, `frontend`) has its own workflow scoped to its folder
- Pipelines are structured identically from day one so splitting to separate repos later is copy-paste, not a rewrite
- Backend workflow uses a `services:` Postgres sidecar alongside Testcontainers (redundant but harmless; will clean up when Testcontainers is the single source of truth)
- Frontend uses `--passWithNoTests` so CI passes before tests are written; flag becomes a no-op as tests are added — the pipeline shape never needs to change
- `ai-service` uses `requirements-dev.txt` to keep linter/test tools out of the Docker image
