from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="Project Bourne — AI Service",
    description=(
        "Intelligence layer: skills extraction, gap analysis, "
        "resume tailoring, cover letter generation, interview prep. "
        "Internal service — not exposed publicly. Called by Core API only."
    ),
    version="0.1.0",
)

# CORS restricted to Core API only — this service is not called from the browser
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://backend:8080", "http://localhost:8080"],
    allow_credentials=True,
    allow_methods=["POST", "GET"],
    allow_headers=["*"],
)


@app.get("/health")
def health():
    return {"status": "ok", "service": "ai-service"}
