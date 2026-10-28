resource "aws_s3_bucket" "log_archive" {
  provider         = aws.log_archive
  bucket           = "landing-zone-cloudtrail-logs-${var.organization_log_archive_account_id}-us-east-1-an"
  bucket_namespace = "account-regional"

  tags = {
    Name        = "Log Archive"
    Environment = "Security"
  }
}

resource "aws_s3_bucket_public_access_block" "log_archive" {
  provider = aws.log_archive
  bucket   = aws_s3_bucket.log_archive.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}