resource "aws_iam_role" "iam_role" {
  name_prefix = "gp_instance_store_encryption"
  count       = "${local.instance_count}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com",
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name_prefix = "gp_instance_store_encryption"
  role        = "${element(aws_iam_role.iam_role.*.name, count.index)}"
  count       = "${local.instance_count}"
}

resource "aws_iam_role_policy" "iam_role_policy" {
  name_prefix = "gp_instance_store_encryption"
  role        = "${element(aws_iam_role.iam_role.*.id, count.index)}"
  count       = "${local.instance_count}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:eu-west-2:*:parameter/instance_store_${count.index}"
        },
        {
            "Effect": "Allow",
            "Action": ["s3:ListBucket"],
            "Resource": "${var.archive_bucket}"
          },
          {
            "Effect": "Allow",
            "Action": [
              "s3:PutObject"
            ],
            "Resource": "${var.archive_bucket}/*"
          },
          {
            "Effect": "Allow",
            "Action": [
              "kms:Encrypt",
              "kms:Decrypt",
              "kms:ReEncrypt*",
              "kms:GenerateDataKey*",
              "kms:DescribeKey"
              ],
              "Resource": "${var.apps_buckets_kms_key}"
          }
    ]
}
EOF
}
