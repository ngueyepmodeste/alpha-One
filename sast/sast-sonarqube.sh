#!/bin/bash

# SAST avec SonarQube
SONAR_HOST_URL="http://localhost:9000"
SONAR_TOKEN=""
SONAR_PROJECT_KEY=""
SONAR_PROJECT_NAME=""

echo "[SAST] Analyse statique avec SonarQube"
sonar-scanner \
  -Dsonar.projectKey="${SONAR_PROJECT_KEY}" \
  -Dsonar.projectName="${SONAR_PROJECT_NAME}" \
  -Dsonar.sources=. \
  -Dsonar.host.url="${SONAR_HOST_URL}" \
  -Dsonar.login="${SONAR_TOKEN}"
