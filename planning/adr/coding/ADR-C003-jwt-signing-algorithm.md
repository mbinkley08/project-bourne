# ADR-C003 — JWT Signing Algorithm: RS256 over HS256

**Date:** 2026-04-07
**Status:** Accepted

## Decision

JWTs issued by the Core API will be signed using **RS256** (RSA signature with SHA-256), not HS256 (HMAC with SHA-256).

## Context

When implementing the auth skeleton (issue #10), a signing algorithm needed to be chosen for JWTs issued after Google OAuth2 authentication completes. The two common choices are HS256 (symmetric) and RS256 (asymmetric). This decision was made deliberately before implementation rather than defaulting to whichever was simpler to wire up.

## Alternatives Considered

**HS256 — symmetric HMAC**
A single secret key both signs and verifies tokens. Simpler to implement — one secret, one value in Secrets Manager.

Rejected. The shared-secret model has two meaningful weaknesses:

1. **No separation of signing and verification.** Any component that can verify a token can also forge one. If the secret is ever needed by a second service for verification, you've distributed signing capability.
2. **Secret rotation is a breaking change.** Rotating the signing key immediately invalidates all active sessions. There is no graceful transition period without additional engineering.

HS256 is acceptable for throwaway prototypes. It is not the production standard for systems where user sessions and credential security matter.

**RS256 — asymmetric RSA**
A private key signs tokens. A public key verifies them. The private key never leaves the backend.

Accepted.

## Reasoning

RS256 is the industry standard for production JWT auth for well-established reasons:

- **The private key never needs to be distributed.** Only the Core API can issue tokens. Any future service that needs to verify tokens only needs the public key — which carries no signing capability.
- **Key rotation can be done gracefully.** A new key pair can be introduced alongside the old one (via a JWK Set), allowing active sessions to continue while new tokens use the new key. HS256 has no equivalent mechanism.
- **Defense in depth.** Even if a verification component is compromised, the attacker cannot forge tokens without the private key.
- **It is what every major identity provider uses.** Google, GitHub, Auth0, Okta — all RS256. Building to the same standard means our auth layer is immediately recognizable and auditable by any security reviewer.

## Tradeoffs

- Slightly more complex to set up than HS256 — requires generating and managing a key pair rather than a single secret.
- RSA signing is marginally slower than HMAC at the CPU level. This is irrelevant in practice — auth token issuance happens once per login, not on every request.
- Two secrets to manage (`JWT_PRIVATE_KEY`, `JWT_PUBLIC_KEY`) instead of one (`JWT_SECRET`). Accepted.

## Implementation Notes

- Key pair: RSA 2048-bit minimum. 4096-bit acceptable for higher assurance.
- Private key: stored in AWS Secrets Manager in production, `.env` locally (gitignored). Never committed to source control.
- Public key: stored in AWS Secrets Manager alongside the private key for consistency. Could be distributed publicly in a future `/auth/.well-known/jwks.json` endpoint if third-party token verification is ever needed.
- Library: `NimbusJwtEncoder` (RS256) and `NimbusJwtDecoder.withPublicKey()` via `spring-security-oauth2-jose`, already a dependency.
- Key format: PEM (PKCS#8 for private, X.509 for public). Injected as environment variables. Zero application code differences between local and production environments.
