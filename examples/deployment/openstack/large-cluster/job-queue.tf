resource "openstack_compute_instance_v2" "job-queue" {
 
    depends_on = ["openstack_compute_instance_v2.salt-master"]

  	image_id = "${var.image_id}"
	flavor_name = "${var.jobmaster_flavor}"
	security_groups = ["${openstack_compute_secgroup_v2.allow-traffic.name}", "${var.default_sg}"]
	name = "butler-job-queue"
	network = {
		name = "${var.network_name}"
	}
	connection {
		user = "${var.user}"
	 	private_key = "${file(var.key_file)}"
	 	bastion_private_key = "${file(var.key_file)}"
	 	bastion_host = "${var.bastion_host}"
	 	bastion_user = "${var.bastion_user}"
	 	
	}
	key_pair = "${var.key_pair}"

	provisioner "file" {
	  source = "salt_setup.sh"
	  destination = "/tmp/salt_setup.sh"
	}
	provisioner "remote-exec" {
	  inline = [
	    "chmod +x /tmp/salt_setup.sh",
	    "/tmp/salt_setup.sh ${null_resource.masterip.triggers.address} job-queue \"job-queue, consul-client\""
	  ]
	}
}

