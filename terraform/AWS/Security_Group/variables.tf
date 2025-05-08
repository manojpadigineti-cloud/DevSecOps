variable "sg_rules" {
  type = map(object({
    cidr = list(string)
    port = number
    protocol = string
    sgname= string
    type = string
  }))
}


