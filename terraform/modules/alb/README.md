# Module Terraform : Application Load Balancer (ALB) + WAF + HTTPS

Ce module provisionne un **ALB public** protégé par un **WAF AWS**, avec un **listener HTTPS (443)** utilisant un certificat **ACM**, et un **Target Group** pour envoyer le trafic vers les workers EC2 du cluster K8s.

---

## 📦 Ressources créées

- `aws_lb` : Application Load Balancer public
- `aws_lb_listener` : Listener HTTPS avec certificat TLS
- `aws_lb_target_group` : Groupe de cibles pour K8s
- `aws_wafv2_web_acl` : Web Application Firewall AWS
- `aws_wafv2_web_acl_association` : Liaison WAF ↔ ALB

---

## 📥 Variables d’entrée

| Variable            | Description                              | Type         | Requis |
|---------------------|------------------------------------------|--------------|--------|
| `vpc_id`            | ID du VPC                                | `string`     | ✅     |
| `public_subnet_ids` | Subnets publics pour attacher l’ALB      | `list`       | ✅     |
| `security_group_ids`| SGs à attacher à l’ALB                   | `list`       | ✅     |
| `acm_cert_arn`      | ARN du certificat TLS ACM                | `string`     | ✅     |
| `environment`       | Nom de l’environnement (`dev`, `prod`)   | `string`     | ✅     |

---

## 📤 Outputs

| Output              | Description                                  |
|---------------------|----------------------------------------------|
| `alb_dns_name`      | DNS public de l’ALB                          |
| `alb_zone_id`       | Zone ID du ALB (nécessaire pour Route 53)    |
| `target_group_arn`  | ARN du Target Group                          |
| `listener_https_arn`| ARN du listener HTTPS                        |
| `waf_arn`           | ARN du WAF associé à l’ALB                   |
| `alb_arn`           | ARN complet de l’ALB                         |

---

## 💡 Exemple d’utilisation

```hcl
module "alb" {
  source             = "../../modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security_groups.alb_sg_id]
  acm_cert_arn       = module.acm.cert_arn
  environment        = "prod"
}

## ++++++++++++++++++++++++++++++++++++++++

🔐 Notes de sécurité
Le certificat TLS est obligatoire via ACM.

Le WAF utilise les règles gérées AWS (AWSManagedRulesCommonRuleSet).

Health check configuré sur / en HTTPS.

🔗 Références

https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html

https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups.html