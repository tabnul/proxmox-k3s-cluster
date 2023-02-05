variable "clustername" { 
  type          = string
  description   = "the name of the cluster to setup"
  default       = "xxxx"
}
variable "nodes" {
  default       = {}
  type          = map
  description   = "definition of the 3 nodes to setup (see examples)"
}

variable "k3s_version"  { 
  type          = string
  description   = "the version of k3s to install"
  default       = "v1.22.5+k3s1"
}

variable "full_clone"  { 
  type          = bool
  description   = "perform a full clone to setup the VM"
  default       = "true"
}
variable "pm_api_url" { 
  type          = string
  description   = "the URL of the Proxmox API"
  default       = ""
}
variable "pm_password" { 
  type          = string
  description   = "the api password"
  default       = ""
  sensitive     = true
}
variable "pm_user"  { 
  type          = string
  description   = "the api username"
  default       = "terraform@pve"
  sensitive     = true
}
variable "clonename"  { 
  type          = string
  description   = "the name of the VM template to use as a source VM"
  default       = ""
}
variable "dns_server"  {
  type          = string
  description   = "the ip address of the dns server for the host to use" 
  default       = ""
}
variable "gateway"  { 
  type          = string
  description   = "the ip address of the gateway for the host to use"
  default       = "10.100.1.5"
}
variable "bios" {
  type          = string
  description   = "the bios to use in proxmox"
  default       = "ovmf"
}
variable "os_type"  { 
  type          = string
  description   = "the os_type to use for the proxmox VM"
  default       = "cloud-init"
}
variable "cpu"  { 
  type          = string
  description   = "the type of CPU to use in proxmox"
  default       = "host"
}

variable "os_disksize"  { 
  type          = string
  description   = "the os disksize"
  default       = "30G"
}
variable "phpipam_url"  { 
  type          = string
  description   = "the url of PHPIPAM"
  default       = ""
}
variable "phpipam_username"  { 
  type          = string
  description   = "the user to use to communicate with the PHPIPAM API"
  default       = ""
  sensitive     = true
}
variable "phpipam_password"  { 
  type          = string
  description   = "the password to use to communicate with the PHPIPAM API"
  default       = ""
  sensitive     = true

}
variable "phpipam_appid"  { 
  type          = string
  description   = "the appid to use to communicate with the PHPIPAM API"
  default       = "terraform"
}
variable "phpipam_subnet_adress" {
  type          = string
  description   = "the subnet address to use for PHPIPam IP registration"
  default       = ""
}
variable "phpipam_subnet_mask" {
  type          = string
  description   = "the subnet mask to use for PHPIPam IP registration"
  default       = ""
}
variable "adguard_base_url"  { 
  type          = string
  description   = "the base-url of adguard"
  default       = ""
}
variable "adguard_user"  { 
  type          = string
  description   = "the username of adguard to use for dns registration"
  default       = ""
  sensitive     = true
}
variable "adguard_password"  { 
  type          = string
  description   = "the password of adguard to use for dns registration"
  default       = ""
  sensitive     = true
}
variable "local_dns_domain"  { 
  type          = string
  description   = "the domainname to use for the adguard dns registration"
  default       = ""
}
variable "private_key"  { 
  type          = string
  description   = "the path to the private key used to communicate/ssh with the new hosts"
  default       = "~/.ssh/id_rsa"
  sensitive     = true
}

variable "mount_data_url"  { 
  type          = string
  description   = "the http path to the mount_data.sh file , used for provisioning the system"
  default       = ""
}
variable "adguard_python_path"  { 
  type          = string
  description   = "the path to the python wrapper used to register the hosts in adguard home"
  default       = "./requirements/manage_overrides.py"
}
variable "etcd-snapshot-schedule-cron"  { 
  type          = string
  description   = "the cron schedule used to backup the ETCD database to S3"
  default       = "0 1 * * *"
}

variable "etcd-s3-endpoint"  {
  type          = string
  description   = "regional s3 endpoint to use for the ETCD database backup" 
  default       = "s3.eu-central-1.amazonaws.com"
}
variable "etcd-s3-access-key"  { 
  type          = string
  description   = "the s3 access key to use for communicating with S3 for the ETCD database backup"
  default       = ""
  sensitive     = true
}
variable "etcd-s3-secret-key"  { 
  type          = string
  description   = "the s3 secret key to use for communicating with S3 for the ETCD database backup"
  default       = ""
  sensitive     = true
}
variable "etcd-s3-region"  { 
  type          = string
  description   = "the region of the S3 bucket for the ETCD database backup"
  default       = ""
}
variable "etcd-s3-folder"  { 
  type          = string
  description   = "the path in the S3 bucket for the ETCD database backup"
  default       = "etcd"
}
