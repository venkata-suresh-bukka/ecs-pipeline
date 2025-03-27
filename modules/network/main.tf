resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ecs-vpc"
  }
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecs-igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT Gateway for Private Subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "ecs-nat-gateway"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id           = aws_vpc.main.id
  cidr_block       = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "ecs-public-subnet-${count.index + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id           = aws_vpc.main.id
  cidr_block       = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "ecs-private-subnet-${count.index + 1}"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecs-public-rt"
  }
}

# Public Route - IGW
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecs-private-rt"
  }
}

# Private Route - NAT Gateway
resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


# ✅ Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main.id

  # Allow SSH from your IP only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-security-group"
  }
}
resource "aws_key_pair" "bastion_key" {
  key_name   = "my-key-pair"  # The name of the key pair in AWS
  public_key = file("my-key-pair.pub")  # Read the public key from the local file
}

# ✅ Bastion Host in Public Subnet
resource "aws_instance" "bastion" {
  ami                    = "ami-08b5b3a93ed654d19" # Amazon Linux 2 (Update if needed)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.bastion_key.key_name
  subnet_id              = aws_subnet.public[0].id  # ✅ First public subnet
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }
}

# ✅ Allow Bastion to Access Private RDS
resource "aws_security_group_rule" "bastion_to_db" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = var.db_sg_id
  source_security_group_id = aws_security_group.bastion_sg.id
}
 