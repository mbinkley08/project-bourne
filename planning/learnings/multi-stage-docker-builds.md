# Multi-Stage Docker Builds

**Issue covered in:** #7 (Full stack — backend and frontend Dockerfiles)

---

## ELI5

A normal Docker image is like a kitchen that still has all the cooking equipment, raw ingredients, and mess still sitting around after the meal is served. A multi-stage build is like cooking in one kitchen, plating the food, and then moving just the finished plate to a clean dining room. The Docker image you actually run only contains what's needed to *run* the app — not what was needed to *build* it.

---

## The Problem with Single-Stage Builds

If you build a Java app in a single Dockerfile:

```dockerfile
FROM maven:3.9-eclipse-temurin-21
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package
ENTRYPOINT ["java", "-jar", "target/app.jar"]
```

Your final image includes:
- The full Maven installation (~500MB)
- All downloaded Maven dependencies
- Source code
- The JDK (compiler + runtime)

Just to run a `.jar` file. You only need the JRE.

---

## How Multi-Stage Builds Work

You use multiple `FROM` statements. Each one starts a new stage. The final stage is what becomes the image. You can `COPY --from=<stage>` to pull specific files out of earlier stages.

```dockerfile
# Stage 1: Build
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn package -DskipTests -B

# Stage 2: Run — only the JRE, only the jar
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
```

The final image is based on `eclipse-temurin:21-jre-jammy` (JRE only, ~200MB) with a single `.jar` file copied in. Maven, the JDK, source code, and all build artifacts are gone.

---

## Project Bourne Examples

### Backend (Java/Maven → JRE)

```dockerfile
FROM maven:3.9-eclipse-temurin-21 AS build   # full build tools
# ... dependency download, compile, package

FROM eclipse-temurin:21-jre-jammy            # slim runtime only
COPY --from=build /app/target/*.jar app.jar
```

**Why:** Maven + JDK is ~600MB. The JRE alone is ~200MB. The `.jar` is a few MB. No reason to ship the compiler.

**Dependency caching trick:** `COPY pom.xml .` then `RUN mvn dependency:go-offline` *before* copying source code. Docker caches each layer. If only source files change (not `pom.xml`), the dependency download layer is reused — build is much faster.

### Frontend (Node/Vite → nginx)

```dockerfile
FROM node:20-alpine AS build     # Node to compile TypeScript + bundle
# ... npm ci, npm run build → produces /app/dist

FROM nginx:alpine                # nginx to serve static files
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
```

**Why:** Node + npm packages is hundreds of MB. The compiled frontend is just HTML, CSS, and JS files. nginx serves those files and is tiny (~25MB). No Node runtime needed in production.

---

## Key Benefits

| Benefit | Why it matters |
|---|---|
| Smaller images | Less to push/pull, faster deploys, lower storage costs |
| No build tools in production | Maven, npm, compilers can't be exploited if they're not there |
| Faster CI | Layer caching means only changed layers are rebuilt |
| Cleaner separation | Build environment and runtime environment are explicitly separate |

---

## Layer Caching — The Optimization to Know

Docker caches each layer. A layer is only rebuilt if it or anything before it changed. This means **order matters**.

Put things that change rarely at the top, things that change often at the bottom:

```dockerfile
COPY pom.xml .                        # changes rarely → cache this
RUN mvn dependency:go-offline -B      # expensive → only re-runs when pom.xml changes
COPY src ./src                        # changes constantly → always rebuilds from here down
RUN mvn package -DskipTests -B
```

If you copied source first and then downloaded dependencies, *every single code change* would trigger a full dependency re-download. Ordering the steps correctly makes iterative builds fast.
