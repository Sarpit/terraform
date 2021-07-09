variable "groups" {
  type = set(string)
  default = [
    "java_dev",
    "python_dev",
    "C_dev"
  ]
}

variable "users" {
  type = set(string)
  default = [
    "user_java",
    "user_python",
    "user_C"
  ]
}
