//creating key pair
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}


module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  key_name   = "my_key"
  public_key = tls_private_key.my_key.public_key_openssh
}
