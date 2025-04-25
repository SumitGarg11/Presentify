#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Build the Docker image
docker build -t presentify:latest -f Dockerfile.prod .

# Run the container
docker run -d \
    --name presentify \
    -p 3000:3000 \
    -e AUTH_SECRET="$AUTH_SECRET" \
    -e AUTH_GOOGLE_ID="$AUTH_GOOGLE_ID" \
    -e AUTH_GOOGLE_SECRET="$AUTH_GOOGLE_SECRET" \
    -e AUTH_RESEND_KEY="$AUTH_RESEND_KEY" \
    -e DATABASE_URL="$DATABASE_URL" \
    -e GOOGLE_GENAI_API_KEY="$GOOGLE_GENAI_API_KEY" \
    presentify:latest

echo "Container is running. You can access the application at http://localhost:3000" 