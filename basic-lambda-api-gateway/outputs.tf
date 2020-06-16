output "function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.this.id
}

output "lambda_exec_role_id" {
  description = "The name of the execution role given to the Lambda."
  value       = aws_iam_role.this.id
}

output "invoke_url" {
  description = "The URL to use when invoking the Lambda."
  value       = "${aws_api_gateway_deployment.this.invoke_url}/${aws_api_gateway_resource.this.path_part}"
}
