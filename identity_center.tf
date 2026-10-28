data "aws_ssoadmin_instances" "organization_identity_center" {}

output "arn" {
  value = tolist(data.aws_ssoadmin_instances.organization_identity_center.arns)[0]
}

output "identity_store_id" {
  value = tolist(data.aws_ssoadmin_instances.organization_identity_center.identity_store_ids)[0]
}

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