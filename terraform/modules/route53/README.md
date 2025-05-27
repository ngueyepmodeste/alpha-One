# Module Terraform : Route 53

Ce module permet de créer une **zone DNS publique Route 53** pour une application web, et d’ajouter un enregistrement **A (alias)** qui pointe vers un **Application Load Balancer (ALB)** derrière un **WAF**.

---

## 📦 Ressources créées

- `aws_route53_zone` : Création de la zone DNS publique.
- `aws_route53_record` : Enregistrement `A` (alias) pour le sous-domaine.

---

## 📥 Entrées

| Nom            | Description                                 | Type   | Requis |
|----------------|---------------------------------------------|--------|--------|
| `domain_name`  | Domaine racine (ex: share-pictures.com)     | string | ✅ Oui |
| `subdomain`    | Sous-domaine (ex: www.share-pictures.com)   | string | ✅ Oui |
| `alb_dns_name` | DNS name de l’ALB cible (via WAF)           | string | ✅ Oui |
| `alb_zone_id`  | Zone ID associée à l’ALB                    | string | ✅ Oui |
| `environment`  | Nom de l’environnement                      | string | ✅ Oui |

---

## 📤 Sorties

| Nom             | Description                     |
|------------------|---------------------------------|
| `hosted_zone_id` | ID de la zone DNS Route 53      |
| `fqdn`           | FQDN complet configuré (`A`)    |

---

## 🚀 Exemple d’appel

```hcl
module "route53" {
  source         = "../../modules/route53"
  domain_name    = "share-pictures.com"
  subdomain      = "www"
  alb_dns_name   = module.alb.alb_dns
  alb_zone_id    = module.alb.alb_zone_id
  environment    = "dev"
}
