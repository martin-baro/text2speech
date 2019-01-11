

data "template_file" "scripts_tpl" {
    depends_on = ["aws_api_gateway_deployment.t2s_api_gw_deploy"]
    template = "${file("${path.cwd}/code/scripts.tpl")}"

    vars {
        api_gw_url = "${aws_api_gateway_deployment.t2s_api_gw_deploy.invoke_url}"
    }
}

resource "local_file" "scripts_js" {
    content = "${data.template_file.scripts_tpl.rendered}"
    filename = "tmp/scripts.js"
}


