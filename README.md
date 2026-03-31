# 🚀 AWS K3s Infrastructure Pipeline

Ce projet implémente un pipeline d'**Infrastructure as Code (IaC)** permettant de provisionner un environnement Kubernetes léger (**K3s**) sur AWS de manière reproductible et automatisée via **GitHub Actions**.

## 🏗️ Architecture
L'infrastructure est déployée dans la région `eu-west-3` (Paris) et comprend :
* **VPC Dédié** : Réseau isolé avec un sous-réseau public.
* **Instance EC2** : Type `t3.medium` sous Ubuntu 22.04.
* **K3s Cluster** : Installé automatiquement via `userdata`.
* **Nginx Hello World** : Déployé par défaut et accessible sur le port 80.
* **Terraform Remote State** : État stocké de manière sécurisée dans un bucket S3 (`eu-north-1`).



## 🛠️ Technologies
* **Terraform** : Provisionnement de l'infrastructure.
* **K3s** : Distribution Kubernetes certifiée et légère.
* **GitHub Actions** : Pipeline CI/CD pour l'automatisation.
* **AWS S3** : Backend pour la persistance du state Terraform.

## 📋 Prérequis

1. **Secrets GitHub** : Configurer les secrets suivants dans votre dépôt (`Settings > Secrets and variables > Actions`) :
   * `AWS_ACCESS_KEY_ID` : ID de clé d'accès IAM.
   * `AWS_SECRET_ACCESS_KEY` : Clé secrète IAM.
   * `SSH_PUBLIC_KEY` : Votre clé publique SSH (format `ssh-rsa ...`).

2. **Backend S3** : Un bucket S3 doit exister pour stocker le state (actuellement configuré sur `terraform-state-172030247215-eu-north-1-an`).

## 🚀 Déploiement

Le déploiement est entièrement automatisé. Il se déclenche lors de chaque **push** sur la branche `main`.

### Workflow CI/CD
1. **Terraform Init** : Initialise le backend S3 et télécharge les providers.
2. **Terraform Plan** : Génère l'aperçu des modifications.
3. **Terraform Apply** : Applique les changements sur AWS.
4. **Provisioning** : Le script `userdata.sh` installe K3s et déploie l'application Nginx.

## 🖥️ Utilisation

Une fois le déploiement terminé, récupérez l'IP publique de l'instance dans les logs de l'action GitHub ou via la commande :
```bash
terraform output instance_ip
```

Accédez à l'application via votre navigateur :
`http://<INSTANCE_IP>`

## 🧹 Suppression
Pour supprimer toutes les ressources et éviter des frais inutiles :
```bash
terraform destroy -auto-approve
```

---
**Auteur :** Igor Gaetan — MSI Engineer & DevOps.# Create-EC2-On-aws-with-terraform
# Create-EC2-On-aws-with-terraform
# Create-EC2-On-aws-with-terraform
