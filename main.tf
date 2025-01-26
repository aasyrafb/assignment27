provider "aws" {
  region = "ap-southeast-1" 
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1b" 
}

resource "aws_instance" "main" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  key_name      = "aasyraf-keypair" 

  tags = {
    Name = "TerraformEC2Instance"
  }
}

resource "aws_ebs_volume" "main" {
  availability_zone = "ap-southeast-1b"
  size              = 1 

  tags = {
    Name = "asyraf-ebs-volume"
  }
}

resource "aws_volume_attachment" "main" {
  device_name = "/dev/sdv"
  volume_id   = aws_ebs_volume.main.id
  instance_id = aws_instance.main.id
}
