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

variable "droplet_size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "droplet_names" {
  description = "List of droplets names"
  type        = list(string)
  default     = [
    "certificate-authority-server",
    "openvpn-server",
    "nextcloud-server"
  ]
}
