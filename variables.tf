variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  default     = ""
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

