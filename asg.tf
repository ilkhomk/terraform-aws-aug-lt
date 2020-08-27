resource "aws_autoscaling_group" "example" {
  # availability_zones = [
  #   "${var.region}a",
  #   "${var.region}b",
  #   "${var.region}c",
  # ]

desired_capacity = "${var.desired_capacity}"
max_size = "${var.max_size}"
min_size = "${var.min_size}"

vpc_zone_identifier = [
                       "subnet-0377e907734a2477c",
                       "subnet-0f21598c6dfc67be7",
                       "subnet-06a91b8b40614b60a"
]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = "${aws_launch_template.example.id}"
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "t2.large"
        weighted_capacity = "2"
      }
    }
  }
}
