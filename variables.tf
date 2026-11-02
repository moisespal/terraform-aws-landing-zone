variable "organization_log_archive_account_email" {
  description = "Organization Log Archive account email"
  type        = string
  sensitive   = true
}

variable "organization_sandbox_account_id" {
  description = "Organization Sandbox account ID"
  type        = string
  sensitive   = true
}

variable "organization_network_account_email" {
  description = "Organization Network account email"
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

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}