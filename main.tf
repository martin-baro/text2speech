provider "aws" {
    shared_credentials_file = "creds"
    region = "eu-west-1"
    profile = "aws"
}

module "Text2Speech" {
    source = "./modules/"
}

/*
data "aws_iam_user" "akarmi" {
    user_name = "martin"
}

output "arn" {
    value = "${data.aws_iam_user.akarmi.arn}"
}

*/
