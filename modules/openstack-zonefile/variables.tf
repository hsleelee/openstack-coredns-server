variable domain {
  description = "Name of the domain for the zonefile"
  type = string
}

variable ns_records {
  description = "List of ns records having the following keys: prefix, nameserver"
  type = list(object({
    prefix     = string
    nameserver = string
  }))
  default = []
}

variable a_records {
  description = "List of a records having the following keys: prefix, ip"
  type = list(object({
    prefix = string
    ip     = string
  }))
  default = []
}

variable mx_records {
  description = "List of mx records having the following keys: prefix, priority, address"
  type = list(object({
    prefix   = string
    priority = number
    address  = string
  }))
  default = []
}

variable txt_records {
  description = "List of txt records having the following keys: prefix, text"
  type = list(object({
    prefix   = string
    text  = string
  }))
  default = []
}

variable container {
  description = "Name of the container that will container the zonefile object"
  type = string
}

variable cache_ttl {
  description = "How long should replies be cached in seconds."
  type = number
  default = 5
}

variable email {
  description = "Contact email for the SOA record. Defaults to no-op.{domain}."
  type = string
  default = ""
}

variable dns_server_name {
  description = "Fully defined domain name of the dns server(s) for the SOA record. Defaults to dns.{domain}."
  type = string
  default = ""
}

variable dns_server_ips {
  description = "List of ips for the dns servers. If defined, a list of A records mapping the ips to the dns domain will be included in the zonefile."
  type = list(string)
  default = []
}