variable "federation_sa" {
  type = object({
    roles        = list(string)
    account_id   = string
    display_name = string
  })
  description = "service account will be used to enable identity federation in kubernetes cluster for desired namespaces"

}