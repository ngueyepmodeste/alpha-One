📁 Modules Terraform pour notre architecture
1. vpc/
💡 Contient :
● Création des VPC (VPC_A, VPC_B si besoin)
● Subnets publics / privés
● Route tables
● IGW / NAT
● VPC Peering
● VPC Endpoints (ex. pour S3)
📦 Pourquoi en module ?
C’est une brique réseau clé, souvent utilisée ou modifiée séparément.
2. bastion/
💡 Contient :
● Instance EC2 Bastion
● Security Group du bastion
● Clé SSH (Key Pair)
● IAM Role minimal (si besoin)
📦 Pourquoi ?
Le bastion est isolé, a des règles strictes et n’a pas besoin d’être déployé en
même temps que les autres machines.
3. k8s-master/💡 Contient :
● EC2-Master-k8s
● GitLab Runner / Ansible
● Security Groups liés
● User Data pour bootstrapper si besoin
📦 Pourquoi ?
Cette partie est liée à l’orchestration et l’automatisation du cluster, elle est
critique et doit être modulaire.
4. autoscaling-k8s-workers/
💡 Contient :
● EC2-Worker1-k8s + Worker2 (ASG)
● Launch Template ou Launch Configuration
● Security Group des workers
● Auto Scaling Group avec policies
● Subnets cibles (multi-AZ)
📦 Pourquoi ?
C’est scalable, évolutif, et très souvent modifié à part (par exemple, ajuster le
nombre de workers).
5. alb/
💡 Contient :
● Application Load Balancer
● Listener HTTP/HTTPS avec ACM● Security Groups
● Intégration WAF (en option ici aussi)
📦 Pourquoi ?
C’est l’entrée principale de ton app, gérée séparément pour appliquer règles,
SSL, redirection, WAF.
6. iam/
💡 Contient :
● Roles pour EC2, GitLab Runner, etc.
● Policies attachées
● Optionnellement utilisateurs IAM (selon ton process)
📦 Pourquoi ?
Séparer la gestion des permissions : propre, sécurisé, facile à auditer.
7. backup/
💡 Contient :
● Backup Vault
● Backup Plan (planning)
● Backup Selection (les volumes à sauvegarder)
📦 Pourquoi ?
Tu pourras ajuster indépendamment la stratégie de sauvegarde sans toucher au
reste.
8. s3/ (optionnel mais utile si tu as des buckets spécifiques)💡 Contient :
● Buckets pour stockage (ex. photos uploadées)
● Politiques de bucket
● Logging / versioning / lifecycle
9. route53/ (si tu gères les DNS avec Terraform)
💡 Contient :
● Zone DNS
● Enregistrements A, CNAME, etc.
● Alias vers ALB
