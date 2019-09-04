#----------------------------------
# My Terraform
#
# Build WebServer
#
# Made by Andrei Leonovich
#-----------------------------------


provider "aws" {
  access_key = "AKIAZIXMLL5SLANVTC62"
  secret_key = "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"
  region     = "eu-central-1"
}


resource "aws_instance" "my_webserver" {
  ami                    = "ami-026d3b3672c6e7b66" #Amazon Ubuntu AMI
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = file("WebServer.sh")

  tags = {
    Name    = "MyWebServer"
    Owner   = "Andrei Leonovich"
    Project = "MyLessonTerraform-2"
  }
}


resource "aws_security_group" "my_webserver" {
  name        = "WebServer_SecurityGroup"
  description = "my_first_security_group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "MyWebServer SecurityGroup"
    Owner   = "Andrei Leonovich"
    Project = "MyLessonTerraform-2"
  }
}
