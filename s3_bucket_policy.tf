resource "aws_s3_bucket_policy" "log_archive" {
  provider = aws.log_archive
  bucket   = aws_s3_bucket.log_archive.id
  policy   = data.aws_iam_policy_document.log_archive.json
}

data "aws_iam_policy_document" "log_archive" {
  statement {
    sid     = "AllowCloudTrailGetBucketAcl"
    effect  = "Allow"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [aws_s3_bucket.log_archive.arn]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:us-east-1:${var.organization_account_id}:trail/landing-zone-organization-trail"]
    }
  }

  statement {
    sid     = "AllowCloudTrailPutObjectForManagementAccount"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["${aws_s3_bucket.log_archive.arn}/AWSLogs/${var.organization_account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:us-east-1:${var.organization_account_id}:trail/landing-zone-organization-trail"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid     = "AllowCloudTrailPutObjectForOrganization"
    effect  = "Allow"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["${aws_s3_bucket.log_archive.arn}/AWSLogs/${aws_organizations_organization.org.id}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:cloudtrail:us-east-1:${var.organization_account_id}:trail/landing-zone-organization-trail"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}