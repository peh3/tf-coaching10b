output "website_url" {
  value       = "https://${var.name}.${var.domain_name}"
  description = "Secure HTTPS domain for the CloudFront distribution"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Direct CloudFront domain name"
}