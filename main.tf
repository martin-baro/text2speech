provider "aws" {
    shared_credentials_file = "creds"
    region = "eu-west-1"
    profile = "aws"
}

resource "aws_instance" "test" {
    ami = "ami-09693313102a30b2c"
    instance_type = "t2.micro"  
}

data "aws_iam_user" "akarmi" {
    user_name = "martin"
}

output "arn" {
    value = "${data.aws_iam_user.akarmi.arn}"
}

