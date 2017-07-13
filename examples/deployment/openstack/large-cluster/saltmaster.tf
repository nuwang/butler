resource "openstack_compute_instance_v2" "salt-master" {
  	image_id = "${var.image_id}"
	flavor_name = "${var.saltmaster_flavor}"
	security_groups = ["${openstack_compute_secgroup_v2.allow-traffic.name}", "${var.default_sg}"]
	name = "butler-salt-master"
    network = {
            uuid = "${var.main_network_id}"
    }
    connection {
		user = "${var.user}"
	 	private_key = "${file(var.key_file)}"
	 	bastion_private_key = "${file(var.bastion_key_file)}"
	 	bastion_host = "${var.bastion_host}"
	 	bastion_user = "${var.bastion_user}"
	 	
	}
	key_pair = "${var.key_pair}"
  	
	 	
	provisioner "file" {
        	source = "./master"
        	destination = "/home/ec2-user/master"
    	}
	provisioner "file" {
        	source = "./collectdlocal.pp"
        	destination = "/home/ec2-user/collectdlocal.pp"
    	}
	provisioner "file" {
	  source = "salt_setup.sh"
	  destination = "/tmp/salt_setup.sh"
	}
	provisioner "remote-exec" {
	  inline = [
	    "chmod +x /tmp/salt_setup.sh",
	    "/tmp/salt_setup.sh `sudo ifconfig eth0 | awk '/inet /{print $2}'` salt-master \"salt-master, consul-server, monitoring-server\""
	  ]
	}
	provisioner "remote-exec" {
	  inline = [
             "sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm",
             "sudo yum clean expire-cache",
		     "sudo yum install git -y",
		     "sudo yum install salt-master -y",
		     "sudo yum install salt-minion -y",
		     "sudo yum install python-pip -y",
		     "sudo yum install GitPython -y",
		     "sudo service salt-master stop",
		     "sudo mv /home/ec2-user/master /etc/salt/master",       
		     "sudo service salt-master start",
		     "sudo hostname salt-master",
		     "sudo semodule -i collectdlocal.pp",
	  ]
        }
}
