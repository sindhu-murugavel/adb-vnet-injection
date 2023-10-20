variable "no_public_ip" {
  type    = bool
  default = true
}

variable "location" {
  type = string
  //default = "southeastasia"
  default = "Canada Central"
}

variable "dbfs_prefix" {
  type    = string
  default = "dbfs"
}

variable "node_type" {
  type    = string
  default = "Standard_DS3_v2"
}

variable "workspace_prefix" {
  type    = string
  default = "wegmans"
}

variable "global_auto_termination_minute" {
  type    = number
  default = 30
}

variable "cidr" {
  type = string
  //default = "10.179.0.0/20"
  default = "10.179.0.0/16"
}

