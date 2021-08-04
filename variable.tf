variable "sg" {
  default = "cka"
}

variable "instance" {
  type = set(string)
  default = [
    "CKA1"
  ]
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "./cka_key.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "./cka_key"
}
