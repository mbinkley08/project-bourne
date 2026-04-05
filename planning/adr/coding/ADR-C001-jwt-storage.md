# ADR-C001 — JWT Storage: httpOnly Cookie vs localStorage
**Date:** 2026-04-05
**Status:** Accepted

## Decision
Store JWTs in **httpOnly cookies**, not localStorage or sessionStorage.

## Context
After the OAuth2 flow with Google completes, the Core API issues a signed JWT to authenticate subsequent requests. That token must be stored somewhere in the browser so it can be sent with every API call. The two common options are localStorage and httpOnly cookies.

This is a security decision with a clear correct answer. It was documented here because it is commonly implemented wrong — even by experienced developers — and the reasoning is worth making explicit.

## Alternatives Considered

**localStorage:**
Simple to implement. The token is stored in `localStorage` and attached to API requests via an `Authorization: Bearer` header in JavaScript.

Rejected because: localStorage is accessible to any JavaScript running on the page. A successful XSS (cross-site scripting) attack — injecting malicious JavaScript through an unsanitized input, a compromised third-party script, or a browser extension — can read `localStorage` and steal the token. The attacker now has a valid session token and can impersonate the user until it expires. This is a well-documented attack vector and the reason OWASP recommends against storing tokens in localStorage.

**sessionStorage:**
Same security properties as localStorage — accessible to JavaScript. Same rejection reason.

## Reasoning
An httpOnly cookie is set by the server with the `HttpOnly` flag. This flag tells the browser: **do not allow JavaScript to access this cookie.** It cannot be read by `document.cookie`. It cannot be accessed by `localStorage` APIs. A successful XSS attack cannot steal it.

The cookie is still sent automatically by the browser on every request to the same domain — so the authentication flow works identically from the frontend's perspective. The difference is purely about what JavaScript can access, and the answer with httpOnly is: nothing.

The tradeoff is that httpOnly cookies require the backend to handle cookie issuance and require CSRF protection for state-changing requests (since cookies are sent automatically, a malicious site can trigger requests that carry the cookie). CSRF tokens or the `SameSite=Strict` cookie attribute address this.

**Summary of the security model:**
- XSS steals localStorage tokens. XSS cannot steal httpOnly cookie tokens.
- CSRF can abuse httpOnly cookies. `SameSite=Strict` prevents CSRF for same-origin flows.
- The combination of httpOnly + SameSite=Strict is the correct, defense-in-depth approach.

## Tradeoffs
- httpOnly cookies require the server to set and clear them explicitly. Logout must call a backend endpoint that clears the cookie — the frontend cannot do it unilaterally.
- Mobile apps and non-browser clients cannot use cookies easily. If Project Bourne ever adds a mobile client or a public API, a separate token delivery mechanism would be needed for those consumers.
- Slightly more complex to implement than dropping a token in localStorage. Worth it.
