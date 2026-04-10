# Project Bourne

A full-loop career intelligence platform. Not a job board. Not a tracker. Not an interview prep tool. Not a resume builder. The whole thing.

**Find → Match → Apply → Track → Analyze Gaps → Learn → Prep → Repeat**

---

## What It Is

Project Bourne closes the gap that every other job search tool leaves open. Existing platforms surface listings, track applications, or prep you for interviews — none of them connect the dots between where you are, why you're being passed over, and what to do about it.

This platform does all of it:
- Job search with intelligent match scoring against your profile
- Application tracking with status transitions and per-role skills gap analysis
- Aggregate skills gap trends across all your applications ("TypeScript has appeared in 23 of your last 40 postings")
- Learning recommendations tied directly to your gaps
- AI-powered resume tailoring, cover letter generation, and interview prep
- Career mode — stays useful even when you're not actively searching

---

## Architecture

Three services, clean boundaries, one repo.

| Service | Stack | Responsibility |
| --- | --- | --- |
| `backend` | Java 21 / Spring Boot 3 | Core API — auth, data, business logic, orchestration |
| `ai-service` | Python 3.12 / FastAPI | Intelligence layer — all LLM calls, skills extraction, resume tailoring, interview prep |
| `frontend` | React 18 / TypeScript / Vite | User interface |

**Infrastructure:** PostgreSQL · Redis · Docker · GitHub Actions CI · AWS (production)

See [`planning/architecture.md`](planning/architecture.md) for the full system design.

---

## Running Locally

**Prerequisites:** Docker Desktop, Git

```bash
# Clone the repo
git clone https://github.com/mbinkley08/project-bourne.git
cd project-bourne

# Copy and fill in environment variables
cp .env.example .env
# Edit .env — add GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, ANTHROPIC_API_KEY, JWT_PRIVATE_KEY, JWT_PUBLIC_KEY

# Start everything
docker compose up
```

**Windows (Git Bash) note:** Git Bash automatically converts Unix-style paths (e.g., `/app`) to Windows paths before passing them to programs. This breaks `docker run` commands that pass Linux paths via flags like `-w /app`. Prefix any such command with `MSYS_NO_PATHCONV=1` to disable the conversion:

```bash
MSYS_NO_PATHCONV=1 docker run --rm -v "C:/path/to/dir:/app" -w /app node:20-alpine npm install
```

This does not affect `docker compose up` — only standalone `docker run` commands that include Linux path arguments.

| Service | URL |
| --- | --- |
| Frontend | http://localhost:3000 |
| Core API | http://localhost:8080 |
| API Docs (Swagger) | http://localhost:8080/swagger-ui.html |
| AI Service | http://localhost:8000 |
| AI Service Docs | http://localhost:8000/docs |

---

## Project Structure

```
project-bourne/
├── backend/          # Java / Spring Boot (Core API)
├── ai-service/       # Python / FastAPI (Intelligence layer)
├── frontend/         # React / TypeScript (UI)
├── infra/            # Docker, K8s manifests, Terraform
├── planning/         # Architecture docs, ADRs, roadmap
└── .github/          # GitHub Actions CI workflows (one per service)
```

---

## Planning Docs

| Document | Description |
| --- | --- |
| [`planning/about.md`](planning/about.md) | What this is, who it's for, why it exists |
| [`planning/plan.md`](planning/plan.md) | Roadmap and phase breakdown |
| [`planning/architecture.md`](planning/architecture.md) | Full system architecture |
| [`planning/adr/`](planning/adr/) | Architecture Decision Records |
| [`planning/github.md`](planning/github.md) | Repo conventions, branching strategy, commit standards |
| [GitHub Project Board](https://github.com/users/mbinkley08/projects/1) | Live work tracker — tickets, status, sprint progress |

---

## Engineering Philosophy

Built to demonstrate what disciplined software engineering looks like in practice:

- Every significant decision is documented in an ADR before code is written
- Testing is designed before implementation, not added after
- AI features are force-multipliers with validated, structured output — not vibe coding
- Security is first-class: user career data is sensitive
- Services communicate only over HTTP APIs — boundaries enforced by architecture, not by the repo

---

## Project Board

Work is tracked publicly on GitHub Projects — tickets, status, and progress are all visible.

**[View the Project Bourne board →](https://github.com/users/mbinkley08/projects/1)**

---

## Status

Currently in **Phase 0 — Foundation**. See [`planning/plan.md`](planning/plan.md) for the full roadmap.
