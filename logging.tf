resource "aws_s3_bucket" "log_archive" {
  provider         = aws.log_archive
  bucket           = "landing-zone-cloudtrail-logs-${aws_organizations_account.log_archive.id}-us-east-1-an"
  bucket_namespace = "account-regional"

  tags = {
    Name        = "Log Archive"
    Environment = "Security"
  }

  lifecycle {
    prevent_destroy = true
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

resource "aws_s3_bucket_versioning" "log_archive" {
  provider = aws.log_archive
  bucket   = aws_s3_bucket.log_archive.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "log_archive" {
  provider = aws.log_archive
  bucket   = aws_s3_bucket.log_archive.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 1
    }
  }
}