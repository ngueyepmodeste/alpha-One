#!/bin/bash

# SCA avec Trivy
echo "[SCA] Analyse des dépendances avec Trivy"
trivy fs --scanners vuln --format json --output sca-report.json . || true
