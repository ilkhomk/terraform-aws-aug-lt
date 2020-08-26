module "app1" {
  source           = "../"
  region           = "us-east-1"
  key_name         = "asg-key-pair"                    #It will be created
  image_owner      = "amazon"                    #137112412989
  desired_capacity = 1
  max_size         = 1
  min_size         = 1
}
