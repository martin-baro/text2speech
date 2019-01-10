

#The REST API is the container for the API gateways
resource "aws_api_gateway_rest_api" "t2s_api_gw_rest_api" {
    name = "t2s_api_gw_rest_api"
    description = " API gateway for Text 2 Speech application"
}
#The actual API gateway for the Text to Speech application
resource "aws_api_gateway_resource" "t2s_api_gw" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    parent_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.root_resource_id}"
    path_part = "{proxy+}"
}
#The GET method for the API GW
resource "aws_api_gateway_method" "t2s_api_gw_GET" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "GET"
    authorization = "NONE"
}
#The GET method integration to the get_post Lambda function
resource "aws_api_gateway_integration" "t2s_api_gw_GET_intergration" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "${aws_api_gateway_method.t2s_api_gw_GET.http_method}"

    integration_http_method = "GET"
    type = "AWS_PROXY"
    uri = "${aws_lambda_function.t2s_lambda_get_post.invoke_arn}"

}
#The POST method for the API GW
resource "aws_api_gateway_method" "t2s_api_gw_POST" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "POST"
    authorization = "NONE"
}
#The POST method integration to the new_post Lambda function
resource "aws_api_gateway_integration" "t2s_api_gw_POST_intergration" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "${aws_api_gateway_method.t2s_api_gw_POST.http_method}"

    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = "${aws_lambda_function.t2s_lambda_new_post.invoke_arn}"
    
}
/*
----------------------- Enabling CORS ---------------------
*/

#The OPTIONS method for CORS
resource "aws_api_gateway_method" "t2s_api_gw_OPTIONS" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "OPTIONS"
    authorization = "NONE"
}
#The OPTIONS method response 200 with the CORS headers enabled 
resource "aws_api_gateway_method_response" "t2s_api_gw_OPTIONS_response" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "${aws_api_gateway_method.t2s_api_gw_OPTIONS.http_method}"
    status_code = 200

    response_models {
        "application/json" = "Empty"
    }

    response_parameters {
        "method.response.header.Access-Control-Allow-Headers" = true
        "method.response.header.Access-Control-Allow-Methods" = true
        "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

#The OPTIONS method integration to a MOCK object
resource "aws_api_gateway_integration" "t2s_api_gw_OPTIONS_integration" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "${aws_api_gateway_method.t2s_api_gw_OPTIONS.http_method}"    
    type = "MOCK"

    # https://stackoverflow.com/questions/43990464/api-gateway-mock-integration-fails-with-500/44013347#44013347
    request_templates {
        "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
    }
}

#The MOCK object integration response with the CORS headers enabled
resource "aws_api_gateway_integration_response" "t2s_api_gw_OPTIONS_integration_resp" {
    rest_api_id = "${aws_api_gateway_rest_api.t2s_api_gw_rest_api.id}"
    resource_id = "${aws_api_gateway_resource.t2s_api_gw.id}"
    http_method = "${aws_api_gateway_method.t2s_api_gw_OPTIONS.http_method}"
    status_code = "${aws_api_gateway_method_response.t2s_api_gw_OPTIONS_response.http_method}"

    response_parameters = {
        "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
        "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"
        "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

