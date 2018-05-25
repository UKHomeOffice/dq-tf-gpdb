data "aws_ami" "segment_2" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "gp-segment-host-2*",
    ]
  }

  owners = [
    "self",
  ]
}

resource "aws_instance" "segment_2" {
  ami                  = "${data.aws_ami.segment_2.id}"
  instance_type        = "d2.2xlarge"
  key_name             = "${var.key_name}"
  placement_group      = "${aws_placement_group.greenplum.id}"
  iam_instance_profile = "${element(aws_iam_instance_profile.instance_profile.*.id, 3)}"
  user_data            = "instance_store_3"
  monitoring           = true

  tags {
    Name = "segment-2-${var.naming_suffix}"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral0"
    device_name  = "/dev/sdb"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral1"
    device_name  = "/dev/sdc"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral2"
    device_name  = "/dev/sdd"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral3"
    device_name  = "/dev/sde"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral4"
    device_name  = "/dev/sdf"
  }

  ephemeral_block_device {
    virtual_name = "ephemeral5"
    device_name  = "/dev/sdg"
  }

  network_interface {
    device_index         = 0
    network_interface_id = "${aws_network_interface.segment_2_0.id}"
  }

  network_interface {
    device_index         = 1
    network_interface_id = "${aws_network_interface.segment_2_1.id}"
  }

  network_interface {
    device_index         = 2
    network_interface_id = "${aws_network_interface.segment_2_2.id}"
  }

  network_interface {
    device_index         = 3
    network_interface_id = "${aws_network_interface.segment_2_3.id}"
  }

  lifecycle {
    prevent_destroy = true

    ignore_changes = [
      "key_name"
    ]
  }
}

resource "aws_network_interface" "segment_2_0" {
  subnet_id = "${aws_subnet.subnets.0.id}"

  private_ips = [
    "10.1.25.9",
  ]

  security_groups = [
    "${aws_security_group.segment_sg.id}",
  ]

  depends_on = [
    "aws_subnet.subnets",
  ]
}

resource "aws_network_interface" "segment_2_1" {
  subnet_id = "${aws_subnet.subnets.1.id}"

  private_ips = [
    "10.1.26.159",
  ]

  security_groups = [
    "${aws_security_group.segment_sg.id}",
  ]

  depends_on = [
    "aws_subnet.subnets",
  ]
}

resource "aws_network_interface" "segment_2_2" {
  subnet_id = "${aws_subnet.subnets.2.id}"

  private_ips = [
    "10.1.27.164",
  ]

  security_groups = [
    "${aws_security_group.segment_sg.id}",
  ]

  depends_on = [
    "aws_subnet.subnets",
  ]
}

resource "aws_network_interface" "segment_2_3" {
  subnet_id = "${aws_subnet.subnets.3.id}"

  private_ips = [
    "10.1.28.14",
  ]

  security_groups = [
    "${aws_security_group.segment_sg.id}",
  ]

  depends_on = [
    "aws_subnet.subnets",
  ]
}
