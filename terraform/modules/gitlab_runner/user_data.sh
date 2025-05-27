#!/bin/bash
set -eux

# Mettre à jour le système
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Installer les dépendances nécessaires
apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

# Ajouter la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le dépôt Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Ajouter l'utilisateur actuel au groupe docker
usermod -aG docker $USER

# Installer Docker Compose
DOCKER_COMPOSE_VERSION="1.29.2"
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Installer Ansible
apt-get install -y ansible

# Installer GitLab Runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash
apt-get install -y gitlab-runner

# Enregistrer le GitLab Runner (remplacez les valeurs par vos informations)
gitlab-runner register \
  --non-interactive \
  --url "https://gitlab.example.com/" \
  --registration-token "YOUR_TOKEN" \
  --executor "docker" \
  --description "docker-runner" \
  --docker-image "docker:latest" \
  --docker-privileged
