# ADR-C006 — Spring Data JPA: @Query over derived queries for relationship navigation
**Date:** 2026-04-17
**Status:** Accepted

## Decision
Use `@Query` with an explicit JPQL string whenever a Spring Data JPA derived query method name would require an underscore to navigate a `@ManyToOne` or `@OneToMany` relationship. Do not use derived query names with underscores.

## Context
Spring Data JPA supports derived query method names — the repository method name encodes the query logic and Spring generates the SQL at startup. When querying by a field on a related entity (e.g., find `SubDomain` records where `domain.id` equals a given value), Spring Data requires an underscore in the method name to express the navigation:

```text
List<SubDomain> findByDomain_IdOrderByNameAsc(UUID domainId);
```

The Checkstyle `MethodName` rule enforces the pattern `^[a-z][a-zA-Z0-9]*$`, which bans underscores. This causes a CI build failure.

This conflict was discovered during implementation of `SubDomainRepository` in issue #17.

## Alternatives Considered

**Suppress the Checkstyle warning with `@SuppressWarnings`:**
Ruled out. Suppressing lint rules for framework-mandated naming is a slippery slope. The Checkstyle config exists to enforce consistency — carving out exceptions for specific methods undermines that. If the rule is wrong, change the rule; don't suppress it on a per-method basis.

**Relax the `MethodName` rule to allow underscores:**
Ruled out. The rule banning underscores is correct for Java method naming conventions. Relaxing it to accommodate one framework's naming quirk would allow underscores everywhere, which degrades readability for code that doesn't use Spring Data.

**Add the related entity's ID as a direct field on the child entity:**
For example, add a `UUID domainId` field to `SubDomain` alongside the `@ManyToOne Domain domain` field. This would allow `findByDomainIdOrderByNameAsc` without an underscore.

Ruled out. Duplicating the FK as both a JPA relationship and a raw UUID field creates two sources of truth. JPA can get them out of sync. The `@ManyToOne` relationship is the correct model — the raw UUID is redundant.

## Reasoning
`@Query` decouples the method name from the query logic entirely. The method name can follow any convention (including Checkstyle-compliant camelCase), while the JPQL string expresses the navigation without any naming constraint:

```text
@Query("SELECT sd FROM SubDomain sd WHERE sd.domain.id = :domainId ORDER BY sd.name ASC")
List<SubDomain> findByDomainIdOrderByNameAsc(@Param("domainId") UUID domainId);
```

This is also more explicit — the query logic is visible in the code rather than encoded in the method name. A reader doesn't have to mentally parse the naming convention to understand what the method does.

## Tradeoffs
- `@Query` requires an additional import and annotation, whereas a derived query is just the method signature. Slightly more verbose, but the intent is clearer.
- JPQL uses entity class names and field names, not table/column names. Renaming a field requires updating the query string — the compiler won't catch it. Mitigated by integration tests that run the actual query against a real database.
