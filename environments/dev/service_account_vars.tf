variable "federation_sa" {
  type = map(string)
  description = "service account will be used to enable identity federation in kubernetes cluster for desired namespaces"

}