variable "t2s_s3_audio_bucket_name_c" {}

resource "aws_s3_bucket" "t2s_audio_bucket" {
    bucket = "${var.t2s_s3_audio_bucket_name_c}"
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