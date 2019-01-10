

resource "aws_sns_topic" "t2s_sns_topic" {
    name = "t2s_new_posts"
}
resource "aws_sns_topic_subscription" "t2s_sns_topic_lambda_sub" {
  topic_arn = "${aws_sns_topic.t2s_sns_topic.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.t2s_lambda_convert_to_audio.arn}"
}