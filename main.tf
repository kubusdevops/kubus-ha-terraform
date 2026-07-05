resource "aws_launch_template" "kubus_ha_lunchtemplate" {
  name_prefix   = "kubus-ha-"
  image_id      = var.ami
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.kubus_ha_sg.id]
  }

#   user_data = base64encode(data.template_file.kubus_ha_user_data.rendered)


}


resource "aws_autoscaling_group" "kubus_autoscaling_group" {
  desired_capacity    = 3
  max_size            = 6
  min_size            = 3
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.kubus_ha_lunchtemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "kubus-ha-instance"
    propagate_at_launch = true
  }

}