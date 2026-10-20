# terraform/primitives/compliant-s3/outputs.tf

output "bucket_arn" { value = aws_s3_bucket.primary.arn }
output "bucket_name" { value = aws_s3_bucket.primary.id }
output "log_bucket_arn" { value = aws_s3_bucket.log.arn }

output "encryption_algorithm" {
  description = "Server-side encryption algorithm in effect (SC-28 attestation)."
  value = one([
    for rule in aws_s3_bucket_server_side_encryption_configuration.primary.rule :
    rule.apply_server_side_encryption_by_default[0].sse_algorithm
  ])
}

# Why the one(...) expression looks odd. 
# Terraform represents that rule block as a set, not a list, 
# and sets can't be accessed by index. The for expression flattens 
# the single rule into a list, and one() pulls out the lone element, 
# failing loudly if there's ever somehow more than one. 
# It catches everyone off-guard the first time. Once you've seen it, 
# you'll recognize the pattern whenever a nested block is modeled as a set.
