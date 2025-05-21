
resource "random_pet" "petname" {
  length = 5
  separator = "-"
}

resource "random_pet" "petname1" {
  length = 5
  separator = "-"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = random_pet.petname.id
  region = "us-east-1"
  tags = {
    Name = "my_bucket"
  }
}


resource "aws_s3_bucket" "my_bucket1" {
  bucket = random_pet.petname1.id
  tags = {
    Name = "my_bucket1"
  }
}