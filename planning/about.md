# About — Project Bourne

---

## The Problem

Job searching is broken — not because listings are hard to find, but because everything that matters happens after you find them.

Existing tools (LinkedIn, Indeed, Glassdoor, Teal, JobScan) either surface listings or track applications. None of them close the loop. You find a job, apply, get rejected, and have no idea why — or what to do differently next time. Skills keep appearing in postings that you don't have. Resumes get submitted without being tailored. Interviews happen without real preparation. The cycle repeats.

Worse: when you're not actively searching, there's nothing keeping you sharp. Career development between job searches is invisible and unstructured.

The result: qualified candidates get filtered out not because they can't do the work, but because the process is too fragmented, too manual, and too reactive.

---

## The Origin

This app was built from the inside out.

Before a single line of code was written, the core workflow was built and lived manually — a Claude-based job search assistant that tracked applications, analyzed skill gaps across postings, generated tailored resumes and cover letters, researched companies, and ran interview prep. Over 100 applications across multiple months.

That process worked. It also revealed exactly where the friction was, what intelligence was missing, and what a real system would need to do. This app is the productization of that lived experience — generalized for any job seeker, in any field.

---

## The User

**Primary: The Active Job Seeker**
Someone currently searching for a new role who needs more than a listing aggregator. They want to understand where they fit, why they're being passed over, and how to close the gaps — fast.

**Secondary: The Career Maintainer**
Someone who isn't searching right now but wants to stay sharp, watch the market, track in-demand skills, and be ready when the time comes. Currently completely unserved by existing tools.

**Both users share the same core need:** intelligence about the gap between where they are and where they want to be — and a clear path to close it.

---

## The Solution

A full-loop career intelligence platform. Not a job board. Not a tracker. The whole thing.

### The Loop

```
Profile → Search → Match → Apply → Track → Analyze → Learn → Prep → Repeat
```

Every step feeds the next. Rejections become data. Patterns become insights. Insights become a learning path. The learning path feeds the next application. The system gets more useful the longer you use it.

### Core Features

**1. Profile**
A structured user profile capturing background, skills (with confidence levels), experience, preferences, and career goals. The foundation everything else is built on. Not a static resume — a living document the system reads and updates.

**2. Job Search & Match Scoring**
Search across job listings with intelligent match scoring against your profile. Not keyword matching — actual fit analysis: experience match, stack match, location/remote match. See how well you fit before you decide whether to apply.

**3. Application Tracker**
Every application in one place: company, role, date, status, salary, location, required skills, gaps, confidence rating, notes. Status updates trigger downstream actions automatically (rejection → cleanup, offer → negotiation prep).

**4. Skills Gap Intelligence**
Per-role gap analysis when you apply. Aggregate gap analysis across all your applications — "TypeScript has appeared in 23 of your last 40 applications." Not just a list: a ranked, prioritized signal about what to learn next.

**5. Learning Recommendations**
When a skill gap is identified, the system surfaces learning material: curated resources, courses, documentation, practice paths. Tied to your actual gaps, not a generic curriculum. Available even when you're not actively searching — career mode keeps the learning loop running.

**6. Resume Tailoring**
Upload a base resume. Paste a job description. Get a tailored version that aligns your experience to the role's requirements — intelligently, not just keyword-stuffed. Highlights relevant strengths, reframes experience, identifies what to lead with.

**7. Cover Letter Generation**
Role-specific cover letters grounded in your profile and the job description. The narrative connects your background to the role's requirements. Drafts for review, not finished products for blind submission.

**8. Interview Prep**
Company research summaries. Role-specific behavioral questions (STAR format). Technical questions calibrated to the stack. Skill nuances to review. Things that trip people up in this type of interview. All generated from the job description and company profile — not generic.

**9. Salary & Offer Intelligence**
Market rate data for the role and location. Offer comparison against market data. Negotiation leverage points and talking points.

**10. Career Mode**
For users who aren't actively searching. Watch skill trends in the market. Track which skills are rising in demand. Maintain a learning path without a job search attached. Stay ready.

---

## What Makes It Different

| Capability | LinkedIn/Indeed | Teal/Huntr | JobScan | Project Bourne |
|---|---|---|---|---|
| Job listings | Yes | No | No | Yes |
| Application tracking | Basic | Yes | No | Yes |
| Skills gap per role | No | No | Partial (keywords) | Yes (AI-analyzed) |
| Aggregate skills gap trends | No | No | No | **Yes** |
| Learning recommendations tied to gaps | No | No | No | **Yes** |
| Resume tailoring | Surface | No | Keyword-based | **Yes (AI, contextual)** |
| Interview prep | Generic | No | No | **Yes (role + company specific)** |
| Career mode (not searching) | No | No | No | **Yes** |
| Match scoring before applying | Weak | No | No | **Yes** |
| Rejection pattern analysis | No | No | No | **Yes** |

The gap in the market isn't one feature. It's the full loop — and the intelligence that runs through all of it.

---

## Non-Goals (V1)

These are explicitly out of scope for the initial build. Not because they aren't valuable — because focus is a feature.

- **Direct application submission** — users apply themselves; we prepare them, we don't submit for them
- **Recruiter-facing tools** — this is built for job seekers, not hiring companies
- **Job posting creation or employer side** — not a two-sided marketplace in V1
- **Mobile app** — web first; mobile later if warranted
- **Real-time chat / messaging** — no inbox, no recruiter communication layer
- **Video interview simulation** — future consideration
- **Payment / premium tier** — V1 is a portfolio/engineering project; monetization is out of scope

---

## MVP Scope

The smallest version that proves the concept and demonstrates the full engineering stack:

1. User auth (OAuth2 — sign in with Google)
2. Profile creation and management
3. Job search with basic match scoring
4. Application tracker (add, update status, view)
5. Skills gap analysis per application (AI-powered)
6. Aggregate skills gap dashboard ("most common gaps across your applications")
7. Resume tailoring for a specific role (AI-powered)
8. Basic interview prep — company summary + likely questions for a role (AI-powered)

Everything else is V2+. MVP is about proving the loop works end to end.

---

## Engineering Philosophy

This app is built to demonstrate what disciplined software engineering looks like in practice:

- Every significant decision is documented in an ADR before code is written
- Testing is designed before implementation, not added after
- AI features are implemented as force-multipliers with verified, validated output — not vibes
- Security is a first-class concern from day one: user career data is sensitive
- The system is observable: structured logging, metrics, and the ability to debug production issues
- The architecture is honest about tradeoffs — not over-engineered for a portfolio, not under-built to cut corners

The goal is not just to build the app. It's to show exactly how it was built, why each decision was made, and what a professional engineering process looks like from the first commit to deployment.
