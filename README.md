# Text to speech serverless app deplyment
Terraform configuration to deploy a serverless text to speech application on AWS.

## Prerequisites

- Install Terraform:
  https://www.terraform.io/

- Create an AWS account

## The application
The serverless webapp utilize S3 static website, API-GW, dynamoDB, Polly, etc to convert input text to mp3 (in the selected language/voice) and store it in S3.

Application design is based on the following AWS guide:
https://aws.amazon.com/blogs/machine-learning/build-your-own-text-to-speech-applications-with-amazon-polly/

The App with this configuration only deploys English and Dutch languages, but can be extended by editing the  code/index.html '<select id="voiceSelected">' tag with correct voice names from the following site:
  
https://docs.aws.amazon.com/polly/latest/dg/voicelist.html


## Deployment

### Create an AWS credentials file in the project directory called "creds" with the following informations:
```
[aws]
aws_access_key_id=
aws_secret_access_key=
aws_default_region=
```

### Use Terraform to deploy the infrastructure
```
terraform plan
terraform apply
```

Terraform will ask for the following input variables:
```
var.s3_audio_bucket_name : the S3 globally unique bucket name for storing the output mp3 files
var.s3_static_website_bucket_name : the S3 globally unique bucket name for the static website (the url by default)
```

Terraform will provide the following two outputs:
```
api_gw_url : the invoke url for the API-GW
web_url : the site url (default S3 domain name)
```
