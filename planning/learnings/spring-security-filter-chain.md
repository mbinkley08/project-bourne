# Spring Security Filter Chain

**Issue covered in:** #10 (JwtAuthFilter, SecurityConfig)

---

## ELI5

Every HTTP request that hits a Spring Boot app passes through a chain of filters before reaching your controller. Spring Security adds its own filters to this chain to handle authentication, authorization, session management, CSRF, etc. You can insert your own custom filters anywhere in that chain — before, after, or in place of the built-in ones.

---

## How the Filter Chain Works

1. Request comes in
2. It passes through Filter 1 → Filter 2 → Filter 3 → ... → Filter N
3. Each filter can: let it pass, modify it, or stop it entirely (e.g., return 401)
4. At the end, the request reaches the Dispatcher Servlet → your controller

Spring Security installs ~15 built-in filters. You configure which ones are active and in what order.

---

## `SecurityFilterChain` Bean

Replaces the old `WebSecurityConfigurerAdapter` (deprecated in Spring Security 5.7). You declare a `@Bean` method that configures `HttpSecurity` and returns a `SecurityFilterChain`.

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/health").permitAll()
                .anyRequest().authenticated()
            )
            .csrf(csrf -> csrf.disable());
        return http.build();
    }
}
```

---

## Inserting a Custom Filter

### `OncePerRequestFilter`
The base class for custom filters. Guarantees your filter runs exactly once per request (not multiple times if request is forwarded internally).

```java
@Component
public class JwtAuthFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {

        // your logic here

        filterChain.doFilter(request, response);  // always call this to continue the chain
    }
}
```

### Registering the custom filter
```java
http.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
```

`addFilterBefore` places your filter immediately before the named built-in filter. The JWT filter runs before Spring's own auth filter, so by the time Spring's filter runs, authentication is already set in the context.

Other positioning methods:
- `addFilterAfter(filter, position)` — runs after the named filter
- `addFilterAt(filter, position)` — runs at the same position (replaces it)

---

## `SecurityContextHolder`

Holds the current user's authentication for the duration of the request. It's thread-local — each request thread has its own context.

```java
// Set authentication (in your filter, after validating JWT)
SecurityContextHolder.getContext().setAuthentication(
    new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities())
);

// Read authentication (in your controller)
Authentication auth = SecurityContextHolder.getContext().getAuthentication();
```

**Why it's thread-local matters for tests.** Because it's tied to the current thread, if a test sets authentication in the security context and doesn't clean it up, the next test on the same thread inherits it. This causes test pollution — tests that should fail (no auth) start passing because a previous test left auth in place.

### Always clean up in tests

```java
@AfterEach
void clearSecurityContext() {
    SecurityContextHolder.clearContext();
}
```

This is not optional. Skip it and you'll have flaky tests that pass or fail depending on execution order.

---

## `UsernamePasswordAuthenticationToken`

A general-purpose `Authentication` implementation. Used to represent a logged-in user in the security context. Takes three arguments: principal (the user object), credentials (password — null if using JWT), and authorities (roles/permissions).

```java
new UsernamePasswordAuthenticationToken(user, null, List.of())
```

Spring checks `isAuthenticated()` by whether authorities were provided. Passing an empty list counts as authenticated (the list is non-null). Passing `null` as authorities creates an unauthenticated token.

---

## Common Gotchas

**Calling `filterChain.doFilter()` is mandatory.** If you don't call it, the request stops at your filter and never reaches the controller. Even when your filter does nothing (no token found), you must call it.

**CSRF and stateless APIs.** CSRF protection is designed for browser-based session apps. For a stateless JWT API, disable it — CSRF attacks don't apply when you're not using session cookies for auth.

```java
.csrf(csrf -> csrf.disable())
```

**`SessionCreationPolicy`** — For JWT-based auth, you still need sessions because OAuth2 login flow uses the session to store state during the redirect. Use `IF_REQUIRED` (creates sessions when needed) rather than `STATELESS` if you're mixing OAuth2 with JWT.

---

## Project Bourne Usage

- `JwtAuthFilter` extends `OncePerRequestFilter`, reads the `auth_token` cookie, validates the JWT, and sets the user in `SecurityContextHolder`
- Registered with `addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)`
- `/health` and `/auth/logout` are permitted without authentication (`permitAll()`)
- All other endpoints require authentication
- `JwtAuthFilterTest` has `@AfterEach SecurityContextHolder.clearContext()` to prevent test pollution
