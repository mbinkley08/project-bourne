# ADR-003 — Domain Taxonomy Design
**Date:** 2026-04-17
**Status:** Accepted

## Decision
- **Structure:** Two-level hierarchy — Domain → Sub-domain → Skills
- **Seed data:** Curated via Flyway migration; maintained by the application, not user-editable in V1
- **Custom skills:** Supported — live in the same `Skill` table as curated skills, flagged with `curated = false`
- **User-domain membership:** Many-to-many — a user can belong to multiple domains simultaneously
- **Domain-awareness:** All downstream features (match scoring, skills gap, interview prep, learning recommendations) operate within the user's domain context

## Context
The app serves job seekers across multiple fields — software engineers, educators, data analysts, marketers. A confidence rating of "5" on Java is meaningful in a Software Engineering context and completely irrelevant in an Education context. Without domain structure, the system cannot distinguish between them. Match scoring against a Java backend role would incorrectly factor in classroom management skills. Aggregate gap analysis would return noise across unrelated fields.

The taxonomy also serves the skills system: "React" means different things in different sub-domains (Frontend vs. Full Stack vs. Mobile). The structure gives skills their context.

The original use case that motivated the app — a developer who also teaches — is exactly the multi-domain scenario the system must handle correctly. A user who works in Software Engineering and Education needs gap analysis, match scoring, and interview prep that respects both domains independently.

## Alternatives Considered

**Flat list of skills with no domain hierarchy:**
Simplest possible model — one `Skill` table with no domain association.

Ruled out because: without domain context, skills have no meaning relative to each other. Gap analysis returns an undifferentiated list across all fields. Match scoring cannot distinguish relevant from irrelevant skills. "5 years of curriculum design" pollutes a software engineering match score. The flat model cannot serve multi-domain users at all.

**Three-level hierarchy (Domain → Sub-domain → Specialization):**
For example: Software Engineering → Backend → Java Ecosystem, or Education → K-12 → Elementary.

Ruled out for V1 because: the added granularity creates more data modeling and seed data complexity than the MVP needs. Match scoring and gap analysis do not require specialization-level precision in V1. This is a V2 extension if user data reveals the need.

**Domain as a tag on skills rather than a hierarchical entity:**
Skills are flat, but tagged with one or more domain labels.

Ruled out because: tags are unordered and unstructured. You cannot navigate a tag graph the way you can navigate a hierarchy. Sub-domain filtering becomes a string-matching problem rather than a FK join. Consistency of the taxonomy depends on tag hygiene, which degrades quickly without a formal hierarchy enforcing it.

**User selects a single domain:**
A simpler user model — pick one domain, everything is scoped to it.

Ruled out because: the multi-domain user (Software + Education, Data + Finance, etc.) is not an edge case — it is the primary use case that motivated this project. A single-domain constraint would make the app wrong for the exact user it was built to serve.

## Reasoning

**Two-level hierarchy (Domain → Sub-domain)** hits the right balance for V1. It provides enough structure to make match scoring and gap analysis domain-aware without over-engineering the taxonomy. Sub-domains give skills their context (Backend vs. Frontend vs. DevOps within Software Engineering) while keeping the model navigable. Adding a third level is a data migration, not an architecture change — the structure supports it without requiring it now.

**Curated seed data via Flyway** keeps the taxonomy clean and consistent. If every user defines their own skill names, aggregate gap analysis breaks down — "TypeScript", "typescript", and "TS" become three different gaps. A curated list ensures that when 40 users apply for roles requiring "TypeScript," they all map to the same canonical skill and the trend surfaces correctly. The seed data is a Flyway migration, not application startup logic, so it is versioned and repeatable.

**Custom skills with a `curated` flag** handle the reality that no curated list is complete. Niche technologies, domain-specific tools, and emerging skills will appear in job postings that the seed data does not cover. Rather than blocking the user, custom skills are supported — they just do not contribute to aggregate trend analysis across users (since naming consistency cannot be guaranteed). Within a single user's profile they work identically to curated skills.

**Many-to-many user-domain membership** is the correct model because domain is a property of the user's career, not a filter on their session. A user who is both a developer and a teacher wants to see Software Engineering match scores for engineering roles and Education match scores for teaching roles — not a blended score that means nothing. The junction table (`user_domain`) makes this clean and query-efficient.

## Tradeoffs
- **V1 seed data is intentionally narrow.** The initial taxonomy targets the domains explicitly called out in the plan (Software Engineering, Education, Finance, Healthcare, Data & Analytics, Marketing) with sub-domains and skills for each. This is a starting point, not the final taxonomy — expanding it is expected once the app is running and validated.

- **Expanding the taxonomy post-V1 is a Flyway migration, not a code change.** Adding new domains, sub-domains, or curated skills means writing a new numbered migration file (e.g., `V3__add_domains_wave2.sql`) and deploying. It runs once, is fully versioned, and requires no changes to application code. The original seed migration is never modified — Flyway's forward-only convention means the audit trail of when each domain was added is preserved automatically.

- **Custom skills do not participate in cross-user aggregate analysis.** This is a known limitation and acceptable in V1 — the curated taxonomy covers the common case, and custom skills serve the long tail. If a custom skill recurs frequently enough in job postings, it is a signal to promote it to the curated list via a migration.

- **Multi-domain users add complexity to the onboarding flow** — users must select their domain(s) before skills make sense. This is handled in Phase 1b onboarding by making domain selection the first meaningful step after background information.
