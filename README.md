# Projet Infrastructure AWS

Ce projet déploie 3 machines virtuelles sur AWS avec des configurations spécifiques pour chacune.
## Ce deployement est en deux parties :
   - Parties  1 Creation de l'AMI avec Packer
   - Parties  2 Grêce à cette AMI creer Packer nous allons deployer 3 VMS 

## Prérequis
1. Avoir un compte AWS
2. Avoir AWS CLI installé et configuré
3. Avoir Terraform installé
4. Avoir Packer installé
5. Avoir configuré les credentials AWS

## Machines Virtuelles

1.  Frontend VM 
   - Nginx installé
   - Port 80 accessible

2.  Backend VM 
   - Node.js installé
   - Port 3000 accessible

3.  Database VM 
   - MongoDB installé
   - Port 27017 accessible

## Configuration commune à toutes les VMs
- Utilisateur : `packer`
- Mot de passe : `packer`
- Fail2Ban installé
- Système maintenu à jour

## Processus de déploiement

### 1. Création des AMIs avec Packer

Avant de déployer les VMs avec Terraform, nous utilisons Packer pour créer une AMI personnalisée :

```bash
cd packer
packer init .
packer build .
```

Cette étape crée une AMI avec la configuration de base qui sera utilisée comme template pour toutes nos VMs.

### 2. Déploiement des VMs avec Terraform

Une fois l'AMI créée, nous utilisons Terraform pour déployer les VMs :

cd terraform
terraform init
terraform apply

## Comment déployer

1. Cloner "Mon repository"

git clone 
cd "repository"

2. Aller dans le dossier terraform

cd terraform

3. Initialiser Terraform

terraform init

4. Déployer l'infrastructure

terraform apply

5. Pour se connecter aux VMs

ssh -i terraform/terraform_ec2_key packer@<ip-de-la-vm>

# Vérification du déploiement
   terraform state list 
   **Vous devez avoir avoir ça**
      aws_instance.backend
      aws_instance.database
      aws_instance.frontend

Verifion les VMS

1.  Frontend (Nginx) 
   - Ouvrir dans un navigateur : `http://<frontend-ip>`
   - Vous devriez voir la page par défaut de Nginx

2.  Backend (Node.js) 
   
   ssh -i terraform/terraform_ec2_key packer@<backend-ip>
   node --version
   
3.  Database (MongoDB) 
   
   ssh -i terraform/terraform_ec2_key packer@<database-ip>
   systemctl status mongod  

## Structure du projet
├── terraform/
│   ├── main.tf              # Configuration Terraform
│   └── terraform_ec2_key    # Clé SSH
├── packer/
│   ├── aws.pkr.hcl          # Configuration Packer pour l'AMI
│   
├── scripts/
│   ├── frontend.sh          # Script d'initialisation Frontend
│   ├── backend.sh           # Script d'initialisation Backend
│   └── database.sh          # Script d'initialisation Database
└── README.md

 