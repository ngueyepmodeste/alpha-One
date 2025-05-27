# Module: VPC Endpoints

Ce module crée des **VPC Endpoints** pour VPC A et VPC B :

- VPC A reçoit des endpoints Interface pour Vault (CloudWatch, SSM, KMS, Secrets Manager, etc.), et un endpoint Gateway S3.
- VPC B reçoit uniquement un endpoint Gateway pour permettre à l'app de stocker des fichiers/images dans S3.

## Variables

| Nom                     | Description                                  |
|-------------------------|----------------------------------------------|
| `region`                | AWS region                                   |
| `vpc_a_id`              | ID du VPC A                                  |
| `vpc_b_id`              | ID du VPC B                                  |
| `vpc_a_private_subnets` | Liste des subnets privés du VPC A            |
| `vpc_a_route_table_id`  | Route table associée aux subnets VPC A       |
| `vpc_b_route_table_id`  | Route table associée aux subnets VPC B       |
| `vpc_a_endpoint_sg_id`  | SG utilisé pour les endpoints d’interface    |

## Outputs

Retourne les IDs de chaque endpoint provisionné.
