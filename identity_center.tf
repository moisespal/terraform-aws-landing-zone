data "aws_ssoadmin_instances" "organization_identity_center" {}

resource "aws_identitystore_user" "admin_user" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.organization_identity_center.identity_store_ids)[0]

  display_name = "${var.iam_identity_admin_user_given_name} ${var.iam_identity_admin_user_family_name}"
  user_name    = var.iam_identity_admin_user_name

  name {
    given_name  = var.iam_identity_admin_user_given_name
    family_name = var.iam_identity_admin_user_family_name
  }

  emails {
    value = var.iam_identity_admin_user_email
  }
}

resource "aws_identitystore_group" "admin_group" {
  display_name      = "LandingZoneAdministrators"
  description       = "Administrators group"
  identity_store_id = tolist(data.aws_ssoadmin_instances.organization_identity_center.identity_store_ids)[0]
}

resource "aws_identitystore_group_membership" "admin_group_membership" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.organization_identity_center.identity_store_ids)[0]
  group_id          = aws_identitystore_group.admin_group.group_id
  member_id         = aws_identitystore_user.admin_user.user_id
}

resource "aws_ssoadmin_permission_set" "admin_permission_set" {
  name         = "LandingZoneAdminAccess"
  description  = "Administrators permission set"
  instance_arn = tolist(data.aws_ssoadmin_instances.organization_identity_center.arns)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "admin_permission_set_attachment" {
  depends_on = [aws_ssoadmin_account_assignment.admin_account_assignment]

  instance_arn       = tolist(data.aws_ssoadmin_instances.organization_identity_center.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn
}

resource "aws_ssoadmin_account_assignment" "admin_account_assignment" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.organization_identity_center.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn

  principal_id   = aws_identitystore_group.admin_group.group_id
  principal_type = "GROUP"

  target_id   = var.organization_sandbox_account_id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "network_account_assignment" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.organization_identity_center.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.admin_permission_set.arn

  principal_id   = aws_identitystore_group.admin_group.group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.network.id
  target_type = "AWS_ACCOUNT"
}