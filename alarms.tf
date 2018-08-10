resource "aws_cloudwatch_metric_alarm" "asg_cpu_single_high" {
  alarm_name          = "asg_cpu_single_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.threshold_cpu_single_high_minutes}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"

  dimensions {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  statistic         = "Maximum"
  period            = "60"
  threshold         = "${var.threshold_cpu_single_high_use}"
  alarm_description = "Max CPU Utilization has sustained above ${var.threshold_cpu_single_high_use}% for ${var.threshold_cpu_single_high_minutes}m"

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "asg_cpu_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"

  dimensions {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  statistic         = "Average"
  period            = "60"
  threshold         = "${var.threshold_cpu_high_use}"
  alarm_description = "Average CPU Utilization was above ${var.threshold_cpu_high_use}% for a 60s period"

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "asg_maxed_out" {
  alarm_name          = "asg_maxed_out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.maxed_out_minutes}"
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"

  dimensions {
    "AutoScalingGroupName" = "${var.asg_name}"
  }

  statistic         = "Maximum"
  period            = "60"
  threshold         = "${var.max_instance_count}"
  alarm_description = "Total in service instances has sustained above ${var.max_instance_count} for ${var.maxed_out_minutes}m. Consider increasing the maximum autoscaling group max instance count."

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}
