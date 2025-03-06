resource "aws_security_group" "webserver_sg" {
  vpc_id = var.vpc_id

  name        = "${var.env_prefix}-webserver-sg"
  description = "Allow inbound traffic to webserver"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-webserver-sg"
  }
}


data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.env_prefix}-server-key"   # Example - include env_prefix to make it unique
  public_key = file(var.public_key_location)
}

resource "aws_instance" "myapp-server" {
  ami                    = data.aws_ami.latest-amazon-linux-image.id
  instance_type          = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")
  user_data_replace_on_change = true

  root_block_device {
    volume_type = "gp3"
    volume_size = 20 # Set size to whatever you need (default AMIs are usually 8 GiB, but you can bump this)
  }

  tags = {
    Name = "${var.env_prefix}-server"
  }
}

