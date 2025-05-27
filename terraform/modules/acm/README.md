# Module Terraform : ACM

Ce module Terraform permet de provisionner un **certificat TLS/SSL** via **AWS Certificate Manager (ACM)**, avec validation automatique par **DNS** via Route 53. Il est destiné à être utilisé notamment pour sécuriser l'accès HTTPS à un **Application Load Balancer (ALB)** dans un environnement Kubernetes.

---

## 📦 Ressources créées

- `aws_acm_certificate` : Certificat ACM avec SAN optionnels.
- `aws_route53_record` : Enregistrements DNS pour la validation du certificat.
- `aws_acm_certificate_validation` : Validation DNS du certificat.

---

## 📥 Entrées (variables)

| Nom              | Description                                    | Type          | Obligatoire |
|------------------|------------------------------------------------|---------------|-------------|
| `domain_name`    | Nom de domaine principal (ex: www.share-pictures.com) | `string`       | ✅ Oui       |
| `san`            | Subject Alternative Names (SAN) (ex: share-pictures.com) | `list(string)` | ❌ Non       |
| `hosted_zone_id` | ID de la zone Route53 pour la validation DNS  | `string`       | ✅ Oui       |
| `environment`    | Environnement cible (dev, prod, etc.)         | `string`       | ✅ Oui       |

---

## 📤 Sorties (outputs)

| Nom        | Description                      |
|------------|----------------------------------|
| `cert_arn` | ARN du certificat ACM provisionné |

---

## 🚀 Exemple d'utilisation

```hcl
module "acm" {
  source         = "../../modules/acm"
  domain_name    = "www.share-pictures.com"
  san            = ["share-pictures.com"]
  hosted_zone_id = module.route53.hosted_zone_id
  environment    = "dev"
} 

##   ++++++++++++++++++++++++++++++++++++++++++++++++

📝 Notes
Le certificat est généré dans la région us-east-1 (obligatoire pour certaines intégrations CloudFront/ALB).

La validation DNS se fait automatiquement si la zone Route53 est correctement configurée.

Ce module est conçu pour être idempotent et réutilisable dans différents environnements (dev, prod, etc.).

# 📚 Références

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation

https://docs.aws.amazon.com/acm/latest/userguide/acm-overview.html