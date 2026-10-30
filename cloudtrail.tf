resource "aws_cloudtrail" "organization_trail" {
  depends_on = [aws_s3_bucket_policy.log_archive]

  name                          = "landing-zone-organization-trail"
  s3_bucket_name                = aws_s3_bucket.log_archive.id
  is_organization_trail         = true
  is_multi_region_trail         = true
  enable_logging                = true
  include_global_service_events = true
  enable_log_file_validation    = true

  lifecycle {
    prevent_destroy = true
  }
}