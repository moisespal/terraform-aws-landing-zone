provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "log_archive"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.log_archive.id}:role/OrganizationAccountAccessRole"
  }
}