resource "aws_instance" "main" {
  ami = "ami-04f7a2422d6265628"
  instance_type = "t3.micro"
  key_name = "hharmon"
  subnet_id = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_default_security_group.main.id]
  tags = {
    "Name" = "${var.default_tags.env}-EC2"
  }
  user_data = base64encode(file("/Users/user/Desktop/Terraform/user.sh"))
}

resource "aws_default_security_group" "main" {
  vpc_id = aws_vpc.main.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}