# pylint: disable=missing-docstring, line-too-long, protected-access, E1101, C0202, E0602, W0109
import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.snippet = """

            provider "aws" {
              region = "eu-west-2"
              skip_credentials_validation = true
              skip_get_ec2_platforms = true
            }

            module "gpdb" {
              source = "./mymodule"

              providers = {
                aws = "aws"
              }

                appsvpc_id                    = "12345"
                dq_database_cidr_block        = "10.1.2.0/24"
                internal_dashboard_cidr_block = "10.1.12.0/24"
                external_dashboard_cidr_block = "10.1.14.0/24"
                data_ingest_cidr_block        = "10.1.6.0/24"
                data_pipe_apps_cidr_block     = "10.1.8.0/24"
                data_feeds_cidr_block         = "10.1.4.0/24"
                opssubnet_cidr_block          = "10.2.0.0/24"
                peering_cidr_block            = "1.1.1.0/24"
                gpdb_master1_ip               = "10.1.2.11"
                gpdb_master2_ip               = "10.1.2.12"
                gpdb_segment1_ip              = "10.1.2.21"
                gpdb_segment2_ip              = "10.1.2.22"
                gpdb_segment3_ip              = "10.1.2.23"
                gpdb_segment4_ip              = "10.1.2.24"
                gpdb_segment5_ip              = "10.1.2.25"
                az                            = "eu-west-2a"
                naming_suffix                = "apps-preprod-dq"
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)

    def test_az_dq_database(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.dq_database"]["availability_zone"], "eu-west-2a")

    def test_name_suffix_dq_database(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.dq_database"]["tags.Name"], "subnet-gpdb-apps-preprod-dq")

    def test_name_suffix_master_sg(self):
        self.assertEqual(self.result['gpdb']["aws_security_group.master_sg"]["tags.Name"], "sg-master-gpdb-apps-preprod-dq")

    def test_name_prefix_segment_sg(self):
        self.assertEqual(self.result['gpdb']["aws_security_group.segment_sg"]["tags.Name"], "sg-segment-gpdb-apps-preprod-dq")

if __name__ == '__main__':
    unittest.main()
