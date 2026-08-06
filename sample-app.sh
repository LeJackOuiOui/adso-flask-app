#!/bin/bash

cd "$(dirname "$0")"

mkdir -p tempdir

cat > Dockerfile << 'EOF'
FROM python:3.11-slim

WORKDIR /app

COPY sample_app.py /app/
COPY templates /app/templates
COPY static /app/static

RUN pip install flask

EXPOSE 5050
CMD ["python", "sample_app.py"]
EOF

docker build -t sampleapp .
docker rm -f samplerunning 2>/dev/null
docker run -d --name samplerunning -p 5050:5050 sampleapp
