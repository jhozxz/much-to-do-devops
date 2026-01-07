#!/bin/bash
echo "Starting Docker Compose..."
docker-compose up -d --build
echo "Application running on http://localhost:8080"
