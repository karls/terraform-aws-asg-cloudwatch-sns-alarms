module "asg_cpu_single_high" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("cpu", "single", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_single_high" {
  alarm_name          = "${module.asg_cpu_single_high.id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.threshold_cpu_single_high_minutes}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"

  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }

  statistic         = "Maximum"
  period            = "60"
  threshold         = "${var.threshold_cpu_single_high_use}"
  alarm_description = "Max CPU Utilization has sustained above ${var.threshold_cpu_single_high_use}% for ${var.threshold_cpu_single_high_minutes}m"

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}

module "asg_cpu_high" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("cpu", "average", "high")))}"
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "${module.asg_cpu_high.id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"

  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }

  statistic         = "Average"
  period            = "60"
  threshold         = "${var.threshold_cpu_high_use}"
  alarm_description = "Average CPU Utilization was above ${var.threshold_cpu_high_use}% for a 60s period"

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}

module "asg_maxed_out" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  attributes = "${compact(concat(var.attributes, list("asg", "maxed", "out")))}"
}

resource "aws_cloudwatch_metric_alarm" "asg_maxed_out" {
  count = "${var.max_instance_count <= var.min_instance_count ? 0 : 1}"
  alarm_name          = "${module.asg_maxed_out.id}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "${var.maxed_out_minutes}"
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"

  dimensions = {
    AutoScalingGroupName = "${var.asg_name}"
  }

  statistic         = "Maximum"
  period            = "60"
  threshold         = "${var.max_instance_count}"
  alarm_description = "Total in service instances has sustained above ${var.max_instance_count} for ${var.maxed_out_minutes}m. Consider increasing the maximum autoscaling group max instance count."

  alarm_actions     = ["${var.alarm_actions}"]
  ok_actions     = ["${var.alarm_actions}"]
}
