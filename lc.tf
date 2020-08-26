data "template_file" "init" {
  template = "${file("${path.module}/wordpress.sh")}"
}


resource "aws_launch_template" "example" {
  name_prefix            = "example"
  image_id               = "${data.aws_ami.image.id}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.asg-key-pair.key_name}"
  vpc_security_group_ids = ["sg-0a69d446622f9fe0b"]
  user_data = "${base64encode(data.template_file.init.rendered)}"

}
