variable "base_name" {
  type        = string
  description = "Name of the base image"
}

variable "base_pool_name" {
  type        = string
  description = "Name of the pool where base image is exist"
}

variable "base_image_path" {
  type        = string
  description = "Path to base image in 'base_pool_name'"
}

variable "worker_count" {
  type        = number
  description = "Count of worker volumes"
}

variable "worker_name" {
  type        = string
  description = "Name of worker volume"
}

variable "worker_pool_name" {
  type        = string
  description = "Name of pool for worker images"
}