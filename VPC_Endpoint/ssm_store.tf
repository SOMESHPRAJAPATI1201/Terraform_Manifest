resource "aws_ssm_parameter" "s3_access_role" {
  name        = "s3AccessRole"
  description = "An example SSM parameter"
  type        = "String"
  value       = "s3UserAllAccess"
}