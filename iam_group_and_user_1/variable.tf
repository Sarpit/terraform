variable "groups" {
  type = set(string)
  default = [
    "dev",
    "prod"
  ]
}

variable "dev_user" {
  type = set(string)
  default = ["dev_user1","dev_user2","dev_user3"]
}

variable "prod_user" {
  type = set(string)
  default = ["prod_user1","prod_user2","prod_user3"]
}
