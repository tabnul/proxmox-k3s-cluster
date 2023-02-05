clustername = "example-cluster"
nodes = {
        "init" = {
            "name" = "example-cluster-node1",
            "target_node" = "proxmoxhost1",
            "groups" = "\"k3s\""
            "targetstorage" = "VMData"
            "additional_k3s_install_args" = "--node-label workertype=master --node-taint node-role.kubernetes.io/master=effect:NoSchedule"
            "cpu_cores" = "1"
            "memory" = "3072"
            "osdisksize" = "30G"
            "datadisksize" = "10G"
        },
        "join-1" = {
            "name" = "example-cluster-node2",
            "target_node" = "proxmoxhost2",
            "groups" = "\"k3s\""
            "targetstorage" = "VM"
            schedule = "schedule"
            "additional_k3s_install_args" = "--node-label workertype=normal"
            "cpu_cores" = "2"
            "memory" = "4096"
            "osdisksize" = "30G"
            "datadisksize" = "100G"
        }
        "join-2" = {
            "name" = "example-cluster-node3",
            "target_node" = "proxmoxhost3"
            "groups" = "\"k3s\""
            "targetstorage" = "VM"
            schedule = "schedule"
            "additional_k3s_install_args" = "--node-label workertype=normal"
            "cpu_cores" = "2"
            "memory" = "4096"
            "osdisksize" = "30G"
            "datadisksize" = "100G"
        }
    }
k3s_version = "v1.22.5+k3s1"
full_clone = "true"
pm_api_url = "https://proxmoxhost.localdomain:8006/api2/json"
pm_password = "PASSWORD"
pm_user = "USERNAME@pve"
clonename = "ubuntu2004-12-2021"
dns_server = "10.10.10.3"
gateway = "10.10.10.5"
bios = "ovmf"
os_type = "cloud-init"
cpu = "host"
phpipam_url = "https://ipam.localdomain/api"
phpipam_username = "USER"
phpipam_password = "PASSWORD"
phpipam_appid = "terraform"
phpipam_subnet_adress = "10.10.10.192"
phpipam_subnet_mask = "26"
adguard_base_url = "http://adguard.localdomain"
adguard_user = "USERNAME"
adguard_password = "PASSWORD"
local_dns_domain = "localdomain"
private_key = "~/.ssh/id_rsa"
etcd-snapshot-schedule-cron = "0 1 * * *"
etcd-s3-endpoint = "s3.eu-central-1.amazonaws.com"
etcd-s3-access-key = "ACCESSKEY"
etcd-s3-secret-key = "SECRETKEY"
etcd-s3-region = "eu-central-1"
etcd-s3-folder = "etcd"
mount_data_url = "http://host.com/mount_data.sh"
adguard_python_path = "./requirements/manage_overrides.py"
