data "aws_caller_identity" "current-account" {}
data "aws_region" "current" {}

locals {
  current_account_id   = data.aws_caller_identity.current-account.account_id
  current_region       = data.aws_region.current.name
  canonical_account_id = "099720109477"
}

data "aws_ami" "this" {
  most_recent = true
  owners      = [local.canonical_account_id]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "this" {
  instance_type        = var.instance_type
  ami                  = data.aws_ami.this.image_id
  iam_instance_profile = aws_iam_instance_profile.this.name
  key_name             = var.key_name
  security_groups      = [aws_security_group.this.name]
  tags                 = var.tags
}

resource "aws_iam_instance_profile" "this" {
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.instance_assume.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_security_group" "this" {
  description = "Allow all outbound traffic from instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
