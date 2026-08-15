# 1. Private S3 Bucket
resource "aws_s3_bucket" "static_bucket" {
  bucket        = "${var.name}.${var.domain_name}"
  force_destroy = true
}

# 2. Block all direct public access
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.static_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3. Bucket Policy permitting ONLY CloudFront OAC to read objects
data "aws_iam_policy_document" "s3_policy_doc" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_bucket.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket     = aws_s3_bucket.static_bucket.id
  policy     = data.aws_iam_policy_document.s3_policy_doc.json
  depends_on = [aws_s3_bucket_public_access_block.block_public_access]
}