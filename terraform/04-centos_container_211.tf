resource "proxmox_virtual_environment_container" "centos_container_211" {
  description = "Managed by Terraform"

  node_name = "tf-bm-exciting-bouman"
  vm_id     = 211
  
  initialization {
    hostname = "centos-211"

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      keys = [
        trimspace(local.public_key)
      ]
      password = "rootroot"
    }
  }

  network_interface {
    name = "veth0"
    bridge = "vmbr201"
  }

  disk {
    datastore_id = "vmdata"
    size         = 4
  }

  operating_system {
    template_file_id = "local:vztmpl/centos-9-stream-default_20240828_amd64.tar.zst"
    type             = "centos"
  }

#   mount_point {
#     # bind mount, *requires* root@pam authentication
#     volume = "/mnt/bindmounts/shared"
#     path   = "/mnt/shared"
#   }

  mount_point {
    # volume mount, a new volume will be created by PVE
    volume = "vmdata"
    size   = "10G"
    path   = "/mnt/volume"
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
}

# resource "proxmox_virtual_environment_download_file" "latest_ubuntu_22_jammy_lxc_img" {
#   content_type = "vztmpl"
#   datastore_id = "local"
#   node_name    = "first-node"
#   url          = "http://download.proxmox.com/images/system/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
# }
