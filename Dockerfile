# Stage 1: Build the FastAPI application
FROM python:3.9-slim AS fastapi

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# Stage 2: Serve the application with Nginx
FROM nginx:alpine AS nginx

# Copy the FastAPI application from the first stage
COPY --from=fastapi /app /usr/share/nginx/html

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
