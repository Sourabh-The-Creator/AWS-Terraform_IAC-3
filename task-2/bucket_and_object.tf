resource "aws_s3_bucket" "taskbucket2" {
  bucket = "taskbucket2"
  acl="public-read"

  tags = {
	Name = "taskbucket2"
  }
}

resource "aws_s3_bucket_public_access_block" "taskbucketpolicy" {
  bucket = "${aws_s3_bucket.taskbucket2.id}"

  block_public_acls   = false
  block_public_policy = false
}

locals {
  s3_origin_id = "S3-${aws_s3_bucket.taskbucket2.bucket}"
}

resource "aws_s3_bucket_object" "taskbucket1object" {
depends_on = [
	aws_s3_bucket.taskbucket2
]
  bucket = "taskbucket2"
  acl = "public-read"
  key    = "img.jpeg"
  source = "D:/terraform/task-2/img.jpeg"
  content_type = "image/jpeg"
}