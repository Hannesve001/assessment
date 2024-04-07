provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "test_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.test_subnet.id
  vpc_security_group_ids      = [aws_security_group.test_sg.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Name                = "test_instance"
    "assessment_Hannes" = "true"
  }
}

resource "aws_eip" "test_eip" {
  instance = aws_instance.test_instance.id
  domain   = "vpc"

  tags = {
    Name                = "test_eip"
    "assessment_Hannes" = "true"
  }
}

resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name                = "test_vpc"
    "assessment_Hannes" = "true"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name                = "test_igw"
    "assessment_Hannes" = "true"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name                = "test_subnet"
    "assessment_Hannes" = "true"
  }
}

resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name                = "test_route_table"
    "assessment_Hannes" = "true"
  }
}

resource "aws_route_table_association" "test_route_table_association" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_route_table.id
}

resource "aws_security_group" "test_sg" {
  name_prefix = "test_sg_"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name                = "test_sg"
    "assessment_Hannes" = "true"
  }
}
