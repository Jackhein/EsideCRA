# IAM
resource "aws_iam_role" "role_lambda_rds_database_settings" {
  name = "role_lambda_rds_database_settings"
  assume_role_policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesRole.json")}"
}

resource "aws_iam_policy" "policy_lambda_rds_database_settings" {
  name = "policy_lambda_rds_database_settings"
  path = "/"
  description = "Allow RDS database settings for lambda"
  policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesPolicy.json")}"
}

resource "aws_iam_role_policy_attachment" "attachment_lambda_rds_database_settings" {
  role = "${aws_iam_role.role_lambda_rds_database_settings.name}"
  policy_arn = "${aws_iam_policy.policy_lambda_rds_database_settings.arn}"
}

# Lambda
#resource "aws_lambda_function" "lambda_set_rds" {
#  filename             = local.lambda_set_rds_zip
#  function_name        = "${var.envtype}_lambda_set_rds"
#  role                 = aws_iam_role.role_lambda_create_database.arn
#  handler              = "lambda_handler"
#  source_code_hash     = filebase64sha256(local.lambda_set_rds_zip)
#  runtime              = "python2.7"
#  publish              = true
#}

