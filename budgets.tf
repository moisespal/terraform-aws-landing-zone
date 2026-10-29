resource "aws_budgets_budget" "landing_zone_monthly_budget" {
  name         = "landing-zone-monthly-budget"
  time_unit    = "MONTHLY"
  budget_type  = "COST"
  limit_amount = "10"
  limit_unit   = "USD"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_notification_email]
  }
}