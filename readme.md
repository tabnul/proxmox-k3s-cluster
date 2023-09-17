## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.7.0 |
| <a name="requirement_phpipam"></a> [phpipam](#requirement\_phpipam) | 1.2.8 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_phpipam"></a> [phpipam](#provider\_phpipam) | 1.2.8 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.backup](https://registry.terraform.io/providers/hashicorp/aws/3.7.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.backup](https://registry.terraform.io/providers/hashicorp/aws/3.7.0/docs/resources/s3_bucket_public_access_block) | resource |
| [null_resource.adguard_dns_overrides_pt](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.k3s_init](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.k3s_join](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.k3s_kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [phpipam_first_free_address.newip](https://registry.terraform.io/providers/lord-kyron/phpipam/1.2.8/docs/resources/first_free_address) | resource |
| [proxmox_vm_qemu.createvm](https://registry.terraform.io/providers/Telmate/proxmox/2.9.0/docs/resources/vm_qemu) | resource |
| [random_string.k3s_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [phpipam_subnet.subnet](https://registry.terraform.io/providers/lord-kyron/phpipam/1.2.8/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adguard_base_url"></a> [adguard\_base\_url](#input\_adguard\_base\_url) | the base-url of adguard | `string` | `""` | no |
| <a name="input_adguard_password"></a> [adguard\_password](#input\_adguard\_password) | the password of adguard to use for dns registration | `string` | `""` | no |
| <a name="input_adguard_python_path"></a> [adguard\_python\_path](#input\_adguard\_python\_path) | the path to the python wrapper used to register the hosts in adguard home | `string` | `"./requirements/manage_overrides.py"` | no |
| <a name="input_adguard_user"></a> [adguard\_user](#input\_adguard\_user) | the username of adguard to use for dns registration | `string` | `""` | no |
| <a name="input_bios"></a> [bios](#input\_bios) | the bios to use in proxmox | `string` | `"ovmf"` | no |
| <a name="input_clonename"></a> [clonename](#input\_clonename) | the name of the VM template to use as a source VM | `string` | `""` | no |
| <a name="input_clustername"></a> [clustername](#input\_clustername) | the name of the cluster to setup | `string` | `"xxxx"` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | the type of CPU to use in proxmox | `string` | `"host"` | no |
| <a name="input_dns_server"></a> [dns\_server](#input\_dns\_server) | the ip address of the dns server for the host to use | `string` | `""` | no |
| <a name="input_etcd-s3-access-key"></a> [etcd-s3-access-key](#input\_etcd-s3-access-key) | the s3 access key to use for communicating with S3 for the ETCD database backup | `string` | `""` | no |
| <a name="input_etcd-s3-endpoint"></a> [etcd-s3-endpoint](#input\_etcd-s3-endpoint) | regional s3 endpoint to use for the ETCD database backup | `string` | `"s3.eu-central-1.amazonaws.com"` | no |
| <a name="input_etcd-s3-folder"></a> [etcd-s3-folder](#input\_etcd-s3-folder) | the path in the S3 bucket for the ETCD database backup | `string` | `"etcd"` | no |
| <a name="input_etcd-s3-region"></a> [etcd-s3-region](#input\_etcd-s3-region) | the region of the S3 bucket for the ETCD database backup | `string` | `""` | no |
| <a name="input_etcd-s3-secret-key"></a> [etcd-s3-secret-key](#input\_etcd-s3-secret-key) | the s3 secret key to use for communicating with S3 for the ETCD database backup | `string` | `""` | no |
| <a name="input_etcd-snapshot-schedule-cron"></a> [etcd-snapshot-schedule-cron](#input\_etcd-snapshot-schedule-cron) | the cron schedule used to backup the ETCD database to S3 | `string` | `"0 1 * * *"` | no |
| <a name="input_full_clone"></a> [full\_clone](#input\_full\_clone) | perform a full clone to setup the VM | `bool` | `"true"` | no |
| <a name="input_gateway"></a> [gateway](#input\_gateway) | the ip address of the gateway for the host to use | `string` | `"10.100.1.5"` | no |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | the version of k3s to install | `string` | `"v1.22.5+k3s1"` | no |
| <a name="input_local_dns_domain"></a> [local\_dns\_domain](#input\_local\_dns\_domain) | the domainname to use for the adguard dns registration | `string` | `""` | no |
| <a name="input_mount_data_url"></a> [mount\_data\_url](#input\_mount\_data\_url) | the http path to the mount\_data.sh file , used for provisioning the system | `string` | `""` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | definition of the 3 nodes to setup (see examples) | `map` | `{}` | no |
| <a name="input_os_disksize"></a> [os\_disksize](#input\_os\_disksize) | the os disksize | `string` | `"30G"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | the os\_type to use for the proxmox VM | `string` | `"cloud-init"` | no |
| <a name="input_phpipam_appid"></a> [phpipam\_appid](#input\_phpipam\_appid) | the appid to use to communicate with the PHPIPAM API | `string` | `"terraform"` | no |
| <a name="input_phpipam_password"></a> [phpipam\_password](#input\_phpipam\_password) | the password to use to communicate with the PHPIPAM API | `string` | `""` | no |
| <a name="input_phpipam_subnet_adress"></a> [phpipam\_subnet\_adress](#input\_phpipam\_subnet\_adress) | the subnet address to use for PHPIPam IP registration | `string` | `""` | no |
| <a name="input_phpipam_subnet_mask"></a> [phpipam\_subnet\_mask](#input\_phpipam\_subnet\_mask) | the subnet mask to use for PHPIPam IP registration | `string` | `""` | no |
| <a name="input_phpipam_url"></a> [phpipam\_url](#input\_phpipam\_url) | the url of PHPIPAM | `string` | `""` | no |
| <a name="input_phpipam_username"></a> [phpipam\_username](#input\_phpipam\_username) | the user to use to communicate with the PHPIPAM API | `string` | `""` | no |
| <a name="input_pm_api_url"></a> [pm\_api\_url](#input\_pm\_api\_url) | the URL of the Proxmox API | `string` | `""` | no |
| <a name="input_pm_password"></a> [pm\_password](#input\_pm\_password) | the api password | `string` | `""` | no |
| <a name="input_pm_user"></a> [pm\_user](#input\_pm\_user) | the api username | `string` | `"terraform@pve"` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | the path to the private key used to communicate/ssh with the new hosts | `string` | `"~/.ssh/id_rsa"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hosts"></a> [hosts](#output\_hosts) | n/a |
| <a name="output_ip_addresses"></a> [ip\_addresses](#output\_ip\_addresses) | n/a |
