module "vault-backend" {
  source = "./vault-backend"
  environment = "prod"
  project_name = "alpha-one"
}

module "app-uploads" {
  source = "./app-uploads"
  environment = "prod"
  project_name = "alpha-one"
}
