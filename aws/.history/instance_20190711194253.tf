resource "aws_key_pair" "mykey" {
    key_name = "mykey"
    public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}


resource "aws_instance" "example-dnunes" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "subnet-5622711d"
    key_name = "${aws_key_pair.mykey.key_name}"

    provisioner "file" {
        source = "test.txt"
        destination = "/tmp/test.txt"
    }
    provisioner "remote-exec"
}

