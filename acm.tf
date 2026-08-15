module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 6.3"

  /*providers = {
    aws = aws.us_east_1
  }*/

  domain_name = "${var.name}.${var.domain_name}"
  zone_id     = data.aws_route53_zone.sctp_zone.zone_id

  #subject_alternative_names = ["*.${var.domain_name}"]

  validation_method   = "DNS"
  wait_for_validation = true

  tags = {
    Name = "${var.name}.${var.domain_name}"
  }
}