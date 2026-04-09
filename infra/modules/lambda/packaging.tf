resource "null_resource" "build" {
  count = var.build_command != "" ? 1 : 0

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = var.build_command
    working_dir = var.build_working_dir != "" ? var.build_working_dir : path.module
  }
}

data "archive_file" "lambda_zip" {
  depends_on  = [null_resource.build]
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/.terraform/archive/${var.function_name}.zip"
}
