


resource "aws_iam_role" "t2s_iam_role_for_lambda" {
    name = "t2s_iam_role"

    assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
                "polly:SynthesizeSpeech",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "sns:Publish",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
           ],
           "Resource": [
               "*"
           ]
       }
   ]
}
EOF

}