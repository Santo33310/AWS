#!/bin/bash
set -e

# Mise à jour et installation des dépendances
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y fail2ban gnupg curl

# Installation de MongoDB
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Création de l'utilisateur packer
sudo useradd -m -s /bin/bash packer
echo 'packer:packer' | sudo chpasswd
sudo usermod -aG sudo packer

# Configuration de Fail2Ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Configuration de MongoDB pour accepter les connexions distantes
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
sudo systemctl restart mongod 