resource "aws_instance" "first_instance" {
ami       = "ami-03c7c1f17ee073747"
instance_type  = "t2.micro"
key_name     = "sshy"
tags = { 
  Name = "test_instance"
  }
}

