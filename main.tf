resource "random_string" "k3s_token" {
  length  = 48
  upper   = false
  special = false
}

resource "phpipam_first_free_address" "newip" {
  for_each = var.nodes
  subnet_id   = data.phpipam_subnet.subnet.subnet_id
  hostname    = "${each.value.name}.localdomain"
  description = "Managed by Terraform"

  lifecycle {
    ignore_changes = [
      subnet_id,
      ip_address,
    ]
  }
}
# create backup bucket
resource "aws_s3_bucket" "backup" {
  bucket = "backup-cluster-${var.clustername}"
  acl    = "private"
  force_destroy = true
}
# set access policies tot fully private
resource "aws_s3_bucket_public_access_block" "backup" {
  bucket = aws_s3_bucket.backup.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets  = true
}

resource "proxmox_vm_qemu" "createvm" {
    lifecycle { 
      ignore_changes = [
                     network,
                     target_node,
                     clone,
                     disk[0].storage,
                     disk[1].storage,
                     disk[2].storage,
                     disk[3].storage,
       ]
    }
    for_each = var.nodes
    name = each.value.name
    desc = "{ \"groups\": [${each.value.groups}]}"
    full_clone = var.full_clone

    target_node = each.value.target_node
    pool = ""
    clone = "${var.clonename}"
    agent = 1
    bootdisk = "scsi0"
    os_type = var.os_type
    ipconfig0 = "ip=${phpipam_first_free_address.newip[each.key].ip_address}/24,gw=${var.gateway}"
    nameserver = "${var.dns_server}"
    cores = "${each.value.cpu_cores}"
    sockets = "1"
    vcpus = "0"
    cpu = var.cpu
    bios = var.bios
    memory = "${each.value.memory}"
    scsihw = "virtio-scsi-pci"
    disk {
        size = "${each.value.osdisksize}"
        type = "scsi"
        storage = "${each.value.targetstorage}"
        backup = 1
    }
    disk {
        size = "${each.value.datadisksize}"
        type = "scsi"
        storage = "${each.value.targetstorage}"
        backup = 0
    }
    network {
        model = "virtio"
        bridge = "vmbr0"
    }
#wait for cloudinit to complete
    provisioner "remote-exec" {
      inline = [
        "cloud-init status --wait",
        "echo ${var.pm_password} | sudo -S apt install curl open-iscsi nfs-common -y",
        "echo ${var.pm_password} | sudo -S wget ${var.mount_data_url} -O /tmp/mount_data.sh",
        "echo ${var.pm_password} | sudo -S chmod +x /tmp/mount_data.sh",
        "echo ${var.pm_password} | sudo -S /tmp/mount_data.sh"
      ]
      connection {
        private_key = file("${var.private_key}")
        user     = "automation"
        host     = "${phpipam_first_free_address.newip[each.key].ip_address}"
  }
  
  }
}


resource "null_resource" "adguard_dns_overrides_pt" {
  for_each = var.nodes
#nodes
  provisioner "local-exec" {
    command = "${var.adguard_python_path} --fqdn ${each.value.name}.${var.local_dns_domain} --ip ${phpipam_first_free_address.newip[each.key].ip_address} --adguardurl ${var.adguard_base_url} --adguarduser ${var.adguard_user} --adguardpassword ${var.adguard_password} --action add"
  }
#kubeapi
  provisioner "local-exec" {
    command = "${var.adguard_python_path} --fqdn ${var.clustername}.${var.local_dns_domain} --ip ${phpipam_first_free_address.newip[each.key].ip_address} --adguardurl ${var.adguard_base_url} --adguarduser ${var.adguard_user} --adguardpassword ${var.adguard_password} --action add"
  }
}

resource "null_resource" "k3s_init" {
for_each = {for k, v in var.nodes: k => v if length(regexall("init", k)) > 0}
  depends_on = [
    proxmox_vm_qemu.createvm,
  ]
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3s_version} INSTALL_K3S_EXEC=\"server\" sh -s - --disable servicelb --disable traefik --write-kubeconfig-mode 644 --write-kubeconfig /tmp/kubeconfig_org.yaml --token ${random_string.k3s_token.result} ${each.value.additional_k3s_install_args} --tls-san ${var.clustername}.localdomain  --etcd-snapshot-schedule-cron '${var.etcd-snapshot-schedule-cron}' --etcd-snapshot-retention 14 --etcd-s3 --etcd-snapshot-schedule-cron ${var.etcd-snapshot-schedule-cron} --etcd-s3-endpoint ${var.etcd-s3-endpoint} --etcd-s3-access-key ${var.etcd-s3-access-key} --etcd-s3-secret-key ${var.etcd-s3-secret-key} --etcd-s3-region ${var.etcd-s3-region} --etcd-s3-folder ${var.etcd-s3-folder}  --etcd-s3-bucket backup-cluster-${var.clustername} --cluster-init",
      "sleep 15",
      "sed 's/127.0.0.1/${var.clustername}.localdomain/g; s/default/${var.clustername}/g;' /tmp/kubeconfig_org.yaml > /tmp/kubeconfig_new.yaml"
    ]
    connection {
      private_key = file("${var.private_key}")
      user     = "automation"
      host     = "${phpipam_first_free_address.newip[each.key].ip_address}"
    }
  
  }
}


resource "null_resource" "k3s_join" {
for_each = {for k, v in var.nodes: k => v if length(regexall("join", k)) > 0}
  depends_on = [
    null_resource.k3s_init,
  ]
  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=${var.k3s_version} INSTALL_K3S_EXEC=\"server\" sh -s - --disable servicelb --disable traefik --write-kubeconfig-mode 644 --token ${random_string.k3s_token.result} ${each.value.additional_k3s_install_args} --tls-san ${var.clustername}.localdomain --etcd-snapshot-schedule-cron '${var.etcd-snapshot-schedule-cron}' --etcd-snapshot-retention 14 --etcd-s3 --etcd-snapshot-schedule-cron '${var.etcd-snapshot-schedule-cron}' --etcd-s3-endpoint ${var.etcd-s3-endpoint} --etcd-s3-access-key ${var.etcd-s3-access-key} --etcd-s3-secret-key ${var.etcd-s3-secret-key} --etcd-s3-region ${var.etcd-s3-region} --etcd-s3-folder ${var.etcd-s3-folder}  --etcd-s3-bucket backup-cluster-${var.clustername} --server https://${phpipam_first_free_address.newip["init"].ip_address}:6443 || true",    
      ]

    connection {
      private_key = file("${var.private_key}")
      user     = "automation"
      host     = "${phpipam_first_free_address.newip[each.key].ip_address}"
    }
  
  }
}

resource "null_resource" "k3s_kubeconfig" {
for_each = {for k, v in var.nodes: k => v if length(regexall("init", k)) > 0}
  depends_on = [
    null_resource.k3s_init,
  ]
  provisioner "local-exec" {
    command = <<-EOT
      ! kubectl config delete-context ${var.clustername}
      ! kubectl config delete-user ${var.clustername} 
      ! kubectl config delete-cluster ${var.clustername}
      scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null automation@${each.value.name}.${var.local_dns_domain}:/tmp/kubeconfig_new.yaml /tmp/kubeconfig_new.yaml
      cp ~/.kube/config ~/.kube/config.bak && KUBECONFIG=~/.kube/config:/tmp/kubeconfig_new.yaml kubectl config view --flatten > /tmp/config && mv /tmp/config ~/.kube/config
      rm /tmp/kubeconfig_new.yaml  
    EOT
  }

}

output "hosts" {
  value =  [for u in proxmox_vm_qemu.createvm:u.name]
}

output "ip_addresses" {
  value =  [for u in proxmox_vm_qemu.createvm:u.ipconfig0]
}