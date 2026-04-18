# Docker Compose

**Issue covered in:** #6 (PostgreSQL + Redis), #7 (Full stack), #14 (Environment config)

---

## ELI5

Docker Compose is a tool that lets you define and run multiple Docker containers together using a single config file. Instead of manually running `docker run` for each container and wiring them together yourself, you write a `docker-compose.yml` that describes all your services, and one command (`docker compose up`) starts everything.

---

## Core Concepts

### Services
Each entry under `services:` is a container. It can be built from a local `Dockerfile` or pulled from Docker Hub.

```yaml
services:
  postgres:
    image: postgres:16-alpine   # pull from Docker Hub
  backend:
    build: ./backend            # build from local Dockerfile
```

### Ports
Maps `host:container`. Traffic hitting your machine on port 5432 gets forwarded to port 5432 inside the container.

```yaml
ports:
  - "5432:5432"
```

### Environment Variables
Passed into the container at startup. Can reference `.env` file values with `${VAR_NAME}`.

```yaml
environment:
  POSTGRES_DB: projectbourne
  GOOGLE_CLIENT_ID: ${GOOGLE_CLIENT_ID}   # pulled from .env file
```

### Volumes
Persists data outside the container lifecycle. Without a volume, everything in the container is wiped when it stops.

Service-level mount (inside the service definition):
```yaml
volumes:
  - postgres_data:/var/lib/postgresql/data  # named volume
```

Top-level declaration (at the bottom of the file):
```yaml
volumes:
  postgres_data:
```

### Networks
Compose automatically creates a shared network for all services. Services can reach each other by service name — `postgres`, `redis`, `backend` — without knowing IP addresses.

```yaml
# No config needed — Compose does this automatically
# backend can reach postgres via hostname "postgres"
DB_URL: jdbc:postgresql://postgres:5432/projectbourne
```

### Health Checks
A command Compose runs inside the container to determine if it's "healthy." Used to gate startup of dependent services.

```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres"]
  interval: 10s    # how often to run the check
  timeout: 5s      # how long before it's considered failed
  retries: 5       # how many failures before marking unhealthy
```

### depends_on with condition
Tells Compose to wait until a dependency is healthy before starting a service. Without `condition: service_healthy`, Compose only waits for the container to *start* — not for the database to actually be ready.

```yaml
depends_on:
  postgres:
    condition: service_healthy   # waits for health check to pass
  redis:
    condition: service_healthy
```

**Why this matters:** A Spring Boot app will crash immediately if it tries to connect to PostgreSQL before the DB is ready to accept connections. The health check + depends_on combination prevents this race condition.

---

## Key Commands

| Command | What it does |
|---|---|
| `docker compose up -d` | Start all services in the background |
| `docker compose up -d postgres redis` | Start specific services only |
| `docker compose down` | Stop and remove all containers and networks |
| `docker compose ps` | Show running services and their status |
| `docker compose ps -a` | Show all services including stopped ones |
| `docker compose logs <service>` | View logs for a specific service |
| `docker compose build` | Build all service images |
| `docker compose build <service>` | Build one service image |

---

## Common Gotchas

**`.env` file variables** — Compose automatically reads a `.env` file in the same directory. Variables are available as `${VAR_NAME}` in the compose file. If a variable is missing, Compose warns and substitutes a blank string — which can cause downstream failures (e.g., Spring Boot refusing to start with an empty OAuth2 client ID).

**Silent env var dependencies** — If a service reads an env var from `application.yml` (or equivalent config) that has a default value, and docker-compose never explicitly sets it, the service will silently use the default. This works locally but hides a real dependency. Any env var that would need to be changed for staging or production should be explicitly set in docker-compose (using `${VAR:default}` syntax) so it's visible and overridable. Example: `FRONTEND_URL` had a default of `http://localhost:3000` in `application.yml` but wasn't in docker-compose at all — it worked by accident and would have been an invisible misconfiguration in production.

**Service name vs container name** — The service name (e.g., `postgres`) is how other services reach it on the network. The container name (e.g., `projectbourne-postgres-1`) is what shows up in `docker ps`.

**Port conflicts** — If something is already running on port 5432 on your host, the container won't be able to bind to it. `docker compose ps` will show the container failed to start.

---

## Project Bourne Usage

- `postgres` and `redis` use pre-built images with health checks
- `backend`, `ai-service`, and `frontend` build from local Dockerfiles
- `backend` depends on both `postgres` and `redis` being healthy before starting
- `frontend` depends on `backend` (start ordering only — no health check gating)
- A single `postgres_data` named volume persists the database across restarts
