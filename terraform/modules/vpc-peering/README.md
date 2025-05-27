# Module: vpc-peering

Ce module établit un peering entre deux VPC AWS (VPC A et VPC B). Il configure également les routes nécessaires pour que les sous-réseaux des deux VPC puissent communiquer via ce lien privé.

## Ressources créées

- `aws_vpc_peering_connection` : Connexion entre les deux VPC
- `aws_route` : Routes dans les deux tables de routage pour permettre le trafic

## Entrées

| Variable               | Description                          |
|------------------------|--------------------------------------|
| `vpc_a_id`             | ID du VPC initiateur (A)             |
| `vpc_b_id`             | ID du VPC pair (B)                   |
| `vpc_a_cidr`           | CIDR block du VPC A                  |
| `vpc_b_cidr`           | CIDR block du VPC B                  |
| `vpc_a_route_table_id` | Table de routage du VPC A            |
| `vpc_b_route_table_id` | Table de routage du VPC B            |

## Sorties

| Output                  | Description                             |
|-------------------------|-----------------------------------------|
| `peering_connection_id` | ID de la connexion de peering établie   |
