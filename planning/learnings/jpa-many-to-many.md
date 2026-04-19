# JPA — @ManyToMany Relationships

**Issue covered in:** #18 (skills taxonomy)

---

## ELI5

A many-to-many relationship means "one thing can belong to many other things, and those other things can belong to many of the first things." A skill like Git belongs to many sub-domains (Backend, DevOps, Full Stack, etc.), and each sub-domain has many skills. In the database, this is modeled with a join table that holds pairs of IDs. In Java, `@ManyToMany` maps this automatically.

---

## The Join Table

The database needs a third table to represent the relationship:

```text
skill          skill_sub_domain        sub_domain
id             skill_id  ──────────►  id
name           sub_domain_id ───────► name
curated                               domain_id
```

Without the join table, you'd have to duplicate skill rows — one "Git" row per sub-domain. That creates data integrity problems and makes updates painful. The join table is the correct relational model.

---

## Entity Setup (Owning Side)

Only one side needs `@JoinTable` — this is the owning side. The other side (if mapped at all) uses `mappedBy`. If you only need to navigate in one direction, only map one side.

```text
@ManyToMany(fetch = FetchType.LAZY)
@JoinTable(
    name = "skill_sub_domain",
    joinColumns = @JoinColumn(name = "skill_id"),
    inverseJoinColumns = @JoinColumn(name = "sub_domain_id")
)
private Set<SubDomain> subDomains = new HashSet<>();
```

- `name` — the join table name in the database
- `joinColumns` — the FK column pointing to THIS entity's table
- `inverseJoinColumns` — the FK column pointing to the OTHER entity's table
- `FetchType.LAZY` — do not load all sub-domains every time a Skill is loaded; load on demand

---

## Querying Across the Join Table

Spring Data JPA can join through `@ManyToMany` in JPQL. The join uses the field name on the entity, not the table name:

```text
// Find all skills for a given sub-domain
@Query("SELECT DISTINCT s FROM Skill s JOIN s.subDomains sd WHERE sd.id = :subDomainId ORDER BY s.name ASC")
List<Skill> findBySubDomainId(@Param("subDomainId") UUID subDomainId);

// Find all skills across all sub-domains for a given domain
@Query("SELECT DISTINCT s FROM Skill s JOIN s.subDomains sd WHERE sd.domain.id = :domainId ORDER BY s.name ASC")
List<Skill> findByDomainId(@Param("domainId") UUID domainId);
```

**Why `DISTINCT`?** A skill associated with multiple sub-domains will appear multiple times in a join result — once per matching row in the join table. `DISTINCT` collapses duplicates so each skill appears once.

**Two-level navigation** — `sd.domain.id` works because `SubDomain` has a `@ManyToOne Domain domain` field. JPQL can navigate across relationships as deep as needed.

---

## Common Gotchas

**Always initialize the Set.** `private Set<SubDomain> subDomains = new HashSet<>()` — not `null`. Hibernate needs a non-null collection to manage the relationship. A null field causes `NullPointerException` when Hibernate tries to add to it.

**Use `Set`, not `List`, for `@ManyToMany`.** Hibernate has a known bug with `List` and `@ManyToMany` — deleting one element can cause it to delete all rows in the join table and re-insert the remaining ones. `Set` avoids this entirely.

**`FetchType.LAZY` is non-negotiable.** `EAGER` on a `@ManyToMany` will load every related entity every time you load the owning entity. With hundreds of skills each associated with multiple sub-domains, this kills performance.

**Owning side controls the join table.** If you save a `Skill` with `subDomains` populated, the join table rows are written. If you add a `Skill` to `SubDomain.skills` (inverse side) without also updating `Skill.subDomains`, the join table is NOT updated. Always update the owning side.

**`DISTINCT` is required in JPQL joins.** Without it, a skill associated with 3 sub-domains matching a domain filter appears 3 times in the result. Always use `SELECT DISTINCT` when joining through a many-to-many.

---

## When to Use Many-to-Many vs Duplicates

| Approach | When to use |
|---|---|
| Duplicate rows per relationship | Never — creates data integrity problems and makes updates painful |
| Many-to-many join table | When an entity genuinely belongs to multiple parents |
| Intermediate entity (join entity) | When the relationship itself has attributes (e.g., a `user_skill` table with `confidence_level`) |

An intermediate entity is a join table that becomes a first-class entity. For example, `UserSkill(user_id, skill_id, confidence_level)` — the relationship itself carries data, so it needs its own JPA entity.

---

## Project Bourne Usage

- `Skill` ↔ `SubDomain` — `@ManyToMany` via `skill_sub_domain` join table. `Skill` is the owning side.
- `SkillRepository` uses `SELECT DISTINCT` and `@Query` for both sub-domain and domain filtered queries
- The domain-filtered query navigates two levels: `Skill → SubDomain → Domain`
- Custom skills (per-user) are deferred to issue #19 — they'll use an intermediate entity `UserSkill(user_id, skill_id, confidence_level)` where the relationship itself carries a confidence rating

**Project Bourne Decision:** Skills are modeled as a many-to-many with sub-domains rather than duplicating skill rows per sub-domain. Duplication creates update anomalies (changing "Git" to "Git/Version Control" requires updating every duplicate) and makes aggregate queries unreliable. The join table is the correct relational model and scales cleanly as domains expand.
