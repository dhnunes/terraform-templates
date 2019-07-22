variable "AWS_ACCESS_KEY" {
    description = "AWS access key"
}
variable "AWS_SECRET_KEY" {}
variable "PATH_TO_PUBLIC_KEY" {}
variable "PATH_TO_PRIVATE_KEY" {}

variable "AWS_REGION" {
    default = "us-east-1"
}

variable "INSTANCE_USERNAME"{}

variable "AMIS" {
    type = "map"
    default = {
        us-east-1 = "ami-0b898040803850657"
    }
  
}

