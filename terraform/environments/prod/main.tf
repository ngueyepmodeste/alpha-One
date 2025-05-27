##################### MODULES ########################

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-20.04-amd64-server-*"]
  }
}

module "vpc" {
  source =  "../../modules/vpc"
}

module "vpc-peering"{
  source = "../../modules/vpc-peering"

  vpc_a_id             = module.vpc.vpc_a_id
  vpc_b_id             = module.vpc.vpc_b_id
  vpc_a_cidr           = var.vpc_cidr_a
  vpc_b_cidr           = var.vpc_cidr_b
  vpc_a_route_table_id = module.vpc.vpc_a_route_table_id
  vpc_b_route_table_id = module.vpc.vpc_b_route_table_id
}

module "security-groups" {
  source = "../../modules/security-groups"

  vpc_id = {
    vpc_a = module.vpc.vpc_a_id
    vpc_b = module.vpc.vpc_b_id
  }

  allowed_ssh_cidrs      = ["X.X.X.X/32"]
  allowed_internal_cidrs = ["10.10.0.0/16", "192.168.0.0/16"]
  project_name           = "alpha-one"
  environment            = var.env
}

module "bastion" {
  source            =   "../../modules/bastion"
  vpc_id            = module.vpc.vpc_a_id
  subnet_id         = module.vpc.vpc_a_public_subnet_id
  ami_id            = "ami-xxxxxxxx"
  instance_type     = "t3.micro"
  key_name          = "alpha-one_key"
  allowed_ssh_cidrs = ["xx.xx.xx.xx/32"]
  sg_bastion = module.security-groups.sg_bastion_id
}

module "vault" {
  source = "../../modules/vault"

  project_name     = "alpha-one"
  vpc_id           = module.vpc.vpc_a_id
  subnet_id        = module.vpc.vpc_a_public_subnet_id
  ami_id                         = data.aws_ami.ubuntu.id
  instance_type                  = "t3.medium"
  key_pair_name    = "alpha-one_key"
  ssh_user                       = "ubuntu"
  private_key_path = "../../../alpha-one_key"
  private_ip                     = "10.10.2.10"
  allowed_ips                    = ["10.10.0.0/16"]
  vault_s3_backend_bucket_arn   = module.s3-storage.vault_backend_bucket_arn
  vault_kms_key_arn              = module.kms.kms_key_arn
}

module "gitlab_runner" {
  source                = "../../modules/gitlab_runner"
  ami_id                = "xxxxxxxxxx"
  instance_type         = "t3.medium"
  vpc_id                = module.vpc.vpc_a_id
  subnet_id             = module.vpc.vpc_a_private_subnet_id
  security_group_id      = module.security-groups.sg_runner_id
  instance_profile_name = module.iam.iam_instance_profile_runner
  key_name    = "alpha-one_key"
  ssh_user                       = "ubuntu"
  private_key_path = "../../../alpha-one_key"
}

module "s3-storage"{
  source  = "../../modules/s3-storage"
}

module "kms" {
  source         = "../../modules/kms"
  kms_alias_name = "kms-alphaONE"
}

module "iam" {
  source = "../../modules/iam"
}

module "k8s_master" {
  source           = "../../modules/k8s_master"
  ami_id             = "ami-0xxxxxx"
  instance_type      = "t3.medium"
  key_name           = "alpha-one_key"
  subnet_id          = module.vpc.vpc_b_private_subnet_ids[0]  # subnet privé A du VPC B
  private_ip         = module.k8s_master.master_private_ip
  security_group_ids = module.security-groups.sg_master_id
}


module "k8s_workers" {
  source                = "../../modules/k8s_workers"
  ami_id                = "ami-0xxxxxx"
  instance_type         = "t3.medium"
  key_name              = "alpha-one_key"
  subnet_id             = module.vpc.vpc_b_private_subnet_ids[1]
  security_group_id     = module.security-groups.sg_worker_id
  iam_instance_profile  = module.iam.iam_instance_profile_runner # ou remplace par ton nom exact
  target_group_arn      = module.alb.target_group_arn                           # ou remplace par ta source réelle
}


module "alb" {
  source             = "../../modules/alb"
  vpc_id             = module.vpc.vpc_a_id
  public_subnet_ids  = module.vpc.vpc_b_public_subnet_id
  security_group_ids = [module.security-groups.sg_alb_id]
  acm_cert_arn       = module.acm.cert_arn
  environment        = "prod"
}

module "acm" {
  source         = "../../modules/acm"
  domain_name    = "www.share-pictures.com"
  san            = ["share-pictures.com"]
  hosted_zone_id = module.route53.zone_id
  environment    = "prod"
  providers = {
    aws = aws.us_east_1
  }
}

module "route53" {
  source       = "../../modules/route53"
  domain_name  = "share-pictures.com"
  record_name  = "www.share-pictures.com" # ← ajoute cette ligne
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  environment  = "prod"
}



module "vpc-endpoints" {
  source                   = "../../modules/vpc-endpoints"
  region                   = var.aws_region

  # VPC A
  vpc_a_id                 = module.vpc.vpc_a_id
  vpc_a_private_subnets    = module.vpc.vpc_a_private_subnet_id
  vpc_a_route_table_id     = module.vpc.vpc_a_route_table_id
  vpc_a_endpoint_sg_id     = module.security-groups.sg_vault_id

  # VPC B
  vpc_b_id                 = module.vpc.vpc_b_id
  vpc_b_route_table_id     = module.vpc.vpc_b_route_table_id

  # S3 Buckets
  vault_backend_bucket_arn = module.s3-storage.vault_backend_bucket_arn
  uploads_bucket_arn       = module.s3-storage.uploads_bucket_arn
}

module "aws-onfig" {
  source          = "../../modules/aws-config"
  project_name    = var.project
  environment     = var.env
  config_role_arn = module.iam.iam_role_config
}
module "guardduty" {
  source =  "../../modules/guardduty"
}

module "backup" {
  source =  "../../modules/backup"

  backup_vault_name = "my-backup-vault"
  backup_plan_name  = "daily-backup-plan"
  rule_name         = "daily-rule"
  schedule          = "cron(0 3 * * ? *)" # tous les jours à 3h UTC
  start_window      = 60
  completion_window = 180
  delete_after_days = 30
  selection_name    = "critical-resources"
  iam_role_arn      =  module.iam.iam_role_backup

  resources_to_backup = [
    "arn:aws:ec2:${var.aws_region}:362454057735:instance/${module.k8s_master.master_instance_id}",
    "arn:aws:ec2:${var.aws_region}:362454057735:instance/${module.vault.vault_instance_id}",
    "arn:aws:s3:::my-backup-bucket"
  ]
}
