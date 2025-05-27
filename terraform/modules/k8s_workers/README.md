# Module: autoscaling-k8s-workers

Ce module déploie un groupe d'instances EC2 dans le subnet privé B du VPC B pour agir comme nœuds workers Kubernetes.

## Ressources

- Launch Template EC2
- Auto Scaling Group (min=1, max=2)
- Association au Target Group de l'ALB
- Tags et sécurité gérés via variables

## Outputs

- `asg_name` : nom du groupe ASG
- `lt_id` : ID du Launch Template

## Prérequis

- Le SG doit autoriser les ports NodePort (30000–32767)
- Le Target Group de l'ALB doit être configuré en mode HTTP/HTTPS selon l'app

## appel du module dans le main.tf ' prod '

module "k8s_workers" {
  source                = "../../modules/k8s_workers"
  ami_id                = "ami-0xxxxxx"
  instance_type         = "t3.medium"
  key_name              = "alpha-one_key"
  subnet_id             = module.vpc.vpc_b_private_subnet_ids[1]
  security_group_id     = module.security-groups.sg_worker_id

  iam_instance_profile  = aws_iam_instance_profile.worker_instance_profile.name # ou remplace par ton nom exact
  target_group_arn      = module.alb.target_group_arn                           # ou remplace par ta source réelle
}
