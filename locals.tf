locals {
  location     = var.fn_app_location == "" ? data.azurerm_resource_group.rg.location : var.fn_app_location
  tags         = merge(var.fn_app_additional_tags, data.azurerm_resource_group.rg.tags, module.tag.tags_primary)
  storage_name = "dp${var.projectStream}sg2${var.placement}fn${random_integer.suffix.result}"
  app_insights = var.create_application_insights_resource == true ? {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.app_insights[0].instrumentation_key,
    APPLICATIONINSIGHTS_CONNECTION_STRING      = "InstrumentationKey=${azurerm_application_insights.app_insights[0].instrumentation_key}",
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
  } : {}
  website_run_from_package = var.sourcezip == "" ? {} : { WEBSITE_RUN_FROM_PACKAGE = var.sourcezip }
}
