## ALPHA-ONE : https://www.share-pictures.com
----------------------------------------------
## ARCHITECTURE DU SITE : SHARE-PICTURES
## ############################

🌐 1. Route d’accès utilisateur
Internet ↔ Route 53 ↔ WAF ↔ ALB

Internet : Point d'entrée des clients.

Route 53 : Fournit la résolution DNS pour www.share-pictures.com. Il oriente le trafic HTTP(S) entrant vers l'Application Load Balancer (ALB).

WAF (Web Application Firewall) : Protège contre les attaques web (injections SQL, XSS, etc.). Il filtre les requêtes HTTP avant qu'elles atteignent l’ALB.

ALB (Application Load Balancer) :

Distribue le trafic vers les pods Kubernetes déployés dans les EC2 worker nodes.

Est placé dans une subnet publique et connecté à un NAT Gateway B pour trafic sortant.

📦 2. Infrastructure Kubernetes (dans le VPC principal)
🔹 Master Node (EC2-Master-k8s)
Situé dans une private subnet A.

Représente le nœud de contrôle du cluster.

Héberge les composants maîtres : API Server, etcd, Controller Manager, Scheduler.

Accessible via kubectl (installé ici pour gestion CLI).

Connecté à un Security Group spécifique (protège l’accès réseau).

🔹 Worker Nodes
EC2-Worker1-k8s dans private subnet B.

EC2-Worker2-k8s dans une autre private subnet, au sein d'un Auto Scaling Group.

Gère l’élasticité horizontale selon la charge.

Hébergent les pods Kubernetes, dont le service de partage de photos.

Connectés au Master via le VPC principal, avec des règles de sécurité (Security Groups) permettant la communication sur les ports Kubernetes.

🔧 3. Outils DevOps/CloudOps
🔸 EC2-Bastion (Public Subnet)
Point d’accès sécurisé SSH à l’infrastructure (saut).

Dans une subnet publique.

Utilisé pour accéder aux autres instances privées.

🔸 EC2-Vault (HashiCorp Vault)
Hébergé dans une subnet privée sécurisée.

Gère les secrets (tokens, credentials) pour toute l'infra.

Intégré à Runner CI/CD + Ansible (hébergé dans la même subnet privée).

Ansible : déploiement automatisé.

Runner CI/CD : intégration continue et déploiement via GitOps.

Le tout est restreint via un Security Group dédié.

☁️ 4. Ressources AWS Managées
Terraform : Utilisé pour le provisionnement de toute l’infrastructure.

IAM : Gère les identités, rôles et politiques d'accès pour tous les services AWS.

KMS : Clés de chiffrement (intégration avec Vault et S3).

CloudWatch : Monitoring des logs, métriques, et alertes.

AWS Config : Suivi de la conformité et de la configuration des ressources.

AWS Certificate Manager : Fournit le certificat SSL pour https://www.share-pictures.com (terminé sur ALB).

AWS Backup : Sauvegarde des volumes et configurations.

AWS GuardDuty : Service de détection de menaces et de comportements anormaux.

S3 : Stockage des images partagées via l’application (connecté via endpoint privé).

🔀 5. Connectivité et Réseaux
VPC principal et secondaire : Architecture multi-VPC avec VPC peering (connexion directe entre les VPCs).

NAT Gateways (A & B) :

Permettent aux instances en subnet privé d’accéder à Internet sans être directement exposées.

IGW (Internet Gateways A & B) :

Connectent les subnets publics à Internet.

VPC Endpoints A & B :

Permettent la communication privée entre les instances et les services AWS comme S3, sans passer par Internet public.

📷 6. Application Photo Sharing
Déployée sur les Worker Nodes Kubernetes.

Accessible via le nom de domaine https://www.share-pictures.com grâce à :

Route 53 → résout le domaine.

WAF → sécurise le trafic HTTP.

ALB → route le trafic vers les services Kubernetes exposés.

L’application utilise S3 pour le stockage des photos.

Vault fournit les secrets pour sécuriser les communications interservices.

CI/CD via GitOps permet déploiement automatique des mises à jour.

🔄 7. Flux de données simplifié
Client → www.share-pictures.com (Route 53)

Route 53 → WAF → ALB

ALB → Services exposés de Kubernetes (via ingress ou NodePort)

Application photo → S3 pour le stockage

Vault → fournit credentials aux services

Admin/DevOps → accède via Bastion ou Ansible pour déploiement