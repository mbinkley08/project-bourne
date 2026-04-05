# ADR-002 — Tech Stack Selection
**Date:** 2026-04-05
**Status:** Accepted

## Decision
- **Core API:** Java 21 / Spring Boot 3
- **AI Service:** Python 3.12 / FastAPI
- **Frontend:** React 18 / TypeScript / Vite
- **Primary database:** PostgreSQL 16
- **Cache:** Redis 7
- **Containerization:** Docker / Docker Compose (local), ECS Fargate (production)
- **CI/CD:** GitHub Actions (per-service pipelines)
- **Cloud:** AWS

## Context
Stack selection was driven by two data sources used in combination: a frequency analysis of skill requirements across 40+ real job applications, and a market assessment of what modern mid-level software engineering roles expect.

**Frequency analysis across 40 job postings (files with matches):**

| Technology | Job postings | % |
|---|---|---|
| REST APIs | 17 / 40 | 43% |
| Python | 16 / 40 | 40% |
| PostgreSQL | 16 / 40 | 40% |
| AWS | 14 / 40 | 35% |
| TypeScript | 11 / 40 | 28% |
| Docker | 11 / 40 | 28% |
| React | 10 / 40 | 25% |
| Kubernetes | 7 / 40 | 18% |

The goal was to build one project that demonstrates as much of this surface area as possible in a way that is authentic — not artificially assembled.

## Alternatives Considered

**Full Python backend (FastAPI or Django) instead of Java:**
Python appeared in 40% of postings and is the dominant language in AI/ML tooling. Replacing Java with Python for the core API was considered.

Ruled out because: Java is the developer's deepest professional strength (4 years of production Java at Redpoint Global). A portfolio project built in a language the developer knows deeply demonstrates more than one built in a language learned for the project. The value of Java — Spring Boot's IoC container, bean lifecycle, type safety, and enterprise patterns — is better shown by someone with real production experience in it. Python gets its own legitimate service (the AI service) where it is the correct language choice, not a demonstration choice.

**Node.js / TypeScript for the backend:**
TypeScript appeared in 28% of postings. A full TypeScript stack (Node backend + React frontend) would have addressed the gap directly.

Ruled out because: TypeScript's representation in the data is primarily frontend and full-stack web roles. The target roles are backend-leaning mid-level positions. More importantly, using the same language for backend and frontend reduces the demonstration surface — it would not show polyglot development, which is a genuine differentiator.

**Go for the backend:**
Go appeared in several postings and is increasingly common for cloud-native services.

Ruled out because: Go is a skill gap with no existing depth to leverage. Starting a portfolio project in an unfamiliar language increases the risk of surface-level, un-confident code. Go is tracked as a learning target but not the right choice for a project meant to demonstrate existing depth.

**Single-language backend (Java only, no Python service):**
The simplest architecture. Java handles everything including LLM API calls.

Ruled out because: Python is the dominant language in the AI/LLM ecosystem. The Anthropic SDK, LangChain, BeautifulSoup, Playwright, and most AI tooling is Python-native. Forcing Java to handle these creates unnecessary friction and produces code that does not reflect real-world practice. More importantly, a polyglot architecture — where each language owns the domain it is best suited for — is what modern engineering teams actually build. Demonstrating this is architecturally honest, not a stunt.

## Reasoning

**Java for the Core API** because it is where the developer has the most depth, and depth shows in code. Spring Boot forces demonstration of real patterns: IoC/DI, bean lifecycle, Spring Security OAuth2, JPA/Hibernate, Bean Validation, and REST design discipline. These are visible to any engineer reviewing the code.

**Python for the AI Service** because Python is legitimately the right language for LLM integration and web scraping. The Anthropic SDK is Python-native. Playwright for headless browser automation is Python-native. BeautifulSoup for HTML parsing is Python-native. Choosing Python here is not a demonstration choice — it is the correct engineering choice, and correctness is what the decision log is here to prove.

**React + TypeScript for the Frontend** because TypeScript appeared in 28% of postings and React in 25%. TypeScript strict mode is now the industry default for frontend work, not a premium add-on. The frontend is the developer's biggest skill gap — building it here closes the gap in a verifiable, demonstrable way.

**PostgreSQL** because it appeared in 40% of postings, is the default relational database for modern application development, and forces real schema design, migration discipline (Flyway), and relational modeling — all visible in the codebase.

**Redis** because it is ubiquitous in production systems even when not listed as a requirement. Including it demonstrates awareness of caching patterns, session management, and performance thinking beyond happy-path application code.

## Tradeoffs
- Two backend languages (Java + Python) means two runtime environments to maintain, two sets of dependencies to update, and two Docker images to build. Mitigated by clean service boundaries and independent CI pipelines.
- Java startup time is slower than Python for Docker containers. Acceptable for a portfolio project; would be addressed with Spring Boot's AOT compilation or GraalVM native image at production scale.
- React + TypeScript is the developer's weakest layer. This is intentional — the project is designed to close gaps, not only demonstrate existing strengths.
