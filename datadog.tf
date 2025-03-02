resource "datadog_monitor" "high_cpu_alert" {
  name    = "High CPU Usage Alert"
  type    = "metric alert"
  query   = "avg(last_5m):avg:aws.ec2.cpuutilization{*} > 80"

  message = "ALERT: CPU Usage is above 80%! @slack-alerts"

  tags = ["environment:production", "team:devops"]

  notify_no_data = true

  thresholds {
    critical = 80
    warning  = 70
  }

  notification {
    email = ["devops@example.com"]
  }
}
