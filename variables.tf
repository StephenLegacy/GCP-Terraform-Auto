variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
  default     = "us-central1"
}

variable "zones" {
  description = "The GCP zones to use"
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b"]
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "The type of machine to use"
  type        = string
  default     = "e2-micro"
}

variable "image" {
  description = "The image to use for the VM instances"
  type        = string
  default     = "debian-cloud/debian-11"
}
