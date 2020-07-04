variable "region" {
  default = "us-east-1"
}

variable "account_id" {
  default = "511322979481"
}

variable "env" {
  default = "dev"
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


variable "enabled" {
  type        = bool
  default     = true
}

variable "arn_format" {
  type        = string
  default     = "arn:aws"
}