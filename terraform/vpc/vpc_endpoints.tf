locals {
  enabled_regional_endpoints = [
    # Amazon EC2
    "ec2",
    # Amazon Elastic Container Registry (for pulling container images)
    "ecr.api",
    "ecr.dkr",
    "s3",
    # Amazon Application Load Balancers and Network Load Balancers
    "elasticloadbalancing",
    # (Optional) AWS X-Ray (required for tracing sent to AWS X-Ray)
    "xray",
    # (Optional) Amazon SSM (required for the SSM Agent for node management tasks. Alternative to SSH)
    "ssm",
    # Amazon CloudWatch Logs (required for node and pod logs sent to Amazon CloudWatch Logs)
    "logs",
    # AWS Security Token Service (required when using IAM roles for service accounts)
    "sts",
    # Amazon EKS Auth (required when using Pod Identity associations)
    "eks-auth",
    # Amazon EKS
    "eks",
  ]
}

resource "aws_vpc_endpoint" "regional_interface_endpoint" {
  for_each            = toset(local.enabled_regional_endpoints)
  vpc_id              = aws_vpc.vpc.id
  subnet_ids          = values(aws_subnet.private)[*].id
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  service_name        = "com.amazonaws.${var.region}.${each.key}"
  security_group_ids  = [aws_security_group.vpce_sg.id]
}

resource "aws_security_group" "vpce_sg" {
  name   = "vpce_sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "vpce_sg"
    VPC  = var.vpc_name
  }
}

resource "aws_security_group_rule" "vpce_sg_ingress" {
  security_group_id = aws_security_group.vpce_sg.id
  description       = "Allow HTTPS from private subnets"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = values(aws_subnet.private)[*].cidr_block
}
