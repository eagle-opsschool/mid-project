provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = "${var.aws_region}"
}

resource "aws_vpc" "mid_project_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mid_project_subnet" {
  vpc_id            = "${aws_vpc.mid_project_vpc.id}"
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-2b"

  #map_public_ip_on_launch = true
  tags {
    Name = "mid_project_subnet"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.mid_project_vpc.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.mid_project_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_security_group" "mid_project_security_group" {
  vpc_id = "${aws_vpc.mid_project_vpc.id}"

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
}

resource "aws_instance" "dummy_exporter1" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.102"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "dummy_exporter1"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "dummy_exporter2" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.103"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "dummy_exporter2"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "prometheus" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.104"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "prometheus"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "grafana" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.105"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "grafana"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "kibana" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t3.medium"
  private_ip    = "10.0.0.106"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "kibana"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "consul1" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.107"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "consul1"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "consul2" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.108"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "consul2"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "consul3" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.109"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "consul3"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install python-minimal",
    ]
  }
}

resource "aws_instance" "ansible_master" {
  ami           = "ami-0f65671a86f061fcd"
  instance_type = "t2.micro"
  private_ip    = "10.0.0.101"
  key_name      = "${var.aws_key_name}"

  tags {
    Name = "ansible_master"
  }

  vpc_security_group_ids      = ["${aws_security_group.mid_project_security_group.id}"]
  subnet_id                   = "${aws_subnet.mid_project_subnet.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.aws_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo echo StrictHostKeyChecking no >> /etc/ssh/ssh_config",
      "sudo apt-get -y update",
      "sudo apt-get -y update",
      "sudo apt-get -y install ansible",
    ]
  }

  provisioner "file" {
    source      = "${var.aws_key_path}"
    destination = "/home/ubuntu/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 600 /home/ubuntu/.ssh/id_rsa",
      "git clone https://github.com/eagle-opsschool/mid-project.git",
      "cd mid-project/ansible",
      "ansible-playbook site.yml",
    ]
  }
}
