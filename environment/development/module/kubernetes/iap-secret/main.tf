resource "kubectl_manifest" "secter_namespace" {
  yaml_body = <<YAML
      apiVersion: v1
      kind: Namespace
      metadata:
        name: ${var.namespace_name}
  YAML
}

resource "kubectl_manifest" "iap_oauth_secret" {
  yaml_body = <<YAML
      apiVersion: v1
      kind: Secret
      metadata:
        name: iap-oauth
        namespace: ${var.namespace_name}
      type: Opaque
      data:
        client_id: ${base64encode(var.oauth_client_id)}
        client_secret: ${base64encode(var.oauth_client_secret)}
  YAML
}
