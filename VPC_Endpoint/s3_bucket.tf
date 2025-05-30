

resource "aws_s3_bucket" "s3-bucket-xxxxxx-29-05-2025" {
  bucket = "s3-bucket-xxxxxx-29-05-2025"
  tags = {
    Name        = "MyS3Bucket"
    Environment = "Stagging"
  }
}

resource "aws_vpc_endpoint" "s3_gateway_endpoint" {
  vpc_id          = aws_vpc.instance_vpc.id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = [aws_route_table.private_route_table.id]
  policy = jsonencode({
  "Statement": [
    {
      "Principal": "*",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    }
    ]
  })

  tags = {
    Name        = "S3GatewayEndpoint"
    Environment = "Stagging"
  }
}

resource "aws_iam_role" "s3_access_role" {
  name = "s3UserAllAccess"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_policy_attachment" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "s3_access_profile" {
  name = "s3UserAllAccess"
  role = aws_iam_role.s3_access_role.name
}
