

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
resource "aws_s3_bucket" "t2s_s3_static_website" {
    bucket = "${local.t2s_s3_static_website_bucket_name}"
    acl = "public-read"

    website {
        index_document = "index.html"
    }
}

resource "aws_s3_bucket_object" "index" {
  bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
  key = "index.html"
  source = "code/index.html"
}
resource "aws_s3_bucket_object" "scripts" {
  bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
  key = "scripts.js"
  source = "tmp/scripts.js"
}
resource "aws_s3_bucket_object" "styles" {
  bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
  key = "styles.css"
  source = "code/styles.css"
}

output "website_url" {
    value = "${aws_s3_bucket.t2s_s3_static_website.bucket_domain_name}"
}