# Create VPC
resource "aws_vpc" "vp1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Elb-vpc"
    Team = "wdp"
    env  = "dev"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gtw1" {
  vpc_id = aws_vpc.vp1.id
}

# Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.vp1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.vp1.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

# Private Subnet 1
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.vp1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

# Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.vp1.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
}

# Elastic IP for NAT
resource "aws_eip" "nat1" {

}

# NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public1.id
}

# Public Route Table
resource "aws_route_table" "rtpu" {
  vpc_id = aws_vpc.vp1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw1.id
  }
}

# Private Route Table
resource "aws_route_table" "rtpri" {
  vpc_id = aws_vpc.vp1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

# Route Table Associations
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.rtpu.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rtpu.id
}

resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.rtpri.id
}

resource "aws_route_table_association" "rta4" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.rtpri.id
}
