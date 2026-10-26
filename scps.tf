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