resource "aws_instance" "my_instance" {
  ami               = "ami-0447a12f28fddb066"
  instance_type     = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name = "my_key"
  subnet_id     = "${aws_subnet.my_subnet.id}"
  security_groups = [ "${aws_security_group.my_sec_group.id}" ]
 
 
  tags = {
        Name = "mywebserver-2"
  }

	connection {

	type = "ssh"
	user = "ec2-user"
	private_key = tls_private_key.my_key.private_key_pem
	host = aws_instance.my_instance.public_ip

        }


	provisioner "remote-exec"{
		
		inline = [
			
		"sudo yum install httpd git amazon-efs-utils nfs-utils -y",
                "sudo systemctl start httpd",
                "sudo systemctl enable httpd",
                
		]
	}


}