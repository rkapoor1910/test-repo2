provider "aws" {
  region = "us-east-1"
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 60
  statistic          = "Average"
  threshold          = 80
  alarm_description  = "This metric monitors high CPU utilization"
  alarm_actions      = [aws_sns_topic.datadog_alerts.arn]

  dimensions = {
    InstanceId = "i-0123456789abcdef0"
  }
}

resource "aws_sns_topic" "datadog_alerts" {
  name = "datadog-alerts"
}

resource "aws_sns_topic_subscription" "datadog_subscription" {
  topic_arn = aws_sns_topic.datadog_alerts.arn
  protocol  = "https"
  endpoint  = "https://api.datadoghq.com/api/v1/integration/aws/metric"
}
