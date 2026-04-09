# ADR-C004 — Checkstyle + SpotBugs for lint and static analysis
**Date:** 2026-04-09
**Status:** Accepted

## Decision
Use two tools for the backend CI lint and static analysis stage: Checkstyle (lint) and SpotBugs (static analysis). Run them together as a single CI step: `mvn compile checkstyle:check spotbugs:check -B`. Use a custom `checkstyle.xml` rather than a built-in ruleset.

## Context
Issue #11 required a "lint + static analysis" stage in the backend CI pipeline. These are two distinct concerns: lint enforces stylistic consistency; static analysis finds actual bugs. A single tool doesn't cover both well.

Three options were on the table: Checkstyle only, SpotBugs only, or both. PMD was also considered as an alternative to SpotBugs.

## Alternatives Considered

**Checkstyle only:** Fast and widely adopted, but catches only style issues. No bug detection. "Lint + static analysis" as a single stage label would be misleading if only lint ran.

**SpotBugs only:** Finds real bugs and security issues, which is high-value signal. But doesn't enforce code style or import hygiene — star imports and naming violations would go undetected.

**PMD instead of SpotBugs:** PMD catches code quality issues (dead code, excessive complexity, empty catch blocks). Useful, but overlaps more with code review than bug detection. SpotBugs has a stronger record for catching correctness and security issues at the bytecode level.

**Google style (`google_checks.xml`):** Mandates 2-space indentation, which most Java developers don't use and which conflicts with IntelliJ defaults. Also generates Javadoc violations on every public method, which is noise for an application (not a library).

**Sun checks (`sun_checks.xml`):** Built-in, but also enforces Javadoc on public methods. Too noisy for an application project without extensive suppression configuration.

## Reasoning
Both tools are needed because they cover different ground and together they accurately fulfill the "lint + static analysis" requirement. Checkstyle enforces consistency; SpotBugs enforces correctness. A custom `checkstyle.xml` avoids Javadoc noise while keeping the rules that add genuine value: naming conventions, no star imports, no unused imports, always use braces, proper long literals.

SpotBugs at `effort=Default`, `threshold=High` gives real signal without false positive noise, and it's a stronger portfolio signal than PMD because it catches actual bugs.

## Tradeoffs
- Two plugins add a small amount of configuration overhead vs. one.
- SpotBugs requires compilation before it can run, so `compile` must precede it in the CI step. This adds a few seconds but is unavoidable.
- Custom `checkstyle.xml` requires maintenance if new rules are needed in the future.
- At `threshold=High`, SpotBugs may miss medium-severity issues. This is intentional for now — threshold can be lowered as the codebase matures and the team gains confidence in the signal-to-noise ratio.
