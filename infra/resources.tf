# RDS
resource "aws_db_instance" "usersdb" {
  engine		= "mysql"
  instance_class	= "db.t2.micro"
  name			= "usersdb"
  allocated_storage	= 5
  username		= ""
  password		= ""
  skip_final_snapshot	= true
}
