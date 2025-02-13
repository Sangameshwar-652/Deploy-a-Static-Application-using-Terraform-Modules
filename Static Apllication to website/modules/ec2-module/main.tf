resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group]
  subnet_id     = var.subnet_id

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              EOF

  provisioner "file" {
    source      = "../index.html"  # Path to your local index.html
    destination = "/var/www/html/index.html"
  }
}

output "instance_id" {
  value = aws_instance.web_server.id
}