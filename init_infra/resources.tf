# IAM
resource "aws_iam_role" "role_lambda_rds_database_settings" {
  name = "role_lambda_rds_database_settings"
  assume_role_policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesRole.json")}"
}

resource "aws_iam_policy" "policy_lambda_rds_database_settings" {
  name = "policy_lambda_rds_database_settings"
  path = "/"
  description = "Allow RDS database reading for lambda"
  policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesPolicy.json")}"
}

resource "aws_iam_role_policy_attachment" "attachment_lambda_rds_database_settings" {
  role = "${aws_iam_role.role_lambda_rds_database_settings.name}"
  policy_arn = "${aws_iam_policy.policy_lambda_rds_database_settings.arn}"
}

#  policy_arn = "${arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole}"
#  count = "${length(var.policies_for_lambda_rds_database_settings)}"
#  policy_arn = "${var.policies_for_lambda_rds_database_settings[count.index]}"

#variable "policies_for_lambda_rds_database_settings" {
#  descirption = "list of IAM policies arn for rds database settings"
#  type = "list"
#  default = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "${aws_iam_policy.policy_lambda_rds_database_settings.arn}"]
#}

# Lambda (modify name)
resource "aws_lambda_function" "lambda_set_rds" {
  filename = "${path.module}/../lambda/popipo.zip"
  function_name = "popipo2"
  role = aws_iam_role.role_lambda_rds_database_settings.arn
  handler = "init_database.get_password"
  source_code_hash = "${filebase64sha256("${path.module}/../lambda/popipo.zip")}"
  runtime = "python3.8"
  publish = true
}

