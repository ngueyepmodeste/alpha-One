#!/bin/bash

# DAST avec ZAP (baseline scan)
DAST_TARGET="http://localhost:8080"

echo "[DAST] Scan dynamique avec OWASP ZAP"
docker run --rm --network host -v $(pwd):/zap/wrk ghcr.io/zaproxy/zaproxy:weekly \
  /zap/zap-baseline.py \
  -t ${DAST_TARGET} \
  -r zap-report.html \
  -w zap-report.md \
  -J zap-report.json || true
