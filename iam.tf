resource "aws_iam_role" "kubus_ha_iam" {
    name = "kubus-ha-iam-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
            Service = "ec2.amazonaws.com"
            }
        },
        ]
    })
  
}

resource "aws_iam_role_policy" "kubus_policy" {
    name = "kubus-ha-iam-policy"
    role = aws_iam_role.kubus_ha_iam.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = [
            "ec2:Describe*",
            "s3:GetObject",
            "s3:ListBucket"
            ]
            Effect   = "Allow"
            Resource = "*"
        },
        ]
    })
  
}

resource "aws_iam_instance_profile" "kubus_ha_instance_profile" {
    name = "kubus-ha-instance-profile"
    role = aws_iam_role.kubus_ha_iam.name
}