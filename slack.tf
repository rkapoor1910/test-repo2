resource "datadog_integration_slack_channel" "slack_alerts" {
  account_name  = "your-slack-account"
  channel_name  = "#alerts"
  display_name  = "Datadog Alerts"
  notify_users  = ["@devops"]
}
