FROM python:3.12-slim

WORKDIR /app

# Phase 2: Playwright + Chromium will be added here for headless job posting ingestion
# Not installed in Phase 0 — ai-service only needs FastAPI + LLM client at this stage

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
