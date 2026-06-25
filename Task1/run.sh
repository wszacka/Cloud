#!/bin/bash

echo "Building Books application image..."
docker build -t markvellaum/springbooks:v0.0.1 -t markvellaum/springbooks:latest .

echo "Starting Docker Compose deployment..."
docker compose up -d

echo "Checking running containers..."
docker ps

echo "Task 1 deployment complete."