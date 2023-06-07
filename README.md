# AWS ec2 instance ssh-key pair using terraform

A key pair is a combination of a public key that is used to encrypt data and a private key that is used to decrypt data. For more information about key pairs, ensure you are signed into the AWS console and then review Amazon EC2 Key Pairs in the Amazon EC2 User Guide for Linux Instances.

## creating ssh-key 
```
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key"      
  # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { 
  # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}

## Adding key to ec2 instance

resource "aws_instance" "new_instance" {
ami       = "ami-03c7c1f17ee073747"
instance_type  = "t2.micro"
key_name     = "key"
tags = { 
  Name = "new_instance"
    }
}
```
## Usage

To run this example you need to execute:

$ terraform init
$ terraform plan
$ terraform apply

> Note that this example may create resource which cost money. Run terraform destroy when you don't need these resource

