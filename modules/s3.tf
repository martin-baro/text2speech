

# Create audio S3 bucket
resource "aws_s3_bucket" "t2s_audio_bucket" {
    bucket = "${local.t2s_s3_audio_bucket_name}"
    acl = "private"

    tags = {
        Name = "t2s_audio_bucket"
        Environment = "Prod"
        App = "Text2Speech"
    }
}

output "audio bucket" {
    value = "${aws_s3_bucket.t2s_audio_bucket.bucket_domain_name}"
}