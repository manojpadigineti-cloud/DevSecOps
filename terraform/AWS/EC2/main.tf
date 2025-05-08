############################################################
# Networking Component Summary for Public & Private Subnets
############################################################

# Internet Gateway (IGW)
# - Used in public subnets only
# - Enables direct inbound and outbound internet access

# NAT Gateway + EIP
# - Used in private subnets only
# - Allows outbound internet access for private instances
# - Does NOT allow inbound internet access

# Elastic IP (EIP)
# - Required for NAT Gateway to communicate with the internet
# - Must be allocated and associated with the NAT Gateway

# NAT Gateway
# - Must be deployed in a public subnet
# - Routes traffic from private subnets to the internet via EIP & IGW


/*
## IGW in VPC level
In Public Subnet:
 - NAT Gateway + EIP + Route table ( 0.0.0.0/0 -> Associate to IGW)
In Private Subnet
 - Route table  ( 0.0.0.0/0 -> Associate to Nat Gateway)

Internet Gateway ->  VPC-wide	Public internet access (public subnets)
NAT Gateway -> Public Subnet Outbound internet for private subnets
Elastic IP for NAT Public NAT Gateway Required for NAT in Public Subnet
Elastic IP for EC2 -> Public EC2 instance
Route Table (Public) -> Attach to Public Subnet Route via IGW
Route Table (Private) -> Attach to Private Subnet Route via NAT Gateway
 */

# Summary:
# Public Subnet:  IGW  + Route Table + NAT GW  in Public Subnet & Route Table association to IGW -> 0.0.0.0/0 via IGW
# Private Subnet: Route Table & Route table association to NAT -> 0.0.0.0/0 via NAT Gateway
############################################################


# VPC
resource "aws_vpc" "project-vpc" {
  cidr_block = var.project-vpc.cidr
  tags = {
    name = var.project-vpc.name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-vpc.id
  tags = { Name = var.igw  }
}

# Public Route Table
resource "aws_route_table" "public" {
  depends_on = [ aws_internet_gateway.igw ]
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = var.route.cidr_route
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = var.route.name }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.project-vpc.id
  route {
    cidr_block = var.route.cidr_route
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "private[var.route.name]"}
}

# Associate Public Route Table with Public Subnet
resource "aws_route_table_association" "public_assoc" {
  depends_on = [ aws_subnet.public ]
  for_each = var.public_subnet
  subnet_id  = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}
# Associate Public Route Table with Private Subnet
resource "aws_route_table_association" "Private_assoc" {
  depends_on = [ aws_subnet.private ]
  for_each = var.private_subnet
  subnet_id  = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}

resource "aws_nat_gateway" "nat" {
  depends_on = [aws_internet_gateway.igw]
  subnet_id = aws_subnet.public["rb-public-subnet"].id
  allocation_id = aws_eip.nat_eip.id
}

# Public Subnet
resource "aws_subnet" "public" {
  for_each = var.public_subnet
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = true
  availability_zone       = each.value.av
  tags = { Name = each.value.name }
}

# Private Subnet
resource "aws_subnet" "private" {
  for_each = var.private_subnet
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.av
  tags = { Name = each.value.name }
}

############################################################
############################################################
##################### EC 2 #################################
############################################################

# Security Group (allow SSH & ICMP)
resource "aws_security_group" "allow_all_sg" {
  name        = "allow-all-sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all-sg"
  }
}


# AMI for Amazon Linux 2
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["973714476881"]  # AMI owner ID
  filter {
    name   = "image-id"
    values = ["ami-09c813fb71547fc4f"]
  }
}

resource "aws_eip" "public_ip" {
  for_each = var.public-ec2
  domain = "vpc"
}

# Public EC2 Instance
resource "aws_instance" "public-vm" {
  for_each = var.public-ec2
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = each.value.instance_type
  subnet_id                   = aws_subnet.public[each.value.subnet_id_key].id
  vpc_security_group_ids      = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true
  tags = { Name = each.value.name }
}

resource "aws_eip_association" "pip_allocate" {
  depends_on = [aws_instance.public-vm]
  for_each = var.public-ec2
  instance_id = aws_instance.public-vm[each.key].id
  allocation_id = aws_eip.public_ip[each.key].id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Private EC2 Instance
resource "aws_instance" "private_ec2" {
  for_each = var.private-ec2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = each.value.instance_type
  subnet_id              = aws_subnet.private[each.value.subnet_id_key].id #var.private_subnet[each.value.subnet_id_key].name (Both are correct)
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  tags = { Name = each.value.name }
}

#End of file