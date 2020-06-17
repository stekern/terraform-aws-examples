variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "instance_type" {
  description = "The instance type to use."
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use."
  type        = string
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = map(string)
  default     = {}
}
