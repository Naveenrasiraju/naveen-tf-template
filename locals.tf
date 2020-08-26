locals {
  tags         = merge(var.fn_app_additional_tags, data.azurerm_resource_group.rg.tags, module.tag.tags_without_location)
  storage_name = "${substr(var.projectStream, 0, 4)}${substr(var.workStream, 0, 3)}sg2${var.environment}${substr(var.nameSuffix, -6, 0)}"
  app_insights = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.app_insights.instrumentation_key,
    APPLICATIONINSIGHTS_CONNECTION_STRING      = "InstrumentationKey=${azurerm_application_insights.app_insights.instrumentation_key}",
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
  }
  # website_run_from_package = var.sourcezip == "" ? {} : { WEBSITE_RUN_FROM_PACKAGE = var.sourcezip }
  vnet_rg               = "${upper(substr(var.projectStream, 0, 4))}${upper(substr(var.workStream, 0, 3))}-${upper(substr(var.placement, 0, 3))}-P-${upper(var.environment)}-100-001-RG"
  vnet                  = "${upper(substr(var.projectStream, 0, 4))}${upper(substr(var.workStream, 0, 3))}-${upper(substr(var.placement, 0, 3))}-P-${upper(var.environment)}-VN-001"
  subnet                = "${upper(substr(var.projectStream, 0, 4))}${upper(substr(var.workStream, 0, 3))}-${upper(substr(var.placement, 0, 3))}-P-${upper(var.environment)}-APPSVC-001"
  useridentity          = "${upper(substr(var.projectStream, 0, 4))}${upper(substr(var.workStream, 0, 3))}${upper(var.environment)}DEF001"
  name                  = "${substr(var.projectStream, 0, 4)}-${substr(var.workStream, 0, 3)}-${var.placement}-${var.environment}-${module.tag.location_short}-${var.releaseVersion}-appf-${var.nameSuffix}"
  integration_subnet_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.vnet_rg}/providers/Microsoft.Network/virtualNetworks/${local.vnet}/subnets/${local.subnet}"
  identity_ids          = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.vnet_rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${local.useridentity}"

}
