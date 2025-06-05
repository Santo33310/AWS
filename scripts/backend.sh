#!/bin/bash
# Mise à jour et installation des dépendances
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y fail2ban curl

# Installation de Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Création de l'utilisateur packer
sudo useradd -m -s /bin/bash packer
echo 'packer:packer' | sudo chpasswd
sudo usermod -aG sudo packer

# Configuration de Fail2Ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Vérification de l'installation de Node.js
node --version
npm --version 