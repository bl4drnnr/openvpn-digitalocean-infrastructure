variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  default     = ""
}

variable "region" {
  description = "Droplets region"
  type        = string
  default     = "fra1"
}

variable "droplet_count" {
  description = "Droplets count"
  type        = number
  default     = 1
}

variable "droplet_size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}