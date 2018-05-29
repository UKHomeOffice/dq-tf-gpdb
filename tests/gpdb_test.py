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
                naming_suffix                 = "apps-preprod-dq"
                archive_bucket                = "bucketname"
                apps_buckets_kms_key          = "arn:aws:kms:::1234567890"
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)

    def test_az_dq_subnet_0(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.subnets.0"]["availability_zone"], "eu-west-2a")

    def test_az_dq_subnet_1(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.subnets.1"]["availability_zone"], "eu-west-2a")

    def test_az_dq_subnet_2(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.subnets.2"]["availability_zone"], "eu-west-2a")

    def test_az_dq_subnet_3(self):
        self.assertEqual(self.result['gpdb']["aws_subnet.subnets.3"]["availability_zone"], "eu-west-2a")

    # def test_master_1(self): @TODO: fix
    # self.assertTrue(Runner.finder(self.result['gpdb']["aws_network_interface.master_1_0"], 'private_ips', "10.1.25.101"))
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_1_0"]["private_ips.#"], "10.1.25.101")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_1_1"]["private_ips.#"], "10.1.26.101")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_1_2"]["private_ips.#"], "10.1.27.105")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_1_3"]["private_ips.#"], "10.1.28.229")
    #
    # def test_master_2(self):
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_2_0"]["private_ips.#"], "10.1.25.4")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_2_1"]["private_ips.#"], "10.1.26.234")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_2_2"]["private_ips.#"], "10.1.27.183")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.master_2_3"]["private_ips.#"], "10.1.28.86")
    #
    # def test_segment_1(self):
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_1_0"]["private_ips.#"], "10.1.25.224")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_1_1"]["private_ips.#"], "10.1.26.66")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_1_2"]["private_ips.#"], "10.1.27.150")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_1_3"]["private_ips.#"], "10.1.28.179")
    #
    # def test_segment_2(self):
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_2_0"]["private_ips.#"], "10.1.25.9")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_2_1"]["private_ips.#"], "10.1.26.159")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_2_2"]["private_ips.#"], "10.1.27.164")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_2_3"]["private_ips.#"], "10.1.28.14")
    #
    # def test_segment_3(self):
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_3_0"]["private_ips.#"], "10.1.25.143")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_3_1"]["private_ips.#"], "10.1.26.168")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_3_2"]["private_ips.#"], "10.1.27.221")
    #     self.assertEqual(self.result['gpdb']["aws_network_interface.segment_3_3"]["private_ips.#"], "10.1.28.246")

    def test_name_suffix_master_sg(self):
        self.assertEqual(self.result['gpdb']["aws_security_group.master_sg"]["tags.Name"],
                         "sg-master-gpdb-apps-preprod-dq")

    def test_name_prefix_segment_sg(self):
        self.assertEqual(self.result['gpdb']["aws_security_group.segment_sg"]["tags.Name"],
                         "sg-segment-gpdb-apps-preprod-dq")


if __name__ == '__main__':
    unittest.main()
