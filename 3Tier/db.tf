resource "aws_db_instance" "app_db" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "app_db"
  username             = "db_user"
  password             = "Str€ngPW47d!"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
