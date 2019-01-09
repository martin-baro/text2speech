
resource "aws_lambda_function" "t2s_lambda_new_post" {
    filename = "modules/t2s_lambda_new_post.zip"
    function_name = "t2s_lambda_new_post"
    role = "${aws_iam_role.t2s_iam_role_for_lambda.arn}"
    handler = "lambda_handler"
    source_code_hash = "${base64sha256(file("modules/t2s_lambda_new_post.zip"))}"
    runtime = "python2.7"

    environment {
        variables = {
            SNS_TOPIC = "${aws_sns_topic.t2s_sns_topic.arn}"
            DB_TABLE_NAME = "t2s_posts"
        }
    }
}