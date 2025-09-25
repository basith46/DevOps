terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Pull Docker Image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Run Container
resource "docker_container" "nginx" {
  name  = "nginx_container"
  image = docker_image.nginx.name
  ports {
    internal = 80
    external = 8081
  }
}
