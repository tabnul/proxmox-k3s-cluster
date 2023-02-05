# Description
A basic Terraform template i created to setup my local k3s clusters. It is far from perfect but gets the job done.

- Creates a multi-node k3s cluster on top of a Proxmox Hypervisor. In my example i deploy a 3 node cluster with 2 workers and 3 masters.
- Adds a secondary data disk to the nodes (in my case for use with Longhorn storage)
- IP adresses are registered in PHPIPAM
- DNS Records are created in Adguard Home
- S3 buckets are created in AWS, Cluster etcd backup is configured to target the created bucket
- The local profiles are setup to ease connection to the kubernetes cluster. (i am assing a terraform execution from a client system )
- Some json code containing a groupname is added to the instance metadata, so it can be managed by Ansible AWX using the Proxmox inventory plugin.

# Notes
- Requires an EFI OS Image, preferably Debian based
- Requires a cloud-init enabled image

# Prerequisites
- requirements/mount_data.sh needs to be available from HTTP from within the VM (it is fetched and executed as part of the provisioning)

# future plans:
- make the template more dynamic
- automate the deployment of ArgoCD GitOps onto the cluster (and from there let ArgoCD deploy the last-mile)