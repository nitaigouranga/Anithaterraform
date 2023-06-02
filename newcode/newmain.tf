resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}


# add key to ec2 instance
resource "aws_instance" "new_instance" {
ami       = "ami-03c7c1f17ee073747"
instance_type  = "t2.micro"
key_name     = "key"
tags = { 
  Name = "new_instance"
    }
 }

