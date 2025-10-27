variable "bucket_name" {
  type        = string
  description = "bucket name"
}

variable "dynamodb_table_name" {
  type        = string
  description = "dynamodb table for avoiding couple of applyings at the same time"
}
