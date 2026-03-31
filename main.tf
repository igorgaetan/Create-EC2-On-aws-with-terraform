resource "aws_vpc" "k3s_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "k3s-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.k3s_vpc.id
}

resource "aws_subnet" "public_sub" {
  vpc_id                  = aws_vpc.k3s_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}


resource "aws_security_group" "k3s_sg" {
  vpc_id = aws_vpc.k3s_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_key_pair" "deployer" {
  key_name   = "k3s-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "k3s_node" {
  ami           = "ami-00c71bd4d220aa22a" # Ubuntu 22.04 LTS (Region: eu-west-3)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_sub.id
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  key_name      = aws_key_pair.deployer.key_name

  user_data = file("userdata.sh")

  tags = { Name = "k3s-server" }
}


output "instance_ip" {
  value = aws_instance.k3s_node.public_ip
}