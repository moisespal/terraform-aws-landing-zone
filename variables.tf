variable "organization_log_archive_account_email" {
  description = "Organization Log Archive account email"
  type        = string
  sensitive   = true
}

variable "organization_log_archive_account_id" {
  description = "Organization Log Archive account ID"
  type        = string
  sensitive   = true
}

variable "organization_sandbox_account_id" {
  description = "Organization Sandbox account ID"
  type        = string
  sensitive   = true
}

variable "organization_account_id" {
  description = "Organization account ID"
  type        = string
  sensitive   = true
}

variable "iam_identity_admin_user_email" {
  description = "IAM identity admin user email"
  type        = string
  sensitive   = true
}

variable "iam_identity_admin_user_name" {
  description = "IAM identity admin user name"
  type        = string
}

variable "iam_identity_admin_user_given_name" {
  description = "IAM identity admin user given name"
  type        = string
}

variable "iam_identity_admin_user_family_name" {
  description = "IAM identity admin user family name"
  type        = string
}

variable "budget_notification_email" {
  description = "Email address for AWS budget alerts"
  type        = string
  sensitive   = true
}