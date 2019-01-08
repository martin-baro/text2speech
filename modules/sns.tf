

resource "aws_sns_topic" "t2s_sns_topic" {
    name = "t2s_new_posts"

    tags = {
        Name = "Text to Speech SNS topic"
        Environment = "Prod"
        App = "Text2Speech"  
    }
}