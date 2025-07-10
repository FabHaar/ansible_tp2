terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.79.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://51.159.96.254:8006/"
  username = "root@pam"
  password = "vz6AFFar907CoWTr848-PW8X"
  insecure = true
}