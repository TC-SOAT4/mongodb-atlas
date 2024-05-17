terraform {

  cloud {
    workspaces {
      name = "lanchonete-terraform-mongo"
    }
    organization = "FIAP_POS"
  }

  required_version = "~> 1.3"
}

