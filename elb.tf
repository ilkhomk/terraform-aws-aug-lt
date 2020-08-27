resource "aws_elb" "bar" {
  name = "foobar-terraform-elbs"
  security_groups = ["${aws_security_group.vpc_task.id}"]

  subnets = [
                       "subnet-0377e907734a2477c",
                       "subnet-0f21598c6dfc67be7",
                       "subnet-06a91b8b40614b60a"
]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "foobar-terraform-elbs"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.example.id}"
  elb                    = "${aws_elb.bar.id}"
}
