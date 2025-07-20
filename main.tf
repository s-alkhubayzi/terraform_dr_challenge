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

# Fetch the project details of sultan_playground_project
data "google_project" "sultan_playground_project" {
  project_id = var.project_id
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

module "api_enablement" {
  source     = "./modules/api_enablement"
  project_id = var.project_id
}

module "iam" {
  source         = "./modules/iam"
  project_id     = var.project_id
  project_number = data.google_project.sultan_playground_project.number
}
