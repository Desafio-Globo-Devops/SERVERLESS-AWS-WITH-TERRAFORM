variable "region" {
  description = "Region exemple: 'us-east-1'"
}
variable "account_id" {
  description = "Insert a Aws account ID exemple:'511322979481'"
}
variable "name" {
  type        = string
  default     = "Cloudtrail_Logs"
}
variable "enabled" {
  type        = bool
  default     = true
}

variable "enable_log_file_validation" {
  type        = bool
  default     = true
}

variable "is_multi_region_trail" {
  type        = bool
  default     = false
}

variable "include_global_service_events" {
  type        = bool
  default     = true
}

variable "enable_logging" {
  type        = bool
  default     = true
}

variable "cloud_watch_logs_role_arn" {
  type        = string
  default     = ""
}

variable "cloud_watch_logs_group_arn" {
  type        = string
  default     = ""
}

variable "event_selector" {
  type = list(object({
    include_management_events = bool
    read_write_type           = string

    data_resource = list(object({
      type   = string
      values = list(string)
    }))
  }))
  default     = []
}
variable "is_organization_trail" {
  type        = bool
  default     = false
  description = "The trail is an AWS Organizations trail"
}
variable "dbname" {
  default = "Event_Capture"
}

variable "read_capacity" {
  default = 5
}

variable "write_capacity" {
  default = 5
}

variable "bucket_name" {
  description = "Give a nome for your bucket exemplo: 'terraform-test-bucket-cloudtrail-logs'"
  default = "terraform-test-bucket-cloudtrail-logs"
}