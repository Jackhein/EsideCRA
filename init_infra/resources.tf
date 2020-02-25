# IAM
#resource "aws_iam_role" "role_lambda_create_database" {
#  name = "role_lambda_create_database"
#  
#}

#resource "aws_iam_role_policy" "policy_create_database" {
#  name = "policy_rds_create_database_for_lambda"
#  role = aws_iam_role.role_lambda_create_database.id
#  policy = <<-EOF
#  {
#
#  }
#  EOF
#trusted entity lambda name
#permissions AWSLambdaVPCAccessEcexutionRole
#Role name lambda-vpc-rome
#}

# RDS password
resource "aws_ssm_parameter" "rds_password_set" {
  name = "usersdb_password"
  type = "SecureString"
  value = random_password.password.result
}
