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
  user_data       = "LISTEN_tcp=0.0.0.0:5432 LISTEN_tcp2=0.0.0.0:9000 LISTEN_tcp3=0.0.0.0:22 LISTEN_tcp4=0.0.0.0:28090 CHECK_segment1:${var.gpdb_segment1_ip}:1024 CHECK_segment1:${var.gpdb_segment1_ip}:10000 CHECK_segment1:${var.gpdb_segment1_ip}:20000 CHECK_segment2:${var.gpdb_segment2_ip}:1024 CHECK_segment2:${var.gpdb_segment2_ip}:10000 CHECK_segment2:${var.gpdb_segment2_ip}:20000 CHECK_segment3:${var.gpdb_segment3_ip}:1024 CHECK_segment3:${var.gpdb_segment3_ip}:10000 CHECK_segment3:${var.gpdb_segment3_ip}:20000 CHECK_segment4:${var.gpdb_segment4_ip}:1024 CHECK_segment4:${var.gpdb_segment4_ip}:10000 CHECK_segment4:${var.gpdb_segment4_ip}:20000 CHECK_segment5:${var.gpdb_segment5_ip}:1024 CHECK_segment5:${var.gpdb_segment5_ip}:10000 CHECK_segment5:${var.gpdb_segment5_ip}:20000"
  security_groups = ["${aws_security_group.master_sg.id}"]
  private_ip      = "${var.gpdb_master1_ip}"
}

module "gpdb_master2" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:5432 LISTEN_tcp2=0.0.0.0:9000 LISTEN_tcp3=0.0.0.0:22 LISTEN_tcp4=0.0.0.0:28090 CHECK_segment1:${var.gpdb_segment1_ip}:1024 CHECK_segment1:${var.gpdb_segment1_ip}:10000 CHECK_segment1:${var.gpdb_segment1_ip}:20000 CHECK_segment2:${var.gpdb_segment2_ip}:1024 CHECK_segment2:${var.gpdb_segment2_ip}:10000 CHECK_segment2:${var.gpdb_segment2_ip}:20000 CHECK_segment3:${var.gpdb_segment3_ip}:1024 CHECK_segment3:${var.gpdb_segment3_ip}:10000 CHECK_segment3:${var.gpdb_segment3_ip}:20000 CHECK_segment4:${var.gpdb_segment4_ip}:1024 CHECK_segment4:${var.gpdb_segment4_ip}:10000 CHECK_segment4:${var.gpdb_segment4_ip}:20000 CHECK_segment5:${var.gpdb_segment5_ip}:1024 CHECK_segment5:${var.gpdb_segment5_ip}:10000 CHECK_segment5:${var.gpdb_segment5_ip}:20000"
  security_groups = ["${aws_security_group.master_sg.id}"]
  private_ip      = "${var.gpdb_master2_ip}"
}

module "gpdb_segment1" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:1024 LISTEN_tcp2=0.0.0.0:10000 LISTEN_tcp3=0.0.0.0:20000 CHECK_master1=${var.gpdb_master1_ip}:5432 CHECK_master2=${var.gpdb_master2_ip}:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
  private_ip      = "${var.gpdb_segment1_ip}"
}

module "gpdb_segment2" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:1024 LISTEN_tcp2=0.0.0.0:10000 LISTEN_tcp3=0.0.0.0:20000 CHECK_master1=${var.gpdb_master1_ip}:5432 CHECK_master2=${var.gpdb_master2_ip}:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
  private_ip      = "${var.gpdb_segment2_ip}"
}

module "gpdb_segment3" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:1024 LISTEN_tcp2=0.0.0.0:10000 LISTEN_tcp3=0.0.0.0:20000 CHECK_master1=${var.gpdb_master1_ip}:5432 CHECK_master2=${var.gpdb_master2_ip}:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
  private_ip      = "${var.gpdb_segment3_ip}"
}

module "gpdb_segment4" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:1024 LISTEN_tcp2=0.0.0.0:10000 LISTEN_tcp3=0.0.0.0:20000 CHECK_master1=${var.gpdb_master1_ip}:5432 CHECK_master2=${var.gpdb_master2_ip}:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
  private_ip      = "${var.gpdb_segment4_ip}"
}

module "gpdb_segment5" {
  source          = "github.com/UKHomeOffice/connectivity-tester-tf"
  subnet_id       = "${aws_subnet.dq_database.id}"
  user_data       = "LISTEN_tcp=0.0.0.0:1024 LISTEN_tcp2=0.0.0.0:10000 LISTEN_tcp3=0.0.0.0:20000 CHECK_master1=${var.gpdb_master1_ip}:5432 CHECK_master2=${var.gpdb_master2_ip}:5432"
  security_groups = ["${aws_security_group.segment_sg.id}"]
  private_ip      = "${var.gpdb_segment5_ip}"
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
    from_port   = 1024
    to_port     = 1024
    protocol    = "tcp"
    cidr_blocks = ["${var.dq_database_cidr_block}"]
  }

  ingress {
    from_port   = 10000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["${var.dq_database_cidr_block}"]
  }

  ingress {
    from_port   = 20000
    to_port     = 20000
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
