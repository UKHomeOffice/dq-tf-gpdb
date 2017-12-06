locals {
  name_prefix = "${var.name_prefix}apps-gpdb-"
}

resource "aws_subnet" "dq_database" {
  vpc_id                  = "${var.appsvpc_id}"
  cidr_block              = "${var.dq_database_cidr_block}"
  map_public_ip_on_launch = false
  availability_zone       = "${var.az}"

  tags {
    Name = "${local.name_prefix}subnet"
  }
}

module "gpdb_master1" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.master_sg.id}"]
}

module "gpdb_master2" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.master_sg.id}"]
}

module "gpdb_segment1" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
}

module "gpdb_segment2" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
}

module "gpdb_segment3" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
}

module "gpdb_segment4" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
}

module "gpdb_segment5" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "CHECK_self=127.0.0.1:8080 CHECK_google=google.com:80 CHECK_googletls=google.com:443 LISTEN_tcp=0.0.0.0:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
}

resource "aws_security_group" "master_sg" {
  vpc_id = "${var.appsvpc_id}"

  tags {
    Name = "${local.name_prefix}master-sg"
  }

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    cidr_blocks = [
      "${var.internal_dashboard_cidr_block}",
      "${var.external_dashboard_cidr_block}",
      "${var.data_ingest_cidr_block}",
      "${var.data_pipe_apps_cidr_block}",
      "${var.data_feeds_cidr_block}",
      "${var.opssubnet_cidr_block}",
    ]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["${var.opssubnet_cidr_block}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.opssubnet_cidr_block}"]
  }

  ingress {
    from_port   = 28090
    to_port     = 28090
    protocol    = "tcp"
    cidr_blocks = ["${var.opssubnet_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "segment_sg" {
  vpc_id = "${var.appsvpc_id}"

  tags {
    Name = "${local.name_prefix}segment-sg"
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${var.dq_database_cidr_block}"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["${var.dq_database_cidr_block}"]
  }

  ingress {
    from_port   = 8
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.dq_database_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
