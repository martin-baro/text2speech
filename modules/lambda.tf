

#Pack the python file 
data "archive_file" "t2s_lambda_new_post_zip" {
  type        = "zip"
  source_file = "modules/t2s_lambda_new_post.py"
  output_path = "modules/t2s_lambda_new_post.zip"
}

resource "aws_lambda_function" "t2s_lambda_new_post" {
    filename = "modules/t2s_lambda_new_post.zip"
    function_name = "t2s_lambda_new_post"
    role = "${aws_iam_role.t2s_iam_role_for_lambda.arn}"
    handler = "lambda_handler"
    source_code_hash = "${data.archive_file.t2s_lambda_new_post_zip.output_base64sha256}"
    runtime = "python2.7"

    environment {
        variables = {
            SNS_TOPIC = "${aws_sns_topic.t2s_sns_topic.arn}"
            DB_TABLE_NAME = "t2s_posts"
        }
    }
}