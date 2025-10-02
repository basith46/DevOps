# Terraform-docker
  Infrastructure as Code (IaC) with Terraform

# Objective
Provision a **local Docker container** using **Terraform** to demonstrate **Infrastructure as Code (IaC)**.

---

# Tools Used
- **Terraform**
- **Docker**
- **CentOS 9**

---

# Files
- `main.tf` → Terraform configuration file
- Execution logs from `terraform init`, `plan`, `apply`, `destroy`

# Install Prerequisites

## Update system
    sudo dnf update -y

## Install Docker
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io

## Start Docker
    sudo systemctl enable --now docker

## Add user to Docker group
    sudo usermod -aG docker $USER
    newgrp docker

## Test Docker
    docker run hello-world

## Install Terraform:
    sudo dnf install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo dnf install -y terraform
    terraform -v

## Create Terraform File
    mkdir ~/terraform-docker && cd ~/terraform-docker
    vim main.tf

```hcl
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
  image = docker_image.nginx.latest
  ports {
    internal = 80
    external = 8080
  }
}
```

# Run Terraform Commands
  
## Initialize Terraform project
    terraform init

## Preview plan
    terraform plan

## Apply configuration
    terraform apply -auto-approve

## Check container:
    docker ps

Open in browser: http://localhost:8080

# Manage Terraform State
## List resources
    terraform state list

## Show details of a resource
    terraform state show docker_container.nginx

## Destroy Infrastructure
    terraform destroy -auto-approve

## Outcome
  * Provisioned an nginx Docker container using Terraform
  * Learned to use init, plan, apply, state, and destroy
  * Gained hands-on with Infrastructure as Code (IaC)

## Notes
  * Use terraform plan before apply to see what changes will happen.
  * Use terraform destroy to clean up resources when done.
  * Ports can be changed in main.tf if 8080 (8081/8082) conflicts with other services.
