resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

data "aws_ami" "ubuntu" {
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter{
      name = "architecture"
      values = ["x86_64"]
  }

  # sort_ascending = true
  most_recent = true
}

resource "aws_instance" "example-dnunes" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "subnet-0572f59b1ab1a9b62"
    associate_public_ip_address = true
    vpc_security_group_ids = ["sg-0fe4c53015479d9e8"]
    key_name = "${aws_key_pair.mykey.key_name}"

    provisioner "file"{
        source = "test.txt"
        destination = "/tmp/test.txt"
    }
    provisioner "remote-exec" {
        inline = [
            "cat /tmp/test.txt",
            "cat /tmp/test.txt"
        ]
    }

    provisioner "local-exec" {
        command = "echo 'Your instances public ip:' ${aws_instance.example-dnunes.public_ip}"
    }

    connection {
        host = coalesce(self.public_ip, self.private_ip)
        user = "${var.INSTANCE_USERNAME}"
        private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
        
    }
}

output "public-ip" {
    value = "${aws_instance.example-dnunes.public_ip}"
}
