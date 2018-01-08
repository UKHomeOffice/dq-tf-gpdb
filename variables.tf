variable "appsvpc_id" {}
variable "internal_dashboard_cidr_block" {}
variable "external_dashboard_cidr_block" {}
variable "data_ingest_cidr_block" {}
variable "data_pipe_apps_cidr_block" {}
variable "data_feeds_cidr_block" {}
variable "opssubnet_cidr_block" {}
variable "peering_cidr_block" {}
variable "az" {}
variable "dq_database_cidr_block" {}

variable "naming_suffix" {
  default     = false
  description = "Naming suffix for tags, value passed from dq-tf-apps"
}

variable "route_table_id" {
  default     = false
  description = "Value obtained from Apps module"
}

variable "gpdb_master1_ip" {
  default     = "10.1.2.11"
  description = "Mock private IP for Master host."
}

variable "gpdb_master2_ip" {
  default     = "10.1.2.12"
  description = "Mock private IP for Master host."
}

variable "gpdb_segment1_ip" {
  default     = "10.1.2.21"
  description = "Mock private IP for segment hosts."
}

variable "gpdb_segment2_ip" {
  default     = "10.1.2.22"
  description = "Mock private IP for segment hosts."
}

variable "gpdb_segment3_ip" {
  default     = "10.1.2.23"
  description = "Mock private IP for segment hosts."
}

variable "gpdb_segment4_ip" {
  default     = "10.1.2.24"
  description = "Mock private IP for segment hosts."
}

variable "gpdb_segment5_ip" {
  default     = "10.1.2.25"
  description = "Mock private IP for segment hosts."
}
