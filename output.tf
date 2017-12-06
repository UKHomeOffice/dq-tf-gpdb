output "dq_database_subnet_id" {
  value = "${aws_subnet.dq_database.id}"
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

 output "gpdb_segment1_ip" {
   value = "${var.gpdb_segment1_ip}"
 }

 output "gpdb_segment2_ip" {
   value = "${var.gpdb_segment2_ip}"
 }

 output "gpdb_segment3_ip" {
   value = "${var.gpdb_segment3_ip}"
 }

 output "gpdb_segment4_ip" {
   value = "${var.gpdb_segment4_ip}"
 }

 output "gpdb_segment5_ip" {
   value = "${var.gpdb_segment5_ip}"
 }
