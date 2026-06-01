# Stage 1: Build the Vite frontend
FROM node:18-alpine AS frontend-builder
WORKDIR /app/web
COPY web/package.json web/package-lock.json* ./
RUN npm install
COPY web/ ./
RUN npm run build

# Stage 2: Build the Python backend
FROM python:3.10-slim
WORKDIR /app

# Install system dependencies if required (e.g., for scikit-learn/xgboost)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy backend source code
COPY src/ ./src/
COPY data/ ./data/
COPY models/ ./models/
COPY scripts/ ./scripts/

# Ensure initial model artifacts exist
RUN python scripts/generate_artifacts.py

# Copy frontend build from stage 1
COPY --from=frontend-builder /app/web/dist ./web/dist

# Expose the API port
EXPOSE 8000

# Run the FastAPI application
CMD ["python", "-m", "uvicorn", "src.api.app:app", "--host", "0.0.0.0", "--port", "8000"]
