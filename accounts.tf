resource "aws_organizations_account" "log_archive" {
  name      = "log_archive"
  email     = var.organization_log_archive_account_email
  parent_id = aws_organizations_organizational_unit.security.id
}
