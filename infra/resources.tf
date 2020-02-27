# RDS password
data "aws_ssm_parameter" "rds_password_get" {
  name = "usersdb_password"
}

# RDS
resource "aws_db_instance" "usersdb" {
  engine		= "mysql"
  instance_class	= "db.t2.micro"
  name			= "usersdb"
  identifier		= "usersdb"
  allocated_storage	= 5
  username		= "admin"
  password		= "${data.aws_ssm_parameter.rds_password_get.value}"
  skip_final_snapshot	= true
}

# RDS access for Lambda
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

