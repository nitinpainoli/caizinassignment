data "aws_vpc" "dev" {
  filter {
    name   = "tag:Environment"
    values = ["test"]
  }
}

# data "aws_subnets" "dev-public" {
#   filter {
#     name   = "tag:Scope"
#     values = ["public"]
#   }
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.dev.id]
#   }
# }

data "aws_subnets" "dev-private" {
  filter {
    name   = "tag:Scope"
    values = ["public"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.dev.id]
  }
}

