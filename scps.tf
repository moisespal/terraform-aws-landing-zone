data "aws_iam_policy_document" "deny_leave_and_close" {
  statement {
    sid    = "DenyLeaveOrganizationAndCloseAccount"
    effect = "Deny"
    actions = [
      "organizations:LeaveOrganization",
      "account:CloseAccount"
    ]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "DenyLeaveOrganizationAndCloseAccount" {
  name    = "DenyLeaveOrganizationAndCloseAccount"
  content = data.aws_iam_policy_document.deny_leave_and_close.json
}

resource "aws_organizations_policy_attachment" "root" {
  policy_id = aws_organizations_policy.DenyLeaveOrganizationAndCloseAccount.id
  target_id = aws_organizations_organization.org.roots[0].id
}

data "aws_iam_policy_document" "deny_stop_and_delete_cloudtrail" {
  statement {
    sid    = "DenyStopAndDeleteCloudTrail"
    effect = "Deny"
    actions = [
      "cloudtrail:StopLogging",
      "cloudtrail:DeleteTrail"
    ]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "deny_stop_and_delete_cloudtrail" {
  name    = "DenyStopAndDeleteCloudTrail"
  content = data.aws_iam_policy_document.deny_stop_and_delete_cloudtrail.json
}

resource "aws_organizations_policy_attachment" "cloudtrail_root" {
  policy_id = aws_organizations_policy.deny_stop_and_delete_cloudtrail.id
  target_id = aws_organizations_organization.org.roots[0].id
}

data "aws_iam_policy_document" "deny_all_outside_requested_regions" {
  statement {
    sid    = "DenyAllOutsideRequestedRegions"
    effect = "Deny"
    not_actions = [
      "budgets:*",
      "ce:*",
      "cloudfront:*",
      "iam:*",
      "organizations:*",
      "route53:*",
      "shield:*",
      "sts:*",
      "support:*",
    ]
    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"

      values = [
        "us-east-1"
      ]
    }
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "deny_all_outside_requested_regions" {
  name    = "DenyAllOutsideRequestedRegions"
  content = data.aws_iam_policy_document.deny_all_outside_requested_regions.json
}

resource "aws_organizations_policy_attachment" "deny_all_outside_requested_regions_workloads" {
  policy_id = aws_organizations_policy.deny_all_outside_requested_regions.id
  target_id = aws_organizations_organizational_unit.workloads.id
}