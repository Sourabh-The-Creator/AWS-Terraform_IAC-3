resource "aws_efs_file_system" "my_efs" {
  creation_token = "my_efs"
  performance_mode = "generalPurpose"
  tags = {
    Name = "my_efs"
  }
}

resource "aws_efs_mount_target" "my_target" {
  file_system_id = "${aws_efs_file_system.my_efs.id}"
  subnet_id      = "${aws_subnet.my_subnet.id}"
  security_groups = [ "${aws_security_group.my_sec_group.id}" ]
}


output "efs_id"{

        value=aws_efs_file_system.my_efs.id

}