variable region {
  type        = string   
  description = "provide region"
}

variable "subnet_cidr" {
  type = list(object({
    cidr        = string
    subnet_name = string
  }))
}

variable "vpc_dns" {
  type = list(object({
    vpc_cidr = string
    vpc_name = string
    dns_sup  = bool
    dns_host = bool
  }))
}

variable "instance" {
  type = list(object({
    ec2_type = string
    ec2_name = string
  }))
}

variable "ports" {
  type    = list(number)
  default = [22, 80, 3306, 443]
}

variable "database_details" {
    type = object({
    instance_class    = string # e.g., db.t3.micro
    allocated_storage = number # Storage in GB
    engine            = string # e.g., mysql, postgresql
    engine_version    = string # e.g., 5.7 for MySQL
    username          = string # Username for DB access
    password          = string # Password for DB access
    db_name           = string # Database name
  })
  description = "Configuration details for the RDS instance."
}

