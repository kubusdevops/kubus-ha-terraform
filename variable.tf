variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
  default     = "vpc-0f8ffa69427e755ff"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-00e801948462f718a"
}

variable  "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling group"
  type        = list(string)
  default     = ["subnet-04eff04788c28873e", "subnet-08a5324bee0d68c14", "subnet-09e89ecbfee521bc8"]
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  type        = string
  default     = "Z1KQ0X3Y2E4F5G"
}

variable "route53_record_name" {
  description = "The name of the Route 53 record"
  type        = string
  default     = "kubus-ha.com"
}