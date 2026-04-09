# Spring Test Profiles and Property Precedence

**Issue covered in:** #10 (application-test.yml, BackendApplicationTests, CI)

---

## ELI5

Spring Boot can load different config files depending on the active "profile." In tests you activate a `test` profile, which loads `application-test.yml` on top of (and overriding) `application.yml`. This lets you provide test-specific values — like hardcoded credentials — without touching production config.

---

## How Profiles Work

### The base config
`application.yml` — always loaded, regardless of profile. Contains the app's general config and typically uses `${ENV_VAR}` placeholders for secrets.

```yaml
# application.yml
jwt:
  private-key: ${JWT_PRIVATE_KEY}
  public-key: ${JWT_PUBLIC_KEY}
spring:
  datasource:
    url: ${DB_URL}
```

### Profile-specific config
`application-{profile}.yml` — loaded in addition to the base config when that profile is active. Any key it defines **overrides** the same key from the base config.

```yaml
# application-test.yml
jwt:
  private-key: MIIEvgIBADA...   # literal test key, no ${...} placeholder
  public-key: MIIBIjANBg...    # literal test key
```

When `application-test.yml` sets `jwt.private-key` to a literal value, Spring uses that value directly. It never tries to resolve `${JWT_PRIVATE_KEY}` because the test YAML has already satisfied the property.

### Activating a profile in tests

```java
@SpringBootTest
@ActiveProfiles("test")
class BackendApplicationTests { ... }
```

---

## Spring Boot Property Precedence

When multiple sources provide the same property, Spring uses the highest-priority source. From highest to lowest:

| Priority | Source |
|---|---|
| 1 (highest) | Command-line arguments |
| 2 | `@DynamicPropertySource` / `@TestPropertySource` |
| 3 | OS environment variables |
| 4 | `application-{profile}.yml` (profile-specific) |
| 5 | `application.yml` (base) |

**Key insight:** `@DynamicPropertySource` (used by Testcontainers) beats environment variables. So even if an env var like `DB_URL` is set in CI, Testcontainers' dynamic property will win.

---

## The Test Profile Secrets Pattern

The test profile provides its own secrets directly in `application-test.yml`, committed to the repo. This is safe and intentional if:

1. The keys are **test-only** — never used in production
2. The keys are **generated specifically for testing** — not dev or prod keys
3. The file is clearly marked as test-only

```yaml
# application-test.yml — committed to repo, safe because these are test-only keys
jwt:
  private-key: MIIEvgIBADA...   # test RSA private key, never used in prod
  public-key: MIIBIjANBg...     # test RSA public key, never used in prod
  expiration-seconds: 3600
```

**Why this matters for CI:** CI never needs `JWT_PRIVATE_KEY` or `JWT_PUBLIC_KEY` env vars set as secrets. The test profile provides them. The fewer secrets CI needs to manage, the simpler and more secure the pipeline.

---

## What This Means for CI Config

Bad pattern (leak-prone, brittle):
```yaml
# backend.yml (GitHub Actions)
env:
  JWT_PRIVATE_KEY: ${{ secrets.JWT_PRIVATE_KEY }}   # unnecessary
  JWT_PUBLIC_KEY: ${{ secrets.JWT_PUBLIC_KEY }}     # unnecessary
```

Correct pattern:
```yaml
# backend.yml — only what CI actually needs that isn't in test config
env:
  GOOGLE_CLIENT_ID: test-client-id
  GOOGLE_CLIENT_SECRET: test-client-secret
```

Google OAuth2 credentials are needed because Spring validates them at startup (fail-fast behavior). JWT keys are not needed in CI because `application-test.yml` provides them.

---

## Common Gotchas

**`${PLACEHOLDER}` in base YAML with no fallback** — If `application.yml` has `${JWT_PRIVATE_KEY}` and neither an env var nor a profile override satisfies it, Spring throws:
```
java.lang.IllegalArgumentException: Could not resolve placeholder 'JWT_PRIVATE_KEY'
```
The test profile override prevents this — it satisfies the property before Spring tries to resolve the placeholder.

**Profiles stack, not replace.** `application-test.yml` does not replace `application.yml` — it adds to it and overrides matching keys. Both files are loaded. Properties only in the base config are still available.

**Multiple active profiles.** You can activate more than one profile: `@ActiveProfiles({"test", "local"})`. Spring loads `application-test.yml` and `application-local.yml`, with the last one winning on conflicts.

---

## Project Bourne Usage

- `@ActiveProfiles("test")` used on `BackendApplicationTests`
- `application-test.yml` provides JWT test keys (safe to commit — test-only keys)
- `@DynamicPropertySource` in Testcontainers provides the datasource URL, overriding anything in YAML
- CI workflow only needs `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` env vars — all other test secrets come from the test profile
