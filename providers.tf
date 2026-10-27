provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "log_archive"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.organization_log_archive_account_id}:role/OrganizationAccountAccessRole"
  }
}