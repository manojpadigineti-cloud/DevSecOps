sg_rules = {
  ssh = {
    cidr = ["0.0.0.0/0"]
    protocol = "TCP"
    sgname = "robo-sg"
    type = "ingress"
    port = 22
  },
  http = {
    cidr = ["122.174.98.221/32"]
    protocol = "TCP"
    sgname = "robo-sg"
    type = "ingress"
    port = 80
  }
}