# Architecture — Project Bourne

---

## System Overview

Project Bourne is a three-service system with a relational data store and a cache layer. Services communicate over HTTP. No service shares code with another — boundaries are enforced by the architecture, not the repo structure.

```
┌─────────────────────────────────────────────────────────────┐
│                         CLIENT                              │
│                  React / TypeScript (SPA)                   │
│                     Vite build, served via CDN/S3           │
└───────────────────────────┬─────────────────────────────────┘
                            │ HTTPS / REST
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                       CORE API                              │
│                  Java / Spring Boot                         │
│                                                             │
│  - Auth (OAuth2 + JWT issuance)                             │
│  - User & profile management                                │
│  - Application tracking                                     │
│  - Job search & listing storage                             │
│  - Match scoring                                            │
│  - Orchestrates calls to AI Service                         │
│  - All business logic lives here                            │
└──────────┬──────────────────────────┬───────────────────────┘
           │                          │
           │ JDBC                     │ HTTP / REST
           ▼                          ▼
┌──────────────────┐      ┌───────────────────────────────────┐
│   PostgreSQL     │      │           AI SERVICE               │
│   (Primary DB)   │      │       Python / FastAPI             │
│                  │      │                                    │
│  - Users         │      │  - Skills extraction from JDs     │
│  - Applications  │      │  - Skills gap analysis            │
│  - Jobs          │      │  - Resume tailoring               │
│  - Skills        │      │  - Cover letter generation        │
│  - Companies     │      │  - Interview prep generation      │
│  - Learning      │      │  - Learning recommendations       │
│    resources     │      │  - Company research               │
│  - Gap trends    │      │  - All LLM API calls              │
└──────────────────┘      └──────────────┬────────────────────┘
           ▲                             │
           │ Redis client                │ HTTPS
┌──────────┴───────┐                    ▼
│     Redis        │         ┌──────────────────────┐
│   (Cache)        │         │     LLM Provider     │
│                  │         │  Anthropic Claude API │
│  - Sessions      │         └──────────────────────┘
│  - Job listing   │
│    cache         │         ┌──────────────────────┐
│  - Rate limiting │         │  Job Listing API     │
└──────────────────┘         │  (Adzuna / Indeed)   │
                             └──────────────────────┘
```

---

## Services

### Core API — Java / Spring Boot

The backbone of the system. Owns all structured data, business logic, auth, and orchestration.

**Responsibilities:**
- OAuth2 handshake with Google, JWT issuance and validation
- User profile CRUD
- Application tracker CRUD with explicit status transitions
- Job listing retrieval from external APIs, stored and cached locally
- Match scoring: profile vs. job description
- Orchestrates AI Service calls — frontend never calls AI Service directly
- Returns AI Service outputs as part of its own API responses (Core API is the single entry point for the frontend)

**Key design decisions:**
- RESTful API with strict HTTP semantics throughout (correct verbs, status codes, error contracts)
- Request validation via Spring's `@Valid` + Bean Validation (JSR-380)
- Pagination on all list endpoints (cursor-based preferred over offset for stability)
- OpenAPI/Swagger documentation auto-generated from code annotations
- Database migrations via Flyway — no schema changes outside of migration files
- Async calls to AI Service for non-blocking user experience on expensive operations

**Port:** 8080 (local), service name `backend` in Docker Compose

---

### AI Service — Python / FastAPI

The intelligence layer. Owns everything LLM-related. Stateless — does not write to the database directly. All persistence goes through Core API.

**Responsibilities:**
- Parse job descriptions, extract structured skills lists
- Per-role skills gap analysis (user profile vs. JD requirements)
- Aggregate skills gap analysis across multiple applications
- Resume tailoring — return a tailored version for user review
- Cover letter generation — return a draft for user review
- Interview prep — company research, behavioral questions, technical questions, nuances
- Learning resource recommendations per skill gap
- Salary market data synthesis

**Key design decisions:**
- Stateless by design — receives all context it needs in the request payload (user profile, JD, existing skills, etc.)
- All LLM calls go through a single internal module — swapping providers (Anthropic ↔ OpenAI) touches one file
- Structured output enforced — LLM responses are parsed and validated against Pydantic models before returning. If the LLM returns garbage, the service returns a clean error, not the garbage.
- All outputs are drafts — the service never auto-submits, auto-saves, or takes action beyond returning structured text
- Prompt templates versioned in code — changes to prompts are code changes, tracked in git, tested

**Port:** 8000 (local), service name `ai-service` in Docker Compose

---

### Frontend — React / TypeScript

Single-page application. Talks only to Core API. Has no knowledge of AI Service's existence.

**Responsibilities:**
- All user-facing UI
- Auth flow (redirect to Google, receive JWT, store in httpOnly cookie)
- Consume Core API REST endpoints
- Render AI-generated content returned by Core API (resume drafts, interview prep, etc.)

**Key design decisions:**
- Built with Vite (faster than Create React App, modern standard)
- TypeScript strict mode — no `any`, no escape hatches
- JWT stored in httpOnly cookie — never localStorage, never sessionStorage
- API client generated from OpenAPI spec (ensures type safety against backend contract)
- Component library: shadcn/ui (accessible, unstyled primitives — not a full opinionated framework)
- State management: React Query for server state, lightweight context for UI state — no Redux
- All AI feature calls are async with loading states — never a blocking spinner on the whole page

**Port:** 5173 (local dev), served from S3/CDN in production

---

## Data Layer

### PostgreSQL — Primary Data Store

All persistent application data. Managed via Flyway migrations — schema changes are versioned, tracked, and repeatable.

**Core entities:**

```
users
├── id, email, name, created_at, updated_at
├── profile (JSON or separate table): background, experience years,
│   preferred_location, salary_min, work_arrangement
└── linked to: skills, applications

skills
├── id, user_id, name, category, confidence_level (1-5), created_at
└── confidence_level: user-rated; drives learning recommendations

job_listings
├── id, external_id, source, title, company_id, location, remote_type,
│   salary_min, salary_max, description, raw_skills (JSON), created_at
└── cached from external APIs; refreshed on schedule

companies
├── id, name, domain, industry, size_range, notes
└── reused across job_listings and applications

applications
├── id, user_id, job_listing_id (nullable), company_id,
│   role_title, date_applied, status, salary_range,
│   location, confidence_rating, notes, created_at, updated_at
└── status: APPLIED, PHONE_SCREEN, INTERVIEW, OFFER, REJECTED, WITHDRAWN

application_skill_gaps
├── id, application_id, skill_name, severity (HIGH/MED/LOW),
│   is_present_in_user_skills, notes
└── populated by AI service analysis, stored by Core API

skill_gap_trends
├── id, user_id, skill_name, appearance_count, last_seen_at
└── aggregate view updated on each new application skill gap analysis

learning_resources
├── id, skill_name, title, url, resource_type (course/doc/article),
│   provider, notes
└── curated + AI-recommended; linked to skill gap trends
```

### Redis — Cache Layer

- **Job listing cache:** External API results cached with TTL (avoid hammering rate limits)
- **Session data:** JWT blacklist for logout, short-lived session metadata
- **Rate limiting:** Per-user rate limits on expensive AI operations
- **Future:** Pub/sub for async job processing if needed

---

## Auth Architecture

```
1. User clicks "Sign in with Google"
2. Frontend redirects to Google OAuth2 consent screen
3. Google redirects back to Core API callback endpoint with auth code
4. Core API exchanges auth code for Google user info
5. Core API creates or retrieves user record in PostgreSQL
6. Core API issues a signed JWT (HS256, short expiry + refresh token)
7. JWT returned to frontend as httpOnly cookie
8. All subsequent API calls include JWT cookie automatically
9. Core API validates JWT on every protected endpoint
```

**Why httpOnly cookie (not localStorage):**
localStorage is accessible to JavaScript — XSS attack steals the token. httpOnly cookie is not accessible to JavaScript — XSS cannot steal it. This is a security requirement, not a preference.

---

## Service Communication

### Frontend → Core API
- HTTPS REST
- JWT in httpOnly cookie (automatic on every request)
- All requests go to `/api/v1/...`

### Core API → AI Service
- Internal HTTP REST (not exposed publicly)
- No auth between services in local/dev (same Docker network)
- mTLS or service token for production
- Core API passes all context in request body (user profile snapshot, JD text, existing skills)
- AI Service is stateless — receives everything it needs, returns structured response

### Core API → External Job API
- HTTPS REST
- API key in environment variable / secrets manager
- Results cached in Redis + PostgreSQL

### AI Service → LLM Provider
- HTTPS REST (Anthropic API)
- API key in environment variable / secrets manager
- Never logged, never returned to client

---

## CI/CD Architecture

One GitHub Actions workflow per service. All three are independent — a frontend change does not trigger a backend build.

```
.github/workflows/
├── backend.yml       # On push to backend/** — test, build, push image
├── ai-service.yml    # On push to ai-service/** — test, build, push image
├── frontend.yml      # On push to frontend/** — test, build, deploy to S3
└── infra.yml         # On push to infra/** — Terraform plan/apply
```

**Pipeline stages per service:**
1. Lint + static analysis
2. Unit tests
3. Integration tests (against real DB in CI, via Docker service containers)
4. Build Docker image
5. Push to container registry (ECR)
6. Deploy to environment (staging on PR merge, production on release tag)

---

## Deployment Architecture (Production)

```
Internet
    │
    ▼
Route 53 (DNS)
    │
    ▼
CloudFront (CDN) ──── S3 (Frontend static files)
    │
    ▼
Application Load Balancer
    │
    ├── /api/* ──────► ECS Fargate (backend container)
    │                       │
    │                       ├── RDS PostgreSQL
    │                       ├── ElastiCache Redis
    │                       └── ECS Fargate (ai-service container, internal only)
    │
    └── /* ──────────► CloudFront serves frontend
```

**Key decisions:**
- Frontend: S3 + CloudFront (static files, globally cached, cheap)
- Backend + AI Service: ECS Fargate (serverless containers, no cluster management)
- AI Service is NOT behind the load balancer — internal only, only reachable by Core API
- RDS for PostgreSQL (managed, automated backups, failover)
- ElastiCache for Redis (managed, no operational overhead)
- ACM for TLS certificates (free, auto-renewing)
- AWS Secrets Manager for all secrets (API keys, DB credentials, JWT signing key)

---

## Security Posture

| Concern | Approach |
|---|---|
| Auth tokens | httpOnly cookie, never localStorage |
| Secrets | AWS Secrets Manager in prod, `.env` files locally (gitignored) |
| Input validation | Spring Bean Validation (backend), Pydantic (AI service) on all inputs |
| SQL injection | Parameterized queries via JPA/Hibernate — no string concatenation in queries |
| XSS | React escapes output by default; Content-Security-Policy header set |
| LLM prompt injection | AI service validates and sanitizes user-supplied content before inserting into prompts |
| Dependency vulnerabilities | Dependabot + Snyk scan in CI — build fails on high-severity CVEs |
| OWASP Top 10 | Reviewed at Phase 6; specific items addressed per finding |

---

## What This Architecture Demonstrates

| Skill | Where it shows |
|---|---|
| REST API design | Core API — HTTP semantics, status codes, error contracts, pagination |
| Microservices | Two independent services with clear boundaries and HTTP communication |
| Polyglot development | Java + Python in the same system for justified, natural reasons |
| Auth | OAuth2 + JWT, httpOnly cookies, stateless token validation |
| Database design | PostgreSQL schema with relationships, migrations, indexing |
| Caching | Redis for job listings and sessions |
| AI integration | Python service wrapping LLM calls with structured output validation |
| Security | Input validation, secrets management, XSS/injection prevention |
| Containerization | Docker + Docker Compose for local, ECS for production |
| CI/CD | Per-service GitHub Actions pipelines |
| Infrastructure as Code | Terraform for AWS provisioning |
| Observability | Structured logging, metrics, error tracking |
| Testing | Unit, integration, E2E at appropriate layers |
| Frontend | React + TypeScript, React Query, component library |
