resource "null_resource" "null_vol_attach"  {
  depends_on = [
    aws_efs_mount_target.my_target,
  ]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key =  tls_private_key.my_key.private_key_pem
    host     = aws_instance.my_instance.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.my_efs.id}.efs.ap-south-1.amazonaws.com:/ /var/www/html",
      "sudo rm -rf /var/www/html/*",
      "sudo git clone https://github.com/Sourabh-The-Creator/aws-terraform-project2.git /var/www/html/",
      "sudo sed -i 's/url/${aws_cloudfront_distribution.my_dist.domain_name}/g' /var/www/html/index.html"
    ]
  }
}