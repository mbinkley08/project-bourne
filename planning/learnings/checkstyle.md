# Checkstyle

**Issue covered in:** #11 (backend CI — lint stage)

---

## ELI5

Checkstyle is a Java tool that reads your source code and checks it against a set of style rules — things like naming conventions, import hygiene, and whether you always use braces. It doesn't run your code or look for bugs. It's a style enforcer.

---

## What It Catches (and What It Doesn't)

**Catches:**
- Star imports (`import com.example.*`)
- Unused imports
- Naming convention violations (class names, method names, variable names)
- Missing braces on control structures
- Long lines, trailing whitespace, tab characters

**Does NOT catch:**
- Bugs
- Null pointer risks
- Logic errors
- Performance problems

Checkstyle is lint — it keeps the codebase consistent and readable. For actual bug detection, that's SpotBugs.

---

## Configuration

Checkstyle runs from a config file — either a built-in one (`sun_checks.xml`, `google_checks.xml`) or a custom file you provide. Built-in configs cover many rules including Javadoc requirements, which are excessive for an application (vs. a library). A custom config lets you pick exactly what to enforce.

### Common rules used in Project Bourne

| Rule | What it checks |
|---|---|
| `AvoidStarImport` | No `import com.example.*` — every import must be explicit |
| `UnusedImports` | No imports that aren't referenced in the file |
| `NeedBraces` | `if`, `for`, `while`, `do` must always use `{}` — no single-line bodies |
| `UpperEll` | Long literals use `L` not `l` (e.g., `86400L` not `86400l`) |
| `TypeName` | Class/interface/enum names follow `UpperCamelCase` |
| `MethodName` | Method names follow `lowerCamelCase` |

### Why avoid star imports

Star imports hide where a class comes from. When you read `Jwt jwt = ...`, you want to see `import org.springframework.security.oauth2.jwt.Jwt` — not `import org.springframework.security.oauth2.jwt.*` — because it's immediately clear what package it came from. It also prevents accidental shadowing when two packages export the same class name.

### Why NeedBraces

Single-line `if` bodies are a common source of bugs:
```text
if (token == null)
    return null;
    doSomethingElse();  // always executes — not inside the if
```
Requiring braces eliminates this class of mistake entirely.

---

## Maven Plugin

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.4.0</version>
    <configuration>
        <configLocation>checkstyle.xml</configLocation>
        <consoleOutput>true</consoleOutput>
        <failsOnError>true</failsOnError>
    </configuration>
</plugin>
```

Run in CI: `mvn checkstyle:check -B`

`consoleOutput: true` — prints violations directly to the build log (not just a report file).
`failsOnError: true` — any violation fails the build.

---

## Common Gotchas

**Checkstyle runs on source, not bytecode.** Lombok-generated code is invisible to Checkstyle — it only sees what you typed. This is usually fine, but it means Checkstyle won't flag issues in generated getters/setters/builders.

**Built-in Sun/Google configs require Javadoc on public methods.** For an application (not a library), this is noise. Use a custom config file to include only the rules that add value.

**`consoleOutput` vs report file.** Without `consoleOutput: true`, violations are written to `target/checkstyle-result.xml` — you'd have to open the file to see what failed. Always set `consoleOutput: true` in CI.

---

## Project Bourne Usage

- Custom `checkstyle.xml` at `backend/checkstyle.xml` — minimal ruleset, no Javadoc requirements
- Run as the first stage of backend CI: `mvn compile checkstyle:check spotbugs:check -B`
- `compile` runs before `checkstyle:check` in the same command so bytecode is available for SpotBugs in the same step
- Violations found and fixed in issue #11: star imports in `JwtService`, `User`, `AuthController`; missing braces in `JwtAuthFilter`
