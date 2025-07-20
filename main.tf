terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.37.0"
    }
  }
  backend "gcs" {
    bucket = "tf-state-bucket-terraform-dr-challenge"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
}

# This subnet for europe-west4 region (Netherland)
module "subnet_europe_west4" {
  source        = "./modules/subnet"
  project_id    = var.project_id
  vpc_id        = module.vpc.vpc_id
  region        = var.region
  subnet_name   = "europe-west4"
  ip_cidr_range = "172.16.0.0/20"
}

# This subnet for me-central2 region (Dammam)
module "subnet_me_central2" {
  source        = "./modules/subnet"
  project_id    = var.project_id
  vpc_id        = module.vpc.vpc_id
  region        = var.region
  subnet_name   = "me-central2"
  ip_cidr_range = "172.17.0.0/20"
}

module "subnets_firewall" {
  source     = "./modules/firewalls"
  project_id = var.project_id
  vpc_id     = module.vpc.vpc_id
}
