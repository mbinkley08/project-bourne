# Spring Data JPA — @Query vs Derived Queries

**Issue covered in:** #17 (domain and sub-domain entities)

---

## ELI5

Spring Data JPA can write SQL for you based on a method name — if you name a method `findByEmailOrderByNameAsc`, it generates the query automatically. But sometimes the method name it needs conflicts with your linter rules, or the navigation is too complex for naming alone. `@Query` lets you write the JPQL yourself and name the method whatever you want.

---

## Derived Query Names

Spring Data JPA reads the method name and generates JPQL from it. The convention:

```
findBy[Property][Condition]OrderBy[Property][Direction]
```

Examples:
```text
List<User> findByEmail(String email);
List<User> findByNameOrderByCreatedAtDesc(String name);
List<User> findByActiveTrue();
```

### Navigating relationships with underscores

When a property is a related entity (not a primitive), Spring Data uses `_` to navigate:

```text
// SubDomain has a @ManyToOne field called 'domain' of type Domain
// To query by domain.id, Spring Data needs the underscore:
List<SubDomain> findByDomain_IdOrderByNameAsc(UUID domainId);
//                         ^ underscore = navigate into 'domain', then access 'id'
```

This works but violates Checkstyle's `MethodName` rule, which bans underscores: `^[a-z][a-zA-Z0-9]*$`.

---

## @Query — The Fix

`@Query` lets you write JPQL directly. The method name is now free to follow any convention you want:

```text
@Query("SELECT sd FROM SubDomain sd WHERE sd.domain.id = :domainId ORDER BY sd.name ASC")
List<SubDomain> findByDomainIdOrderByNameAsc(@Param("domainId") UUID domainId);
```

- The method name `findByDomainIdOrderByNameAsc` passes Checkstyle (no underscores)
- The JPQL navigates `sd.domain.id` — same logic, now in the query string instead of the method name
- `@Param("domainId")` binds the method parameter to the `:domainId` placeholder in the query

### Why JPQL and not SQL

`@Query` uses JPQL by default — it operates on entity names and field names, not table names and column names. To write raw SQL, add `nativeQuery = true`:

```text
@Query(value = "SELECT * FROM sub_domain WHERE domain_id = :domainId ORDER BY name ASC", nativeQuery = true)
List<SubDomain> findByDomainIdOrderByNameAsc(@Param("domainId") UUID domainId);
```

JPQL is preferred unless you need database-specific syntax or a query that JPQL can't express.

---

## Common Gotchas

**Derived query with `_` violates Checkstyle `MethodName`.** The rule pattern `^[a-z][a-zA-Z0-9]*$` bans underscores anywhere in method names. Switch to `@Query` whenever relationship navigation requires an underscore.

**`@Param` is required when method parameter names aren't preserved at compile time.** Always use `@Param` with `@Query` to be safe — it makes the binding explicit regardless of compiler settings.

**JPQL uses entity class names and field names, not table/column names.** `FROM SubDomain` refers to the Java class, not the `sub_domain` table. `sd.domain.id` refers to the `domain` field on `SubDomain` and the `id` field on `Domain`.

**Derived queries fail silently at startup if the property path is wrong.** Spring Data validates derived query names when the application starts — a typo in `findByEmial` will throw an exception on boot, not at test time.

---

## When to Use Each

| Situation | Use |
|---|---|
| Simple property lookup or sort | Derived query — less code |
| Relationship navigation that requires `_` | `@Query` — avoids Checkstyle conflict |
| Complex joins, aggregates, or subqueries | `@Query` — derived names can't express these |
| Database-specific SQL (e.g., PostgreSQL functions) | `@Query(nativeQuery = true)` |

---

## Project Bourne Usage

- `SubDomainRepository.findByDomainIdOrderByNameAsc` — uses `@Query` because the derived name `findByDomain_IdOrderByNameAsc` violated Checkstyle's `MethodName` rule (underscores banned)
- JPQL: `SELECT sd FROM SubDomain sd WHERE sd.domain.id = :domainId ORDER BY sd.name ASC`
- This is the standard pattern to use any time a `@ManyToOne` relationship needs to be queried by the related entity's ID

**Project Bourne Decision:** Always use `@Query` when a derived query name would require an underscore for relationship navigation. Keeps method names Checkstyle-compliant and makes the query intent explicit.
