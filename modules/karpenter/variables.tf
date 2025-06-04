
variable "cluster_name" {
  type        = string
}

variable "cluster_endpoint" {
  type        = string
}

variable "cluster_certificate_authority_data" {
  type        = string
}

variable "service_account" {
  type        = string
}

variable "queue_name" {
  type        = string
}

variable "node_iam_role_name" {
  type        = string
}

#variable "oidc_provider_arn" {
#  description = "OIDC provider ARN"
#  type        = string
#}

#variable "account_id" {
#  description = "AWS account ID"
#  type        = string
#}

