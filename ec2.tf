resource "aws_instance" "server1" {
  instance_type          = var.INSTANCE_TYPE
  user_data              = file("setup.sh")
  vpc_security_group_ids = [aws_security_group.sg-demo1.id]
  subnet_id              = aws_subnet.private1.id
  availability_zone      = "${var.REGION}a"
  ami                    = "ami-0150ccaf51ab55a51"
  tags = {
    name = var.ENVIRONMENT
    
  }
}
#second ec2
resource "aws_instance" "server2" {
  instance_type          = "t2.micro"
  user_data              = file("setup.sh")
  vpc_security_group_ids = [aws_security_group.sg-demo1.id]
  subnet_id              = aws_subnet.private2.id
  availability_zone      = "us-east-1b"
  ami                    = "ami-0150ccaf51ab55a51"
  tags = {
    name = "web2"
  }
}