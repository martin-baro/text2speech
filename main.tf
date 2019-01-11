provider "aws" {
    shared_credentials_file = "creds"
    region = "eu-west-1"
    profile = "aws"
}

module "Text2Speech" {
    source = "./modules/"
}

output "api_gw_url" {
  value = "${module.Text2Speech.api_gw_url}"
}

