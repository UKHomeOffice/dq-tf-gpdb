output "dq_database_subnet_id" {
  value = "${aws_subnet.subnets.0.id}"
}

output "master_sg_id" {
  value = "${aws_security_group.master_sg.id}"
}

output "segment_sg_id" {
  value = "${aws_security_group.segment_sg.id}"
}

output "gpdb_master1_ip" {
  value = "${var.gpdb_master1_ip}"
}

output "gpdb_master2_ip" {
  value = "${var.gpdb_master2_ip}"
}

output "dq_database_cidr_block" {
  value = ["${aws_subnet.subnets.*.cidr_block}"]
}
