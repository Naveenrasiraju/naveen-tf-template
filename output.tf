# -
# - App Service
# -

output "fn_app" {
  description = "Map output of the Fnapp Services"
  value       = { for k, b in azurerm_function_app.fn : k => b }
}

# -
# - App Service - Map outputs
# -

output "app_service_plans" {
  description = "Map output of the App Service Plans"
  value       = { for k, b in azurerm_app_service_plan.asp : k => b }
}
