terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

# Rappel : Les déclarations 'variable "..." {}' doivent être 
# uniquement dans ton fichier variables.tf pour éviter les doublons.

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  # Cette structure est obligatoire pour les images Docker externes
  runtime_source = {
    image = {
      image_url = "${var.image_url}:${var.image_tag}"
    }
  }

  env_vars = {
    "ENV" = {
      value = "production"
    }
  }
}
