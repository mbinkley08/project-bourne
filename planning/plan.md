# Plan / Roadmap — Project Bourne

---

## Guiding Principle

Build the loop before building the features. Every phase must leave the system in a working, deployable state. No phase ends with half-built infrastructure or skipped tests. If a phase takes longer than planned, scope is cut — quality is not.

---

## Repo Structure

Mono-repo. One GitHub repository. Services are separated by directory, not by repo. Extraction to multi-repo is a future DevOps operation if team size or deployment independence demands it.

```
project-bourne/
├── backend/          # Java / Spring Boot (Core API)
├── ai-service/       # Python / FastAPI (Intelligence layer)
├── frontend/         # React / TypeScript
├── infra/            # Docker, Docker Compose, K8s configs, Terraform
├── planning/         # All planning docs, ADRs
└── .github/          # GitHub Actions workflows (one per service)
```

---

## Phases

---

### Phase 0 — Foundation
**Goal:** Nothing runs, but everything is set up right. The skeleton the whole project hangs on.

**Deliverables:**
- GitHub repo initialized with mono-repo structure above
- `README.md` at root — project description, how to run locally, architecture overview link
- Docker + Docker Compose — all three services runnable locally with one command (`docker compose up`)
- GitHub Actions CI pipelines — one per service (backend, ai-service, frontend); each runs tests and builds on push
- PostgreSQL and Redis running in Docker Compose
- Database migration tooling configured (Flyway for Java backend)
- Auth skeleton — OAuth2 with Google wired up, JWT issuance working end to end
- Health check endpoints on all three services (`GET /health`)
- Environment config strategy — `.env` files locally, secrets management defined for production
- ADR-001 written: mono-repo decision
- ADR-002 written: tech stack decisions (Java + Spring Boot, Python + FastAPI, React + TypeScript, PostgreSQL, Redis)

**Definition of done:** `docker compose up` starts all services. Auth flow works. Health checks pass. CI is green on first push.

---

### Phase 1 — Core Data Layer
**Goal:** The structural backbone of the app. Users exist. Rich profiles exist. Job domains are modeled. Applications can be tracked. REST API semantics are correct throughout.

#### 1a — Domain Taxonomy

Before any user data is modeled, the domain taxonomy must be designed. Skills, match scoring, interview prep, and learning recommendations are all domain-specific — a confidence rating on "Java" is irrelevant to a teacher, and "classroom management" is irrelevant to a software engineer.

**Deliverables:**
- Domain entity — top-level job domains (Software Engineering, Education, Finance, Healthcare, Data & Analytics, Marketing, etc.)
- Sub-domain entity — e.g., Software Engineering → Backend, Frontend, Full Stack, DevOps, QA
- Domain-specific skills taxonomy — curated seed data per domain/sub-domain; user can add custom skills
- Users can belong to multiple domains (e.g., Software + Education — exactly the kind of multi-domain profile this app was built to handle)
- All downstream features (match scoring, skills gap, interview prep, learning recs) are domain-aware from day one
- ADR-003: domain taxonomy design — flat vs. hierarchical, seed data strategy, extensibility

#### 1b — User Profile (Guided Onboarding)

The profile is the most important entity in the system. Without it, match scoring has nothing to compare against, resume tailoring has nothing to draw from, and interview prep has no context. It is not a form — it is a guided, iterative onboarding experience built in collaboration with the AI service.

**Profile sections (mirrors the depth of a real career profile):**
- **Background** — name, location, work arrangement preferences, education history
- **Work history** — roles (title, company, dates, key accomplishments, domain)
- **Skills** — per domain/sub-domain, with user-rated confidence levels (1–5)
- **Soft skills & work style** — team size, leadership experience, Agile/Scrum, communication style
- **Career goals** — target role, target domain(s), company size preference, salary expectations, what matters most
- **Differentiators** — what sets this user apart; notable projects, accomplishments, non-obvious strengths
- **Gaps / honest assessment** — areas the user knows are weak; actively working to improve
- **The big picture** — the user's own narrative connecting their background to where they're headed
- **AI in workflow** — how the user incorporates AI tools (relevant for modern roles)

**How onboarding works:**
- Step-by-step guided questionnaire (not a wall of fields)
- AI service assists: given what the user has entered so far, it can suggest skills they likely have based on their work history, identify gaps in the profile, and prompt for missing context
- Profile is never "finished" — users return to update it as they grow
- All downstream features read from the profile at request time — no stale snapshots

**Deliverables:**
- Full profile schema in PostgreSQL (normalized — work history, education, and skills as separate related tables)
- Guided onboarding API endpoints (step-by-step, stateful progress)
- AI-assisted profile enrichment — POST work history → AI service suggests likely skills for user to confirm/reject
- Profile completeness score — surface what's missing and why it matters
- Profile CRUD — full update capability after initial onboarding

#### 1c — Application Tracking & Companies

**Deliverables:**
- Job Application entity — full CRUD
  - Fields: company, role, date applied, status, salary range, location, domain, notes, confidence rating
  - Status transitions modeled explicitly: Applied → Phone Screen → Interview → Offer → Rejected / Withdrawn
- Company entity — basic profiles, reusable across applications
- REST API implemented with correct HTTP semantics throughout:
  - Proper use of GET, POST, PUT, PATCH, DELETE
  - Correct status codes (201 Created, 204 No Content, 400, 404, 409, 422, etc.)
  - Consistent error response contract
  - Request validation with clear error messages
  - Pagination on list endpoints
- Unit tests — all business logic covered
- Integration tests — all DB interactions tested against a real test database
- API documentation — OpenAPI/Swagger generated from annotations

**Definition of done:** Domain taxonomy seeded and accessible. Full guided profile onboarding works end to end (including AI skill suggestion). Full CRUD for applications and companies. API docs auto-generated. All tests green in CI.

---

### Phase 2 — Job Search & Match Scoring
**Goal:** The system can find jobs, ingest postings intelligently, and tell you how well you fit before you apply.

#### 2a — Job Posting Ingestion

Getting job posting content into the system is a harder problem than it appears. Most major job sites (LinkedIn, Indeed, Glassdoor) actively block scrapers with bot detection, JavaScript rendering, login walls, and rate limiting. The strategy is a layered fallback — the user should never have to copy/paste unless every automated option has genuinely failed.

**Ingestion strategy (attempted in order):**

| Layer | Method | Notes |
|---|---|---|
| 1st | Job board APIs (Adzuna, Reed, RemoteOK, others) | Structured data, reliable, no scraping — preferred source for search |
| 2nd | Direct URL fetch (Python/requests + BeautifulSoup) | Works on simple HTML job boards; fast |
| 3rd | Headless browser (Playwright in Python) | Handles JS-rendered content; slower, more detectable; used as fallback |
| 4th | User pastes job description text | Last resort only — guaranteed to work but poorest UX |
| V2 | Browser extension | User clicks "add to Project Bourne" while viewing a listing; best UX — out of scope for V1 |

**Key design decisions:**
- The AI service owns ingestion logic — it attempts each layer in order, returns the extracted JD text to Core API regardless of which layer succeeded
- The ingestion method used is logged per listing (useful for monitoring which boards are blocking us)
- If all automated methods fail, the UI prompts the user to paste — clearly worded, not a blank text box
- This is an evolving problem — bot detection improves over time. The layered approach makes it easy to swap or add methods without changing the contract
- ADR-004: job posting ingestion strategy — layered fallback design, browser extension decision deferred to V2

#### 2b — Search, Match Scoring & Skills Extraction

**Deliverables:**
- Job search — query job board APIs by title, domain, location, remote preference; results stored and cached
- Domain-aware search — search is filtered by the user's target domain(s) from their profile
- Match scoring engine (Core API) — domain-aware comparison of user profile against job description:
  - Experience match (years, required skills present/absent)
  - Stack/skills match (required skills vs. user's skills + confidence levels, within domain)
  - Location/remote match against user preferences
  - Returns a score + full breakdown — not just a number
- Skills extraction from job descriptions (AI service — first real Python/LLM call)
  - Parse a JD, return structured list of required/preferred skills tagged by domain
  - Drives match scoring and per-role skills gap
- Per-role skills gap analysis — user has vs. role requires, with severity ratings
- Unit + integration tests for match scoring logic
- ADR-005: match scoring algorithm design

**Definition of done:** User can search for jobs (filtered by domain), paste or fetch a URL, see match scores with breakdowns, and view per-role skills gaps. AI service is handling JD parsing and ingestion fallback.

---

### Phase 3 — Skills Intelligence & Learning
**Goal:** The aggregate intelligence layer. The system starts getting smarter the longer you use it.

**Deliverables:**
- Aggregate skills gap analysis — across all of a user's applications, which skills appear most frequently as gaps? Ranked, prioritized
- Trend detection — "TypeScript has appeared in 18 of your last 30 applications"
- Rejection pattern analysis — correlate rejection status with gap skills to surface what's costing the user interviews
- Learning recommendations (AI service) — for each gap skill, surface curated learning resources (courses, docs, articles)
- Career mode — skills gap tracking and learning recommendations available without an active job search
- Skill confidence tracking — user can rate their confidence in each skill; system adjusts recommendations accordingly
- ADR-006: LLM provider selection (Anthropic vs OpenAI) and prompt engineering strategy

**Definition of done:** Dashboard shows aggregate gap trends. Recommendations are surfaced per skill. Career mode is usable independently of job search.

---

### Phase 4 — AI Features (Resume, Cover Letter, Interview Prep)
**Goal:** The high-value AI features that differentiate the platform.

**Deliverables:**
- Resume tailoring (AI service)
  - User uploads base resume
  - System analyzes job description
  - Returns tailored version: reordered experience, reframed bullet points, highlighted relevant strengths
  - Draft returned for user review — never submitted automatically
- Cover letter generation (AI service)
  - Role-specific, grounded in user profile + JD
  - Connects user narrative to role requirements
  - Draft for user review
- Interview prep (AI service)
  - Company research summary (tech stack, culture, recent news, interview process)
  - Behavioral questions (STAR format, calibrated to role)
  - Technical questions (calibrated to required stack)
  - Skill nuances to review before the interview
  - "Things that trip people up in this type of role"
- Salary intelligence
  - Market rate data for role + location
  - Offer comparison if user has received an offer
  - Negotiation talking points
- All AI outputs: structured, validated, returned as drafts — not auto-submitted anywhere
- Prompt engineering documented in ADRs for each major AI feature
- AI service integration tests — mock LLM calls for CI, real calls in staging

**Definition of done:** All four AI features working end to end. Outputs are structured and validated before returning to Core API. All features return drafts for user review.

---

### Phase 5 — Frontend
**Goal:** Everything built so far becomes usable by a human without Postman.

**Deliverables:**
- React + TypeScript project setup (Vite)
- Design system / component library decision (shadcn/ui or similar — ADR-007)
- Auth flow — Sign in with Google, JWT stored securely (httpOnly cookie, not localStorage)
- Dashboard — application summary, skills gap overview, recent activity
- Application tracker — add, view, update status, view per-role skills gap
- Job search — search, browse listings, view match score breakdown
- Skills gap visualization — aggregate trends, confidence levels, learning recommendations
- Resume tailoring UI — upload resume, paste JD, review tailored output
- Interview prep UI — company + role input, view generated prep materials
- Cover letter UI
- Salary intelligence UI
- Responsive layout (desktop-first, mobile-aware)
- Frontend unit tests (Jest + React Testing Library)
- E2E tests for critical paths (Playwright): auth, add application, view skills gap

**Definition of done:** Full user journey works in the browser. E2E tests pass in CI. No direct LLM calls from frontend — all AI goes through Core API → AI service.

---

### Phase 6 — Production Readiness
**Goal:** The app is deployable, observable, and secure enough to show anyone.

**Deliverables:**
- AWS deployment
  - ECS (Fargate) for containers or EKS for K8s — ADR-008
  - RDS (PostgreSQL managed)
  - ElastiCache (Redis managed)
  - S3 for resume file storage
  - Route 53 + ACM for domain + TLS
- Kubernetes manifests (even if deploying to ECS — shows K8s knowledge)
- Terraform for infrastructure provisioning (IaC)
- GitHub Actions — deploy pipeline (build → test → push image → deploy) per service
- Observability
  - Structured JSON logging across all services
  - Basic metrics (request count, error rate, latency)
  - Error tracking (Sentry or AWS CloudWatch)
  - Health check endpoints monitored
- Security hardening
  - OWASP Top 10 review
  - Dependency vulnerability scan in CI (Snyk or Dependabot)
  - Secrets in AWS Secrets Manager (not env files)
  - Input validation audit
  - Auth token handling audit (no tokens in URLs, no localStorage for JWTs)
- Load testing — basic performance baseline (k6 or Locust)
- `README.md` — complete, accurate, includes architecture diagram, local setup, deployment notes

**Definition of done:** App is live on a real domain. CI deploys on merge to main. Monitoring is active. Security scan is clean.

---

## What Is NOT In Scope (V1)

- Direct application submission on behalf of users
- Mobile app
- Employer/recruiter-facing features
- Real-time chat or messaging
- Video interview simulation
- Payment / premium tier
- Social features (sharing, networking)

---

## Phase Dependencies

```
Phase 0 (Foundation)
    └── Phase 1a (Domain Taxonomy)
            └── Phase 1b (User Profile & Onboarding)
                    └── Phase 1c (Application Tracking)
                            └── Phase 2a (Job Posting Ingestion)
                                    └── Phase 2b (Search & Match Scoring)
                                            ├── Phase 3 (Skills Intelligence)
                                            └── Phase 4 (AI Features)
                                                    └── Phase 5 (Frontend)
                                                            └── Phase 6 (Production)
```

**Parallelism:**
- Phases 3 and 4 can run in parallel once Phase 2b is complete
- Phase 5 (Frontend) can begin consuming Phase 1 endpoints as soon as Phase 1b is done — UI and backend can overlap on phases 2–4 once API contracts are defined
- Domain taxonomy (1a) must be completed before any other Phase 1 work begins — it shapes the schema everything else sits on
