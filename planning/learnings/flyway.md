# Flyway

**Issue covered in:** #8 (migration tooling configured)

---

## ELI5

Flyway is a database migration tool. Instead of making schema changes directly in a database, you write numbered SQL files — Flyway runs them in order and tracks which ones have already been applied. Every developer and every environment runs the exact same migrations in the exact same order.

---

## Why This Matters

Without migration tooling, schema changes become a manual, error-prone process: "remember to run this SQL on staging," "production is missing that column from last week." With Flyway, the schema is version-controlled alongside the code. When the app starts, Flyway checks what's been applied and runs anything new. No manual steps, no drift between environments.

---

## How It Works

### Naming convention

Migration files follow a strict naming pattern:

```
V{version}__{description}.sql
```

- `V` prefix — marks it as a versioned migration
- `{version}` — a number (1, 2, 3... or timestamps like 20260407)
- `__` — two underscores separating version from description
- `{description}` — human-readable, underscores become spaces in the UI

Examples:
```
V1__create_schema.sql
V2__create_users.sql
V3__add_skills_table.sql
```

### Where files live (Spring Boot)

```
src/main/resources/db/migration/
```

Spring Boot auto-detects this location. No additional config needed.

### What Flyway tracks

Flyway creates a `flyway_schema_history` table in your database on first run. Every applied migration gets a row: version, description, checksum, applied timestamp, success flag. On each subsequent startup, Flyway compares the files on disk against this table and runs anything new.

### Fail-fast behavior

If a migration file that was previously applied has been modified (checksum mismatch), Flyway refuses to start and throws an error. This is intentional — it protects you from accidentally altering history. **Never edit an already-applied migration.** If you need to fix something, write a new migration.

---

## Spring Boot Integration

Add to `pom.xml`:
```xml
<dependencies>
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-core</artifactId>
    </dependency>
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-database-postgresql</artifactId>
    </dependency>
</dependencies>
```

Spring Boot auto-runs Flyway on startup. The datasource config (`spring.datasource.*`) is used automatically — no extra wiring needed.

---

## Rollback

Flyway Community Edition (free) does **not** support automatic rollbacks. Once a migration is applied, there is no built-in "undo" command. The convention throughout this project is **forward-only migrations**:

- Fix a bad migration by writing a new migration that corrects the mistake
- Do not rely on rollback as part of the deployment strategy
- Before production: define and document the rollback approach (manual script, forward rollback migration, or upgrade to Flyway Teams for native rollback support)

This is noted in `planning/plan.md` under Phase 6.

---

## Common Gotchas

**Never edit an applied migration file.** Flyway checksums every file. If the checksum changes, the app won't start. Write a new migration instead.

**Migration files run in version order, not filename alphabetical order.** `V10` runs after `V9`, not after `V1`.

**Testcontainers + Flyway.** When Testcontainers starts a PostgreSQL container for tests and Spring wires it in via `@DynamicPropertySource`, Flyway runs all migrations against that container automatically. Tests always run against the correct schema without any extra setup.

**Out-of-order migrations.** By default Flyway rejects migrations with a lower version than the highest already applied. If multiple developers work on migrations in parallel, coordinate to avoid conflicts.

---

## Project Bourne Usage

- Flyway runs on backend startup — verified via Docker Compose container logs (issue #8)
- Migration files in `backend/src/main/resources/db/migration/`
  - `V1__create_schema.sql` — baseline
  - `V2__create_users.sql` — users table (added during issue #10 auth work)
- Forward-only migration strategy throughout; rollback approach deferred to Phase 6
- Testcontainers in `BackendApplicationIT` automatically runs all migrations against the test container before tests execute
