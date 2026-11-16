# vpc outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# private subnet outputs
output "private_subnet_ids" {
    description = "The IDs of the private subnets"
    value       = module.vpc.private_subnets
}

# database subnet outputs
output "database_subnet_ids" {
    description = "The IDs of the database subnets"
    value       = module.vpc.database_subnets
}

# public subnet outputs
output "public_subnet_ids" {
    description = "The IDs of the public subnets"
    value       = module.vpc.public_subnets
}