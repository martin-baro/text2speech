

variable "s3_audio_bucket_name" {}
variable "s3_static_website_bucket_name" {}


locals {
  t2s_s3_audio_bucket_name = "${var.s3_audio_bucket_name}"
  t2s_s3_static_website_bucket_name = "${var.s3_static_website_bucket_name}"
}