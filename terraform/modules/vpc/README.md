# VPC Module

Ce module Terraform crée deux VPCs distincts : `VPC A` et `VPC B`, chacun avec ses propres sous-réseaux, passerelles, NAT, et tables de routage. Il est conçu pour des architectures en multi-VPC, typiquement pour isoler différents types de charges de travail.

---

## 🔧 Ressources créées

### VPC A (`10.10.0.0/16`)
- 1 VPC
- 1 Internet Gateway
- 1 Subnet public (AZ A)
- 1 Subnet privé (AZ B)
- 1 NAT Gateway dans le subnet public
- 2 Tables de routage (publique et privée)

### VPC B (`192.168.0.0/16`)
- 1 VPC
- 1 Internet Gateway
- 1 Subnet public (AZ A)
- 2 Subnets privés (AZ B et C)
- 1 NAT Gateway dans le subnet public
- 2 Tables de routage (publique et privée)

---

## 📥 Inputs

| Variable                  | Description                         | Type   | Default             |
|--------------------------|-------------------------------------|--------|---------------------|
| `vpc_a_cidr`             | CIDR du VPC A                       | string | `"10.10.0.0/16"`    |
| `public_subnet_a_cidr`   | CIDR du subnet public de VPC A      | string | `"10.10.1.0/24"`    |
| `private_subnet_a_cidr`  | CIDR du subnet privé de VPC A       | string | `"10.10.2.0/24"`    |
| `vpc_b_cidr`             | CIDR du VPC B                       | string | `"192.168.0.0/16"`  |
| `public_subnet_b_cidr`   | CIDR du subnet public de VPC B      | string | `"192.168.1.0/24"`  |
| `private_subnet_b1_cidr` | CIDR du 1er subnet privé de VPC B   | string | `"192.168.2.0/24"`  |
| `private_subnet_b2_cidr` | CIDR du 2e subnet privé de VPC B    | string | `"192.168.3.0/24"`  |
| `az_a`                   | AZ pour les subnets publics         | string | `"us-east-1a"`      |
| `az_b`                   | AZ pour les subnets privés (A et B) | string | `"us-east-1b"`      |
| `az_c`                   | AZ pour le 2e subnet privé de VPC B | string | `"us-east-1c"`      |

---

## 📤 Outputs

### VPC A
- `vpc_a_id`
- `vpc_a_public_subnet_id`
- `vpc_a_private_subnet_id`
- `vpc_a_nat_gateway_id`
- `vpc_a_igw_id`

### VPC B
- `vpc_b_id`
- `vpc_b_public_subnet_id`
- `vpc_b_private_subnet_ids`
- `vpc_b_igw_id`

---

## 🧩 Exemple d'utilisation

```hcl
module "vpc" {
  source = "./modules/vpc"

  az_a = "us-east-1a"
  az_b = "us-east-1b"
  az_c = "us-east-1c"
}
