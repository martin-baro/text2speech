provider "aws" {
    shared_credentials_file = "creds"
    region = "eu-west-1"
    profile = "aws"
}

variable "t2s_s3_audio_bucket_name" {
    default = "t2s_audio_bucket"
}

module "Text2Speech" {
    source = "./modules/"
    t2s_s3_audio_bucket_name_c = "${var.t2s_s3_audio_bucket_name}"
}

/*
data "aws_iam_user" "akarmi" {
    user_name = "martin"
}

output "arn" {
    value = "${data.aws_iam_user.akarmi.arn}"
}

*/
