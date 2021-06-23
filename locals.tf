locals {
  tags         = merge(var.fn_app_additional_tags, module.tag.tags_without_location, { dateCreated = local.dateCreated })
  dateCreated  = formatdate("DD-MMM-YYYY hh:mm:ss ZZZ", timestamp())
  storage_name = "${substr(var.projectStream, 0, 4)}${substr(var.workStream, 0, 3)}sg2${var.environment}${random_string.randstring.result}"
  app_insights = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.app_insights.instrumentation_key,
    APPLICATIONINSIGHTS_CONNECTION_STRING      = "InstrumentationKey=${azurerm_application_insights.app_insights.instrumentation_key}",
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
    AZURE_CLIENT_ID                            = data.azurerm_client_config.current.client_id
  }
  wkstm                            = var.workStream == "" ? "" : "-${substr(var.workStream, 0, 3)}"
  vnet_rg                          = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(substr(var.placement, 0, 3))}-P-${upper(var.environment)}-${upper(var.releaseVersion)}-${upper(var.instance)}-RG"
  vnet                             = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(substr(var.placement, 0, 3))}-${upper(var.environment)}-${upper(lookup(module.tag.region_short, module.tag.location_primary))}-VN-001"
  subnet                           = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(substr(var.placement, 0, 3))}-${upper(var.environment)}-${upper(lookup(module.tag.region_short, module.tag.location_primary))}-APPSVC-001"
  useridentity                     = "${upper(substr(var.projectStream, 0, 4))}${upper(substr(var.workStream, 0, 3))}${upper(var.environment)}DEF001"
  name                             = "${substr(var.projectStream, 0, 4)}${lower(local.wkstm)}-${var.placement}-${var.environment}-${module.tag.location_short}-${var.releaseVersion}-appf-${var.nameSuffix}"
  ag_name                          = "${substr(var.projectStream, 0, 4)}${lower(local.wkstm)}-${var.placement}-${var.environment}-${module.tag.location_short}-${var.releaseVersion}-ag-${var.nameSuffix}"
  al_name                          = "${substr(var.projectStream, 0, 4)}${lower(local.wkstm)}-${var.placement}-${var.environment}-${module.tag.location_short}-${var.releaseVersion}-al-${var.nameSuffix}"
  #integration_subnet_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.vnet_rg}/providers/Microsoft.Network/virtualNetworks/${local.vnet}/subnets/${local.subnet}"
  identity_ids                     = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.vnet_rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${local.useridentity}"
  ostype                           = lower(var.os_type) == "linux" ? "LNX" : "WIN"
  ainame                           = "${var.projectStream}${var.workStream}-${var.environment}-ai${var.nameSuffix}"
  existing_asp_name                = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(var.placement)}-P-${upper(var.environment)}-${upper(var.releaseVersion)}-${upper(var.instance)}-APPSP${local.ostype}"
  existing_asp_resource_group_name = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(var.placement)}-P-${upper(var.environment)}-${upper(var.releaseVersion)}-${upper(var.instance)}-APPSP${local.ostype}-RG"
  resource_group_name              = "${upper(substr(var.projectStream, 0, 4))}${upper(local.wkstm)}-${upper(var.placement)}-P-${upper(var.environment)}-${upper(var.releaseVersion)}-${upper(var.instance)}-APP-RG"

  k8s_namespace = "${substr(var.projectStream, 0, 4)}${local.wkstm}-${var.environment}-${var.placement}"

}
