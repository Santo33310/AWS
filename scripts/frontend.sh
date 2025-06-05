#!/bin/bash
# Mise à jour et installation des dépendances
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y nginx fail2ban

# Création de l'utilisateur packer
sudo useradd -m -s /bin/bash packer
echo 'packer:packer' | sudo chpasswd
sudo usermod -aG sudo packer

# Configuration de Fail2Ban
sudo systemctl start fail2ban
sudo systemctl enable fail2ban

# Démarrage et activation de Nginx
sudo systemctl start nginx
sudo systemctl enable nginx 