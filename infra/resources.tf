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
data "aws_ssm_parameter" "rds_password_get" {
  name = "usersdb_password"
}

# RDS
resource "aws_db_instance" "usersdb" {
  engine		= "mysql"
  instance_class	= "db.t2.micro"
  name			= "usersdb"
  allocated_storage	= 5
  username		= "admin"
  password		= "${data.aws_ssm_parameter.rds_password_get.value}"
  skip_final_snapshot	= true
}

# Lambda
#resource "aws_lambda_function" "lambda_get_name" {
#  filename		= local.lambda_get_name_zip
#  function_name	= "${var.envtype}_lambda_get_name"
#  role			= aws_iam_role.role_lambda_create_database.arn
#  handler		= "lambda_handler"
#  source_code_hash	= filebase64sha256(local.lambda_get_name_zip)
#  runtime		= "python2.7"
#  publish		= true
#}
