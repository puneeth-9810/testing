provider "aws" {
  region = "ap-south-1" # Change if needed
}

resource "aws_instance" "spring_ec2" {
  ami           = "ami-08e5424edfe926b43" # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"
  key_name      = "test"

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "spring-boot-ec2"
  }

    user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker git -y
              sudo service docker start
              sudo usermod -aG docker ec2-user
              docker login -u puneeth9810 -p $DOCKERHUB_TOKEN
              docker pull puneeth9810/spring-ec2-demo:latest
              docker run -d -p 8080:8080 --name spring-ec2-demo puneeth9810/spring-ec2-demo:latest
              EOF

}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow 22 and 8080"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

