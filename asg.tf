resource "aws_autoscaling_group" "example" {
  availability_zones = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]

desired_capacity = "${var.desired_capacity}"
max_size = "${var.max_size}"
min_size = "${var.min_size}"

vpc_zone_identifier = [
                       "subnet-0e20140e07ba81a69",
                       "subnet-0a5577b98401d9da9",
                       "subnet-09c3e5783222cbd2f"
]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.example.id}"
      }

      override {
        instance_type     = "c4.large"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "c3.large"
        weighted_capacity = "2"
      }
    }
  }
}
