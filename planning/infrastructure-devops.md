# Infrastructure & DevOps — Project Bourne

---

## Secrets Management

### Local Development

**Port assignment:** Project Bourne runs on port **3001**. ScoreLab occupies port 3000 (Google OAuth is configured for 3000). Project Bourne's docker-compose maps the frontend to `3001:80` accordingly.

All secrets are stored in a `.env` file at the repo root. Docker Compose reads this file automatically. `.env` is gitignored — `.env.example` documents every required variable with instructions for generating values.

Required secrets for local dev:
- `GOOGLE_CLIENT_ID` / `GOOGLE_CLIENT_SECRET` — OAuth2 credentials from Google Cloud Console
- `JWT_PRIVATE_KEY` / `JWT_PUBLIC_KEY` — RS256 keypair, base64-encoded DER (generation instructions in `.env.example`)
- `ANTHROPIC_API_KEY` — Anthropic Console

### Production

All secrets are stored in **AWS Secrets Manager**. No secrets are stored in environment files, Docker images, or source code in production.

Each secret is a named entry in Secrets Manager. The application retrieves values at startup via the AWS SDK or via ECS task definition secret injection (the preferred approach — ECS fetches the secret from Secrets Manager and injects it as an environment variable into the container at launch, so the application code itself has no AWS dependency).

| Secret Name (Secrets Manager) | Environment Variable | Notes |
|-------------------------------|----------------------|-------|
| `project-bourne/google-client-id` | `GOOGLE_CLIENT_ID` | OAuth2 |
| `project-bourne/google-client-secret` | `GOOGLE_CLIENT_SECRET` | OAuth2 |
| `project-bourne/jwt-private-key` | `JWT_PRIVATE_KEY` | RS256 signing |
| `project-bourne/jwt-public-key` | `JWT_PUBLIC_KEY` | RS256 verification |
| `project-bourne/anthropic-api-key` | `ANTHROPIC_API_KEY` | AI service |
| `project-bourne/db-url` | `DB_URL` | RDS connection string |
| `project-bourne/db-username` | `DB_USERNAME` | RDS credentials |
| `project-bourne/db-password` | `DB_PASSWORD` | RDS credentials |
| `project-bourne/frontend-url` | `FRONTEND_URL` | Post-OAuth redirect target |

**Rotation:** DB credentials and the Anthropic API key are candidates for automatic rotation via Secrets Manager rotation policies. JWT keys can be rotated manually with a brief dual-key window (old public key kept active until all outstanding tokens expire).

**IAM:** Each ECS task role has a least-privilege IAM policy granting `secretsmanager:GetSecretValue` only for the specific secrets that service needs. The backend task role cannot read the Anthropic key; the AI service task role cannot read the JWT keys.

---

*Additional sections (hosting, CI/CD pipelines, environments, IaC) will be filled in during Phase 6.*
