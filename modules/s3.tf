

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

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${local.t2s_s3_static_website_bucket_name}/*"
        }
    ]
}
EOF
    website {
        index_document = "index.html"
    }
}

resource "aws_s3_bucket_object" "index" {
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "index.html"
    source = "code/index.html"
    content_type = "text/html"
}
resource "aws_s3_bucket_object" "scripts" {
    depends_on = ["local_file.scripts_js"]
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "scripts.js"
    source = "tmp/scripts.js"
    content_type = "application/javascript"
    etag   = "${md5(file("tmp/scripts.js"))}"
}
resource "aws_s3_bucket_object" "styles" {
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "styles.css"
    source = "code/styles.css"
    content_type = "text/css"
}

output "website_url" {
    value = "http://${aws_s3_bucket.t2s_s3_static_website.website_endpoint}"
}