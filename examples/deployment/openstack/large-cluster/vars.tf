
variable "user_name" {
	default="CHANGE_ME"
}
variable "password" {
	default="CHANGE_ME"
}
variable "tenant_name" {
	default="GenomicsVL_Devt"
}
variable "auth_url" {
	default="https://keystone.rc.nectar.org.au:5000/v2.0/"
}

variable "key_pair" {
	default="cloudman_key_pair"
}


variable "bastion_key_file" {
     default="/mnt/butler/butler/cloudman_key_pair.pem"
}

variable "bastion_host" {
    default="130.56.249.31"

}

variable "bastion_user" {
	default = "ubuntu"
}

variable "image_id" {
	default = "f603db16-7adf-48a6-964f-1905f86fa31e"
}

variable "user" {
	default = "ec2-user"
}

variable "key_file" {
    default="/mnt/butler/butler/cloudman_key_pair.pem"
}

variable "network_name" {
	default = "Classic Provider"
}

variable "main_network_id" {
	default="00000000-0000-0000-0000-000000000000"
}

variable "pan_prostate_network_id" {
	default="00000000-0000-0000-0000-000000000000"
}
variable "gnos_network_id" {
	default="00000000-0000-0000-0000-000000000000"
}

variable "floatingip_pool" {
	default = ""
}

variable "worker_flavor" {
	default = "m2.medium"
}

variable "saltmaster_flavor" {
	default = "m2.medium"
}

variable "dbserver_flavor" {
	default = "m2.medium"
}

variable "dbmaster_flavor" {
	default = "m2.medium"
}

variable "jobmaster_flavor" {
	default = "m2.medium"
}

variable "jobqueue_flavor" {
	default = "m2.medium"
}

variable "tracker_flavor" {
	default = "m2.medium"
}

variable "default_sg" {
	default = "CloudMan"
}

