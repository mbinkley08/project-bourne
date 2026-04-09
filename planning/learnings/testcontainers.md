# Testcontainers

**Issue covered in:** #10 (BackendApplicationTests)

---

## ELI5

Testcontainers is a Java library that starts real Docker containers during your tests. Instead of mocking your database (which can hide real bugs), it spins up an actual PostgreSQL container, runs your tests against it, and shuts it down when done. No separate test database to manage — it's all automatic.

---

## Why Real Containers Instead of Mocks

Mocking the database is tempting because it's fast. But mocks lie. A mocked repository will happily accept queries that would fail on a real database — wrong column names, constraint violations, bad SQL. If the mock passes but the real DB fails, you've wasted everyone's time.

Testcontainers gives you:
- Real PostgreSQL with real constraint enforcement
- Real Flyway migrations run against the test schema
- Confidence that what passes in CI will pass in production

The tradeoff is speed — container startup adds ~5–10 seconds. For integration tests, that's fine.

---

## Core Annotations

### `@Testcontainers`
Activates the Testcontainers JUnit 5 extension on the test class. Manages container lifecycle (start/stop) automatically.

```java
@Testcontainers
class BackendApplicationTests { ... }
```

### `@Container`
Declares a container field. If `static`, the container starts once for all tests in the class (faster). If non-static, it starts fresh for each test (slower, more isolated).

```java
@Container
static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
        .withDatabaseName("projectbourne_test")
        .withUsername("postgres")
        .withPassword("postgres");
```

---

## Wiring the Container into Spring Boot

The container picks a **random port** on the host. Spring's datasource config needs that port — but it's not known until the container starts. `@DynamicPropertySource` solves this.

### `@DynamicPropertySource`
Runs before the Spring ApplicationContext starts and registers properties dynamically. The container is already running at this point, so `postgres.getJdbcUrl()` returns the real URL with the real port.

```java
@DynamicPropertySource
static void configureDataSource(DynamicPropertyRegistry registry) {
    registry.add("spring.datasource.url", postgres::getJdbcUrl);
    registry.add("spring.datasource.username", postgres::getUsername);
    registry.add("spring.datasource.password", postgres::getPassword);
}
```

These dynamic properties override whatever's in `application.yml` or `application-test.yml`.

### Spring Boot Property Precedence (highest to lowest)
1. Command-line arguments
2. `@DynamicPropertySource` / `@TestPropertySource`
3. OS environment variables
4. `application-{profile}.yml`
5. `application.yml`

This is why `@DynamicPropertySource` wins even if a static URL is hardcoded in a YAML file.

---

## Full Example

```java
@SpringBootTest
@ActiveProfiles("test")
@Testcontainers
class BackendApplicationTests {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine")
            .withDatabaseName("projectbourne_test")
            .withUsername("postgres")
            .withPassword("postgres");

    @DynamicPropertySource
    static void configureDataSource(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Test
    void contextLoads() {
        // If Spring context starts without errors, the test passes
    }
}
```

---

## Running Locally (Windows Docker limitation)

Testcontainers needs Docker. On Windows with IntelliJ, it works fine because IntelliJ connects to Docker Desktop directly.

Running `mvn test` inside a Docker container (as part of a multi-stage build or manual `docker run`) fails because the container can't reach Docker to spin up child containers — this is the Docker-in-Docker problem. Don't try to run Testcontainers tests inside a Docker container locally. Run them through IntelliJ or CI (GitHub Actions has Docker available by default).

---

## Common Gotchas

**Generic type `?` in `PostgreSQLContainer<?>`** — The `<?>` is required to avoid compiler warnings. The container class is generic to allow method chaining.

**`static` container = shared across all tests in the class.** This is almost always what you want for performance. A non-static container restarts for every test method.

**Flyway runs automatically.** If Flyway is on the classpath and Testcontainers provides the datasource, Flyway will run all your migrations against the test container before tests execute. This is the correct behavior — your tests run against the same schema as production.

---

## Project Bourne Usage

- `BackendApplicationTests` uses `@Testcontainers` with a static `PostgreSQLContainer` — one container per test class run
- `@ActiveProfiles("test")` loads `application-test.yml` which provides JWT keys; Testcontainers provides the datasource via `@DynamicPropertySource`
- The CI backend workflow (`backend.yml`) also declares a Postgres `service:` container — this is redundant because Testcontainers handles it, but harmless
