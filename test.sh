#!/bin/bash

echo "Starting up docker compose with example zones"
docker-compose up -d --force-recreate --build
if [ $? -ne 0 ]; then
  echo "Failed starting up docker compose!"
  exit 1
fi

dig @localhost www.example.com -p 5333
if [ $? -ne 0 ]; then
  echo "Unable to find sample zone on bind9 server, failed!"
  exit 1
fi

echo "Test successful!"
echo "Shutting down docker container..."
docker-compose down -v
