# ADR-C007 — Skills taxonomy: @ManyToMany join table over duplicate skill rows
**Date:** 2026-04-19
**Status:** Accepted

## Decision
Model the relationship between `Skill` and `SubDomain` as a `@ManyToMany` with a `skill_sub_domain` join table. A skill row exists exactly once regardless of how many sub-domains it belongs to.

## Context
Skills like Git, SQL, Python, and Docker are relevant across multiple sub-domains. For example, Git belongs to Backend, DevOps, Frontend, Full Stack, Mobile, and QA & Testing. A design decision was needed: duplicate the skill row once per sub-domain, or model the relationship properly with a join table.

This decision was made during implementation of issue #18 (skills taxonomy seed data).

## Alternatives Considered

**Duplicate skill rows per sub-domain:**
A `skill` row would have a `sub_domain_id` FK, and a skill shared across sub-domains would have one row per sub-domain. Simple to query — just `WHERE sub_domain_id = ?`.

Ruled out. Duplication creates three concrete problems:
1. **Update anomalies** — renaming a skill requires finding and updating every duplicate. If any are missed, the data is inconsistent.
2. **Aggregate queries break** — "how many users have Git?" becomes impossible to answer correctly because Git exists as 6 separate rows. You'd need to group by name and hope the names are identical.
3. **Rejection pattern analysis breaks** — Phase 3's core feature (correlating skill gaps across applications) requires that "Git" in one application is the same entity as "Git" in another. Duplicates make this unreliable.

**Flat skill list with no sub-domain association:**
Skills exist globally with only a domain association. Simple, but loses the granularity needed for sub-domain-aware match scoring and recommendations.

Ruled out. The domain taxonomy was built hierarchically (Domain → SubDomain) specifically so recommendations and gap analysis could be calibrated at sub-domain level. Losing sub-domain association would undermine that design.

## Reasoning
The join table is the correct relational model for a genuine many-to-many relationship. Each skill exists once — there is one authoritative record for "Git." Associations to sub-domains are rows in `skill_sub_domain`, not duplicates of the skill itself.

This also future-proofs Phase 3: aggregate gap analysis can count appearances of a skill across applications by skill ID rather than string matching on names that might diverge.

## Tradeoffs
- Queries require a join through `skill_sub_domain` rather than a simple FK lookup. Mitigated by indexes on both FK columns and `SELECT DISTINCT` in JPQL.
- Slightly more complex seed data SQL — each skill is inserted once, then associated to sub-domains in separate statements. More verbose but also more readable.
- The owning side of the `@ManyToMany` (Skill) must be updated to persist join table rows — updating only the inverse side (SubDomain) is silently ignored by Hibernate.
