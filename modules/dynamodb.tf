

resource "aws_dynamodb_table" "t2s_dynmamodb_table" {
    name = "t2s_posts"
    hash_key = "id"

    attribute = [{
        name = "id"
        type = "S"
    }]

    tags = {
        Name = "Text to Speech dynamoDB table"
        Environment = "Prod"
        App = "Text2Speech"  
  }
}