provider "aws" {
    shared_credentials_file = "creds"
    region = "eu-west-1"
    profile = "aws"
}

variable "s3_audio_bucket_name" {
}
variable "s3_static_website_bucket_name" {
}

module "Text2Speech" {
    source = "./modules/"
    s3_audio_bucket_name = "${var.s3_audio_bucket_name}"
    s3_static_website_bucket_name = "${var.s3_static_website_bucket_name}"
}

output "api_gw_url" {
  value = "${module.Text2Speech.api_gw_url}"
}
output "web_url" {
  value = "${module.Text2Speech.website_url}"
}


