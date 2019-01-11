

/*
----------- Lambda function for creating new posts ---------------------
*/

#Pack the python file 
data "archive_file" "t2s_lambda_new_post_zip" {
    type = "zip"
    source_file = "code/t2s_lambda_new_post.py"
    output_path = "tmp/t2s_lambda_new_post.zip"
}

resource "aws_lambda_function" "t2s_lambda_new_post" {
    filename = "tmp/t2s_lambda_new_post.zip"
    function_name = "t2s_lambda_new_post"
    role = "${aws_iam_role.t2s_iam_role_for_lambda.arn}"
    handler = "t2s_lambda_new_post.lambda_handler"
    source_code_hash = "${data.archive_file.t2s_lambda_new_post_zip.output_base64sha256}"
    runtime = "python2.7"

    environment {
        variables = {
            SNS_TOPIC = "${aws_sns_topic.t2s_sns_topic.arn}"
            DB_TABLE_NAME = "t2s_posts" 
        }
    }
}

/*
----------- Lambda function for converting the text to audio ---------------------
*/

#Pack the python file 
data "archive_file" "t2s_lambda_convert_to_audio_zip" {
    type = "zip"
    source_file = "code/t2s_lambda_convert_to_audio.py"
    output_path = "tmp/t2s_lambda_convert_to_audio.zip"
}
resource "aws_lambda_function" "t2s_lambda_convert_to_audio" {
    filename = "tmp/t2s_lambda_convert_to_audio.zip"
    function_name = "t2s_lambda_convert_to_audio"
    role = "${aws_iam_role.t2s_iam_role_for_lambda.arn}"
    handler = "t2s_lambda_convert_to_audio.lambda_handler"
    source_code_hash = "${data.archive_file.t2s_lambda_convert_to_audio_zip.output_base64sha256}"
    runtime = "python2.7"
    timeout = 300

    environment {
        variables = {
            SNS_TOPIC = "${aws_sns_topic.t2s_sns_topic.arn}"
            BUCKET_NAME = "${local.t2s_s3_audio_bucket_name}"
        }
    }
}
resource "aws_lambda_permission" "t2s_lambda_permission_sns_trigger" {
    statement_id = "AllowExecutionFromSNS"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.t2s_lambda_convert_to_audio.arn}"
    principal = "sns.amazonaws.com"
    source_arn = "${aws_sns_topic.t2s_sns_topic.arn}"
}

/*
----------- Lambda function for searching in posts DB ---------------------
*/

#Pack the python file 
data "archive_file" "t2s_lambda_get_post_zip" {
    type = "zip"
    source_file = "code/t2s_lambda_get_post.py"
    output_path = "tmp/t2s_lambda_get_post.zip"
}

resource "aws_lambda_function" "t2s_lambda_get_post" {
    filename = "tmp/t2s_lambda_get_post.zip"
    function_name = "t2s_lambda_get_post"
    role = "${aws_iam_role.t2s_iam_role_for_lambda.arn}"
    handler = "t2s_lambda_get_post.lambda_handler"
    source_code_hash = "${data.archive_file.t2s_lambda_get_post_zip.output_base64sha256}"
    runtime = "python2.7"

    environment {
        variables = {
            DB_TABLE_NAME = "t2s_posts"
        }
    }

}
