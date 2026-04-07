# Spring Boot OAuth2 Startup Validation

**Issue covered in:** #7 (Full stack — backend container crash on startup)

---

## ELI5

When a Spring Boot app starts up, it doesn't just launch and wait for requests — it validates its own configuration first. If OAuth2 is configured but the client ID is blank, Spring refuses to start entirely. It's not a runtime error you'd see when a user tries to log in; it's a startup error before the app is even ready to serve a single request.

---

## What Happened

The backend `docker-compose.yml` defines:

```yaml
environment:
  GOOGLE_CLIENT_ID: ${GOOGLE_CLIENT_ID}
  GOOGLE_CLIENT_SECRET: ${GOOGLE_CLIENT_SECRET}
```

Without a `.env` file, Compose substitutes blank strings. The backend received:
- `GOOGLE_CLIENT_ID` = `""`
- `GOOGLE_CLIENT_SECRET` = `""`

`application.yml` passes these to Spring's OAuth2 auto-configuration:

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          google:
            client-id: ${GOOGLE_CLIENT_ID}
            client-secret: ${GOOGLE_CLIENT_SECRET}
```

Spring's `OAuth2ClientProperties` runs `afterPropertiesSet()` during application context startup, which calls `validate()`, which checks that `client-id` is not empty. It wasn't — it was blank. Spring threw:

```
Caused by: java.lang.IllegalStateException: Client id must not be empty.
```

The application context failed to initialize and the process exited with code 1.

---

## Why Spring Validates at Startup (Not at Request Time)

This is a core Spring Boot design principle: **fail fast**. It's better to crash immediately with a clear error than to start up successfully, appear healthy, and then fail the moment a user tries to authenticate.

Spring's auto-configuration classes use `@ConfigurationProperties` beans that implement `InitializingBean` (or `afterPropertiesSet()`). These run during the application context refresh — before the server starts listening on any port. If validation fails, the whole startup is aborted.

This is why:
- The container showed `Up 0 seconds` then immediately `Exited (1)`
- The health check never even had a chance to run
- The logs showed the full stack trace immediately

---

## The Fix — .env File with Placeholder Values

Created a `.env` file in the project root with non-empty placeholder values:

```
GOOGLE_CLIENT_ID=placeholder-client-id
GOOGLE_CLIENT_SECRET=placeholder-client-secret
JWT_SECRET=placeholder-jwt-secret-at-least-32-characters-long
ANTHROPIC_API_KEY=placeholder-anthropic-api-key
```

`placeholder-client-id` is not a valid Google OAuth2 credential, but it satisfies Spring's "must not be empty" check. The app starts. Authentication won't actually work until real credentials are provided — but that's an issue #10 problem, not a Phase 0 problem.

The `.env` file is already listed in `.gitignore`. The `.env.example` (the committed template with placeholder values and instructions) will be created as part of issue #14.

---

## Key Distinction: Missing vs Empty

Spring's behavior depends on how the value is missing:

| Scenario | application.yml | Result |
|---|---|---|
| Env var not set, no default | `${GOOGLE_CLIENT_ID}` | Spring throws `IllegalArgumentException` — can't resolve placeholder |
| Env var is blank string, no default | `${GOOGLE_CLIENT_ID}` = `""` | Spring resolves to `""`, OAuth2 validation throws `IllegalStateException` |
| Env var not set, has default | `${GOOGLE_CLIENT_ID:some-default}` | Spring uses the default — starts fine |

In our case, Compose substituted a blank string (scenario 2). Spring resolved the placeholder successfully but the downstream OAuth2 validator caught the empty value.

---

## How to Provide a Default in application.yml

If you want the app to start even without a value (for non-auth-critical properties), you can provide a default with the colon syntax:

```yaml
ai-service:
  url: ${AI_SERVICE_URL:http://localhost:8000}   # defaults to localhost if not set
```

For security-sensitive values like OAuth2 credentials, you intentionally do NOT provide a default — failing fast at startup is the correct behavior. The absence of a default is a signal: "this must be configured, there is no safe fallback."

---

## Local Dev Pattern

For local development with secrets:
1. `.env.example` is committed to git — shows all required variables with placeholder values and comments
2. `.env` is gitignored — contains real (or dev-placeholder) values, never committed
3. Developers copy `.env.example` → `.env` and fill in real values for the features they're working on

This is standard practice across most projects. Issue #14 formalizes this for Project Bourne.
