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
      "kubernetes.io/ingress.class"                       = "nginx"
      "cert-manager.io/cluster-issuer"                    = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/backend-protocol"      = "HTTPS"
      "nginx.ingress.kubernetes.io/upstream-vhost"        = azurerm_function_app.fn.default_hostname
      "nginx.ingress.kubernetes.io/auth-response-headers" = <<EOF
        X-Vouch-User, X-Vouch-AccessToken, X-Vouch-IdP-AccessToken, X-Vouch-IdP-Claims-Name, X-Vouch-IdP-Claims-Group
       EOF
      "nginx.ingress.kubernetes.io/auth-signin"           = "https://vouch.stratos.shell/login?url=$scheme://$http_host$request_uri&vouch-failcount=$auth_resp_failcount&X-Vouch-Token=$auth_resp_jwt&error=$auth_resp_err"
      "nginx.ingress.kubernetes.io/auth-snippet"          = <<EOF
       #these return values are used by the @error401 call\n
       auth_request_set $auth_resp_jwt $upstream_http_x_vouch_jwt;\n
       auth_request_set $auth_resp_err $upstream_http_x_vouch_err;\n
       auth_request_set $auth_resp_failcount $upstream_http_x_vouch_failcount;    \n
       EOF
      "nginx.ingress.kubernetes.io/auth-url"              = "https://vouch.stratos.shell/validate"
      "nginx.ingress.kubernetes.io/force-ssl-redirect"    = "true"
      "nginx.ingress.kubernetes.io/proxy-buffer-size"     = "512k"
      "nginx.ingress.kubernetes.io/proxy-buffers-number"  = "8"
      "nginx.ingress.kubernetes.io/rewrite-target"        = "/"
      "nginx.ingress.kubernetes.io/ssl-redirect"          = "false"
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
