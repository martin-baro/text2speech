

resource "aws_s3_bucket" "t2s_audio_bucket" {
    bucket = "t2s_audio_bucket"
    acl = "private"

    tags = {
        Name = "t2s_audio_bucket"
        Environment = "Prod"
        App = "Text2Speech"
    }
}
