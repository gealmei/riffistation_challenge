variable "aws_vpc_id" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_name" {}
variable "aws_region" {}
variable "aws_subnet_cidr_blocks" {}
variable "aws_availability_zone" {}
variable "aws_private_dns" {}
variable "aws_public_dns" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${var.aws_vpc_id}"
  availability_zone = "${var.aws_availability_zone}"
  cidr_block        = "${var.aws_subnet_cidr_blocks}"
  map_public_ip_on_launch = "true"
}

resource "aws_route53_zone" "private_dns" {
  name = "${var.aws_private_dns}"
  vpc_id = "${var.aws_vpc_id}"
  vpc_region = "${var.aws_region}"
}

resource "aws_route53_zone" "public_dns" {
  name = "${var.aws_public_dns}"
}

resource "aws_security_group" "private_access_control" {
  name        = "private_access_control"
  description = "Private subnet access control"

  ingress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.aws_subnet_cidr_blocks}"]
    protocol        = -1
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["${var.aws_subnet_cidr_blocks}"]
    protocol        = -1
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Control SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = -1
  }
}

resource "aws_security_group" "web_access" {
  name        = "web_access"
  description = "Control Web access"

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = -1
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
    protocol        = -1
  }
}

resource "aws_instance" "kibana" {
  ami             = "ami-6388010f"
  instance_type   = "t2.large"
  key_name        = "${var.aws_key_name}"
  subnet_id       = "${aws_subnet.private_subnet.id}"
  security_groups = ["${aws_security_group.private_access_control.id}","${aws_security_group.ssh_access.id}","${aws_security_group.web_access.id}"]
}

resource "aws_instance" "logstash" {
  ami             = "ami-6388010f"
  instance_type   = "t2.large"
  key_name        = "${var.aws_key_name}"
  subnet_id       = "${aws_subnet.private_subnet.id}"
  security_groups = ["${aws_security_group.private_access_control.id}","${aws_security_group.ssh_access.id}","${aws_security_group.web_access.id}"]
}

resource "aws_instance" "es1" {
  ami             = "ami-6388010f"
  instance_type   = "t2.large"
  key_name        = "${var.aws_key_name}"
  subnet_id       = "${aws_subnet.private_subnet.id}"
  security_groups = ["${aws_security_group.private_access_control.id}","${aws_security_group.ssh_access.id}","${aws_security_group.web_access.id}"]
}

resource "aws_instance" "es2" {
  ami             = "ami-6388010f"
  instance_type   = "t2.large"
  key_name        = "${var.aws_key_name}"
  subnet_id       = "${aws_subnet.private_subnet.id}"
  security_groups = ["${aws_security_group.private_access_control.id}","${aws_security_group.ssh_access.id}","${aws_security_group.web_access.id}"]
}

resource "aws_instance" "es3" {
  ami             = "ami-6388010f"
  instance_type   = "t2.large"
  key_name        = "${var.aws_key_name}"
  subnet_id       = "${aws_subnet.private_subnet.id}"
  security_groups = ["${aws_security_group.private_access_control.id}","${aws_security_group.ssh_access.id}","${aws_security_group.web_access.id}"]
}

resource "aws_route53_record" "kibana" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "kibana"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.kibana.private_ip}"]
}

resource "aws_route53_record" "kibana_pub" {
  zone_id = "${aws_route53_zone.public_dns.zone_id}"
  name    = "kibana_pub"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.kibana.public_ip}"]
}

resource "aws_route53_record" "logstash" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "logstash"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.logstash.private_ip}"]
}

resource "aws_route53_record" "logstash_pub" {
  zone_id = "${aws_route53_zone.public_dns.zone_id}"
  name    = "logstash_pub"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.logstash.public_ip}"]
}

resource "aws_route53_record" "es1" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "es1"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es1.private_ip}"]
}

resource "aws_route53_record" "es1_pub" {
  zone_id = "${aws_route53_zone.public_dns.zone_id}"
  name    = "es1_pub"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es1.public_ip}"]
}

resource "aws_route53_record" "es2" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "es2"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es2.private_ip}"]
}

resource "aws_route53_record" "es2_pub" {
  zone_id = "${aws_route53_zone.public_dns.zone_id}"
  name    = "es2_pub"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es2.public_ip}"]
}

resource "aws_route53_record" "es3" {
  zone_id = "${aws_route53_zone.private_dns.zone_id}"
  name    = "es3"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es3.private_ip}"]
}

resource "aws_route53_record" "es3_pub" {
  zone_id = "${aws_route53_zone.public_dns.zone_id}"
  name    = "es3_pub"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.es3.public_ip}"]
}
