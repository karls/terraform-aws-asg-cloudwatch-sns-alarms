variable "name" {
  type        = "string"
  description = "Name (unique identifier for app or service)"
}

variable "namespace" {
  type        = "string"
  description = "Namespace (e.g. `cp` or `cloudposse`)"
}

variable "stage" {
  type        = "string"
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
}

variable "attributes" {
  type        = "list"
  description = "List of attributes to add to label."
  default     = []
}

variable "asg_name" {
	description = "Name of the Auto-Scaling Group. Used as a dimension for metrics."
}

variable "threshold_cpu_single_high_use" {
	description = "Threshold above which a single node's usage will trigger an alarm."
	default = "80"
}

variable "threshold_cpu_single_high_minutes" {
	description = "How long a high cpu usage must be sustained for before it becomes a problem.  Dependent on workloads this will vary based on the kind of task and how long it takes for a new server to come up.  Default is tuned assuming a new server comes up within 5 minutes and you don't have any long-running intensive processes."
	default = "5"
}

variable "threshold_cpu_high_use" {
	description = "A high CPU usage average threshold across the whole auto-scaling group."
	default = "70"
}

variable "maxed_out_minutes" {
	description = "How many minutes of maxing out your Auto-scaling group would trigger an alarm."
	default = "45"
}

variable "max_instance_count" {
	description = "Max instance count of the auto-scaling group."
}

variable "min_instance_count" {
	description = "Min instance count of the auto-scaling group."
}

variable "alarm_actions" {
	type = "list"
}
