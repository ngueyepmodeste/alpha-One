# Module : k8s-master

Ce module déploie un nœud maître Kubernetes **dans le subnet privé A (`private_subnet_b1`) du VPC B**. Il est destiné à faire partie d’un cluster K8s autosuffisant ou géré manuellement.

## 🚀 Ressources créées

- 1 instance EC2 pour le master node
- IP privée fixe
- Tags standards

## 📥 Inputs

| Nom                 | Description                                 | Type         | Par défaut      |
|---------------------|---------------------------------------------|--------------|-----------------|
| `ami_id`            | AMI pour le nœud master                     | `string`     | _nécessaire_    |
| `instance_type`     | Type d'instance EC2                         | `string`     | `"t3.medium"`   |
| `key_name`          | Nom de la clé SSH à attacher                | `string`     | _nécessaire_    |
| `subnet_id`         | Subnet privé pour le master node            | `string`     | _nécessaire_    |
| `private_ip`        | IP privée à attribuer à l’instance          | `string`     | _nécessaire_    |
| `security_group_ids`| SGs à attacher                              | `list(string)`| _nécessaire_    |

## 📤 Outputs

- `master_instance_id`
- `master_private_ip`
- `master_private_dns`

## 📌 Exemples d'utilisation

```hcl
module "ec2-k8s-master" {
  source = "./terraform/modules/ec2-k8s-masterr"

  ami_id             = "ami-0xxxxxx"
  instance_type      = "t3.medium"
  key_name           = "my-key"
  subnet_id          = module.vpc.vpc_b_private_subnet_ids[0]  # subnet privé A du VPC B
  private_ip         = "192.168.2.10"
  security_group_ids = [aws_security_group.k8s_sg.id]
}
