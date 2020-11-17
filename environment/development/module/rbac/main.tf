resource "gsuite_group_member" "group_gke_security" {
  group = var.group_gke_security
  email = var.group_gke_admin
  role  = "MEMBER"
}

# resource "kubectl_manifest" "test" {
#   yaml_body = <<YAML
#     kind: ClusterRoleBinding
#     apiVersion: rbac.authorization.k8s.io/v1beta1
#     metadata:
#       name: admin
#     roleRef:
#       kind: ClusterRole
#       name: admin
#       apiGroup: rbac.authorization.k8s.io
#     subjects:
#     - kind: Group
#       name: group-admin-prj-kon-app-d-b7ec@dmoiseenko.me
#       namespace: flux-system
#   YAML
# }
