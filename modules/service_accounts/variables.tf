variable "service_account_id" {
  type = string
  description = "service account id"
}
variable "service_account_display_name" {
  type = string
  description = "service account display name"
}


### for creating multiple service accounts... as this is being exposed as module we can call it in other modules..
#variable "service_accounts_to_create" {
#  type = list(object({
#    account_id               = string
#    display_name       = string
#    # Add other necessary configurations for each node pool, kept minimal.
#  }))
#  description = "services to be enabled"
#}
variable "project" {
  type        = string
  description = "project id"
}