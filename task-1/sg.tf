locals {
  security_groups = {
    bastion = {
      name        = "bastion-service"
      description = "SSH access from anywhere"
      ingress_with_cidr_blocks = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          description = "Allow SSH"
          cidr_blocks = "0.0.0.0/0"
        }
      ]
      egress_rules = ["all-all"]
    }

    web = {
      name        = "private-service"
      description = "Web access"
      ingress_with_cidr_blocks = [
        {
          from_port   = 0
          to_port     = 65535
          protocol    = "tcp"
          description = "HTTP access"
          cidr_blocks = "10.0.0.0/16"
        }]

        egress_rules = ["all-all"]
        }
        }
}

module "security_groups" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1"

  for_each = local.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = each.value.ingress_with_cidr_blocks
  egress_rules             = each.value.egress_rules
}
