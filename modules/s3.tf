

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

# Upload static site files: html, js, css
resource "aws_s3_bucket_object" "index" {
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "index.html"
    source = "code/index.html"
    content_type = "text/html"
    etag = "${md5(file("code/index.html"))}"
}

resource "aws_s3_bucket_object" "styles" {
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "styles.css"
    source = "code/styles.css"
    content_type = "text/css"
    etag = "${md5(file("code/styles.css"))}"
}

#Rendering the js script with API_GW invoke url
data "template_file" "scripts_tpl" {
#    depends_on = ["aws_api_gateway_deployment.t2s_api_gw_deploy"]
    template = "${file("${path.cwd}/code/scripts_template.js")}"

    vars {
        api_gw_url = "${aws_api_gateway_deployment.t2s_api_gw_deploy.invoke_url}"
    }
}
resource "aws_s3_bucket_object" "scripts" {
    bucket = "${aws_s3_bucket.t2s_s3_static_website.bucket}"
    key = "scripts.js"
    content = "${data.template_file.scripts_tpl.rendered}"
#    source = "tmp/scripts.js"
    content_type = "application/javascript"
    etag   = "${md5(data.template_file.scripts_tpl.rendered)}"
}

output "website_url" {
    value = "http://${aws_s3_bucket.t2s_s3_static_website.website_endpoint}"
}