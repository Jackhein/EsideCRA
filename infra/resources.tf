# RDS password
resource "aws_ssm_parameter" "rds_password_set" {
  name = "usersdb_password"
  type = "SecureString"
  value = random_password.password.result
}

# RDS
resource "aws_db_instance" "usersdb" {
  engine		= "mysql"
  instance_class	= "db.t2.micro"
  name			= "usersdb"
  identifier		= "usersdb"
  allocated_storage	= 5
  username		= "admin"
  password		= "${aws_ssm_parameter.rds_password_set.value}"
  skip_final_snapshot	= true
}

# RDS access for Lambda
resource "aws_iam_role" "role_lambda_rds_database_readOnly" {
  name = "role_lambda_rds_database_readOnly"
  assume_role_policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesRole.json")}"
}

resource "aws_iam_policy" "policy_lambda_rds_database_readOnly" {
  name = "policy_lambda_rds_database_readOnly"
  path = "/"
  description = "Allow RDS database reading for lambda"
  policy = "${file("${path.module}/../iam_policy/AWSLambdaRDSAccesPolicy.json")}"
}

resource "aws_iam_role_policy_attachment" "attachment_lambda_rds_database_readOnly" {
  role = "${aws_iam_role.role_lambda_rds_database_readOnly.name}"
  policy_arn = "${aws_iam_policy.policy_lambda_rds_database_readOnly.arn}"
}

