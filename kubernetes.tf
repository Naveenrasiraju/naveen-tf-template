resource "kubernetes_service" "fn_svc" {
  count = var.host == "" ? 0 : 1
  metadata {
    name      = "${var.nameSuffix}-service"
    namespace = lower(local.k8s_namespace)
  }
  spec {
    port {
      port        = 8443
      target_port = 443
      name        = "https"
      protocol    = "TCP"
    }
    type          = "ExternalName"
    external_name = azurerm_function_app.fn.default_hostname
  }
}


resource "kubernetes_ingress" "fn_ingress" {
  count = var.host == "" ? 0 : 1
  metadata {
    name      = "${var.nameSuffix}-ingress"
    namespace = lower(local.k8s_namespace)
    annotations = {
      "kubernetes.io/ingress.class"                  = "nginx"
      "cert-manager.io/cluster-issuer"               = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/backend-protocol" = "HTTPS"
      "nginx.ingress.kubernetes.io/upstream-vhost"   = azurerm_function_app.fn.default_hostname
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = "${var.nameSuffix}-service"
            service_port = 8443
          }
        }
      }
      host = var.host
    }
    tls {
      hosts       = [var.host]
      secret_name = var.host
    }
  }
}
