provider "aws" {
  region = var.region
}

module "network" {
  source    = "../../modules/network"
  region    = var.region
  vpc_cidr  = var.vpc_cidr
}
