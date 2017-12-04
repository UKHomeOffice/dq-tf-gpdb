output "dq_database_subnet_id" {
  value = "${aws_subnet.dq_database.id}"
}

output "master_sg_id" {
  value = "${aws_security_group.master_sg.id}"
}

output "segment_sg_id" {
  value = "${aws_security_group.segment_sg.id}"
}
