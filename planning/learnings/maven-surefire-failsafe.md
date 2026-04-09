# Maven Surefire and Failsafe — Unit vs Integration Test Separation

**Issue covered in:** #11 (backend CI — unit test and integration test stages)

---

## ELI5

Maven has two test plugins: Surefire runs your fast unit tests during the build; Failsafe runs your slower integration tests separately and is designed to always clean up even if tests fail. The separation lets you run unit tests frequently and integration tests only when you want the full picture.

---

## Surefire — Unit Tests

**Plugin:** `maven-surefire-plugin` (included automatically — no declaration needed)
**Lifecycle phase:** `test` (runs during `mvn test`)
**Default file pattern:** picks up files matching:
- `**/*Test.java`
- `**/Test*.java`
- `**/*Tests.java`
- `**/*TestCase.java`

These are your unit tests — fast, no infrastructure, pure Mockito or similar.

```
mvn test       # runs Surefire → picks up *Test.java files
```

---

## Failsafe — Integration Tests

**Plugin:** `maven-failsafe-plugin` (must be declared in `pom.xml`)
**Lifecycle phases:** `integration-test` and `verify`
**Default file pattern:** picks up files matching:
- `**/*IT.java`
- `**/IT*.java`
- `**/*ITCase.java`

These are your integration tests — slower, may spin up real infrastructure (Testcontainers, databases, etc.).

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-failsafe-plugin</artifactId>
</plugin>
```

```
mvn failsafe:integration-test failsafe:verify   # runs Failsafe → picks up *IT.java files
```

### Why two goals, not one

`failsafe:integration-test` runs the tests. `failsafe:verify` checks the results and fails the build if any tests failed. They're intentionally split so that any cleanup code (stopping containers, etc.) can run between them — even if tests fail. Always invoke both.

---

## Why the Naming Convention Matters

The naming convention (`*Test.java` vs `*IT.java`) is the mechanism that routes each test class to the right plugin:

| File name | Picked up by | Runs during |
|---|---|---|
| `JwtServiceTest.java` | Surefire | `mvn test` |
| `AuthControllerTest.java` | Surefire | `mvn test` |
| `BackendApplicationIT.java` | Failsafe | `mvn failsafe:integration-test` |

No annotations, no configuration — the name alone determines which plugin runs it.

---

## Why Separate Them

**Speed.** Unit tests finish in seconds. Integration tests (especially Testcontainers) take 10-30 seconds for container startup. Separating them lets CI fail fast on unit test failures before spending time on the slower tests.

**Clarity.** When a test fails in CI, you immediately know whether it's a logic failure (unit test) or an infrastructure/integration failure (IT test). Mixed together, you lose that signal.

**CI stage structure.** The backend pipeline explicitly reflects this:
```
Lint → Unit tests → Integration tests → Docker build
```
Each stage has a clear job and a clear failure signal.

---

## Common Gotchas

**Failsafe must be declared in `pom.xml` to be invokable.** Unlike Surefire, Failsafe is not bound to the Maven lifecycle by default. Declaring it in the `<plugins>` block (even with no configuration beyond the declaration) makes it available. Spring Boot parent manages the version.

**`mvn verify` runs both Surefire and Failsafe.** If you want to run everything — compile, unit tests, integration tests — `mvn verify` does it in one command via the full lifecycle. The CI pipeline uses explicit goals for clarity and stage separation.

**Don't mix test types by accident.** A `@SpringBootTest` class named `SomethingTest.java` runs under Surefire — it will attempt to load the full Spring context during the unit test phase, which is slow and can fail if the environment isn't set up. Name anything that loads Spring context or uses Testcontainers with the `IT` suffix.

---

## Project Bourne Usage

- `BackendApplicationIT.java` — renamed from `BackendApplicationTests.java` in issue #11 so Failsafe picks it up instead of Surefire
- `AuthControllerTest.java`, `JwtServiceTest.java`, `JwtAuthFilterTest.java`, `AuthServiceTest.java` — pure Mockito unit tests, correctly picked up by Surefire
- CI stages in `backend.yml`:
  - `mvn test -B` — Surefire, unit tests only
  - `mvn failsafe:integration-test failsafe:verify -B` — Failsafe, integration tests only
- Integration tests use Testcontainers for the database — no GHA service container needed
