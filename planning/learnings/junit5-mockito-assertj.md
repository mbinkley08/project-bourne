# JUnit 5 + Mockito + AssertJ

**Issue covered in:** #10 (auth/JWT implementation, unit tests)

---

## ELI5

These three libraries are the standard Java unit testing stack:
- **JUnit 5** — the test runner; defines how tests are discovered and executed
- **Mockito** — creates fake versions of dependencies so you can test one class in isolation
- **AssertJ** — fluent assertion library; makes test failure messages readable and assertions feel natural

They're almost always used together. Spring Boot Test includes all three automatically.

---

## JUnit 5

### Annotations

| Annotation | What it does |
|---|---|
| `@Test` | Marks a method as a test |
| `@BeforeEach` | Runs before every test in the class |
| `@AfterEach` | Runs after every test in the class |
| `@BeforeAll` | Runs once before all tests (method must be `static`) |
| `@AfterAll` | Runs once after all tests (method must be `static`) |
| `@ExtendWith(X.class)` | Wires in an extension (e.g., Mockito, Spring) |
| `@DisplayName("...")` | Custom name shown in test results |

### `@ExtendWith(MockitoExtension.class)`
Activates Mockito's JUnit 5 integration. Required when using `@Mock` and `@InjectMocks` annotations. Without it, those annotations do nothing.

```java
@ExtendWith(MockitoExtension.class)
class MyServiceTest {
    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private UserService userService;
}
```

---

## Mockito

### What it does
Creates fake ("mock") implementations of interfaces and classes. You define what a mock should return when called, then verify it was called the way you expected.

### Core annotations

| Annotation | What it does |
|---|---|
| `@Mock` | Creates a mock of the type — all methods return null/0/false by default |
| `@InjectMocks` | Creates a real instance of the class and injects `@Mock` fields into it |
| `@Spy` | Creates a real instance but lets you override specific methods |

### Stubbing: `when().thenReturn()`
Tell a mock what to return when called with specific arguments.

```java
when(userRepository.findById(userId)).thenReturn(Optional.of(user));
when(jwtService.validateToken("bad-token")).thenThrow(new JwtException("invalid"));
```

### Verifying: `verify()`
Assert that a method was called (or wasn't called) with specific arguments.

```java
verify(chain).doFilter(request, response);           // called exactly once
verify(jwtService, never()).validateToken(any());    // never called
verifyNoInteractions(jwtService);                    // no methods called at all
```

### Argument matchers
```java
verify(repo).findById(any(UUID.class));   // any UUID
when(service.process(eq("x"))).thenReturn(result);  // specific value
```

---

## AssertJ

### Why not `assertEquals`?
JUnit's built-in assertions (`assertEquals`, `assertTrue`) work but produce poor failure messages. AssertJ's fluent API reads like English and shows exactly what went wrong.

```java
// JUnit — failure says "expected <true> but was <false>"
assertTrue(response.getBody().containsKey("email"));

// AssertJ — failure says "Expecting map to contain key: 'email' but actual map was: {id=...}"
assertThat(response.getBody()).containsKey("email");
```

### Common assertions

```java
assertThat(token).isNotBlank();
assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
assertThat(list).hasSize(3).contains("x");
assertThat(map).containsEntry("email", "test@example.com");
assertThat(instant).isAfter(otherInstant);

// Exception assertions
assertThatThrownBy(() -> service.doThing())
    .isInstanceOf(JwtException.class)
    .hasMessageContaining("expired");

assertThatNoException().isThrownBy(() -> service.validateToken(token));
```

---

## `ReflectionTestUtils.setField`

Spring beans often have `@Value` fields injected by the container at runtime:
```java
@Value("${jwt.expiration-seconds:86400}")
private long expirationSeconds;
```

In a pure unit test (no Spring context), there's no container to inject these. `ReflectionTestUtils.setField` lets you inject them by reflection:

```java
ReflectionTestUtils.setField(jwtService, "expirationSeconds", 86400L);
```

**When to use:** Unit tests that create the object directly (not via Spring context). If you're writing a `@SpringBootTest`, Spring handles injection normally — you don't need this.

---

## Test Structure Pattern

```java
@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthService authService;

    @Test
    void findOrCreateUser_existingUser_returnsExisting() {
        // Arrange
        User existing = new User();
        when(userRepository.findByGoogleId("google-123")).thenReturn(Optional.of(existing));

        // Act
        User result = authService.findOrCreateUser(mockOAuth2User());

        // Assert
        assertThat(result).isEqualTo(existing);
        verify(userRepository, never()).save(any());
    }
}
```

---

## Common Gotchas

**`@InjectMocks` creates the object — you can't also instantiate it yourself.** If you call `new MyService()` and also use `@InjectMocks`, you'll have two instances and the mocks won't be in the one you're testing.

**`when()` must be called before the test action.** The stub setup goes in `@BeforeEach` or at the start of the test — not after the method you're testing.

**`verifyNoInteractions` fails if any method was called.** Use `verifyNoMoreInteractions` if you've already verified some calls and just want to ensure nothing else happened.

---

## Project Bourne Usage

Unit tests follow this layout:
```
src/
  main/java/com/projectbourne/backend/service/JwtService.java
  test/java/com/projectbourne/backend/service/JwtServiceTest.java
```

Test class lives in the same package path under `test/` as the production class under `main/`. This is the standard Maven project structure and allows tests to access package-private members.
