#!/bin/bash
# Mise à jour du système
sudo apt-get update && sudo apt-get upgrade -y

# Installation des dépendances
sudo apt-get install -y fail2ban nginx

# Création de l'utilisateur packer
sudo useradd -m -s /bin/bash packer
echo 'packer:packer' | sudo chpasswd
sudo usermod -aG sudo packer

# Démarrage et activation des services
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
sudo systemctl start nginx
sudo systemctl enable nginx 