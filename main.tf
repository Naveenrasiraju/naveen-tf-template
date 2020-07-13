module "tag" {
  source         = "git::https://sede-ds-adp.visualstudio.com/Platform%20-%20General/_git/sedp-tf-az-tagging?ref=v0.2.0"
  projectStream  = var.projectStream
  environment    = var.environment
  owner          = var.owner
  region         = var.region
  placement      = var.placement
  releaseVersion = var.releaseVersion
}


data "azurerm_resource_group" "rg" {
  name = var.res_grp_name
}


data "azurerm_app_service_plan" "asp" {
  count               = "${var.existing_service_plan_enabled == true ? 1 : 0}"
  name                = var.existing_asp_name
  resource_group_name = var.existing_asp_res_grp_name
}

# App service plan
resource "azurerm_app_service_plan" "asp" {
  count                        = var.existing_service_plan_enabled == true ? 0 : 1
  name                         = "${var.app_prefix}-asp${random_integer.suffix.result}"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = local.location
  kind                         = var.asp_kind
  maximum_elastic_worker_count = var.asp_max_worker_cnt
  sku {
    tier     = var.asp_sku_tier
    size     = var.asp_sku_size
    capacity = var.asp_sku_cap
  }
  reserved = var.asp_reserved
  tags     = local.tags
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = lower(local.storage_name)
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action             = "Deny"
    ip_rules                   = module.tag.ip_whitelist
    virtual_network_subnet_ids = [var.integration_subnet_id]
    bypass                     = ["Logging", "Metrics", "AzureServices"]
  }
  tags = local.tags
}

# Application Insights
resource "azurerm_application_insights" "app_insights" {
  name                = "${var.app_prefix}-${var.projectStream}-${var.environment}-ai${random_integer.suffix.result}"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = var.application_insights_type
  tags                = local.tags
  count               = var.create_application_insights_resource == true ? 1 : 0
}



resource "random_integer" "suffix" {
  min = 100000
  max = 500000
}

resource "azurerm_function_app" "fn" {
  count                      = var.fn_required == true ? 1 : 0
  name                       = "${var.app_prefix}-fn-${random_integer.suffix.result}"
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = local.location
  app_service_plan_id        = var.existing_service_plan_enabled == true ? data.azurerm_app_service_plan.asp[0].id : azurerm_app_service_plan.asp[0].id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  //app_settings               = merge(var.app_settings, { WEBSITE_RUN_FROM_PACKAGE = var.sourcezip }, local.app_insights)
  app_settings = merge(var.app_settings, local.website_run_from_package, local.app_insights)
  dynamic "connection_string" {
    for_each = merge(var.connection_strings, {})
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }
  dynamic auth_settings {
    for_each = var.auth_settings
    content {
      enabled = auth_settings.auth_enabled
      dynamic active_directory {
        for_each = var.active_directory
        content {
          client_id     = active_directory.client_id
          client_secret = active_directory.client_secret
        }
      }
    }
  }

  client_affinity_enabled = var.client_affinity_enabled
  os_type                 = var.os_type
  enabled                 = var.fn_enabled
  https_only              = true
  version                 = var.fnapp_version
  dynamic "site_config" {
    for_each = merge(var.site_config, {})
    content {
      always_on = lookup(site_config.value, "always_on", null)
      dynamic "ip_restriction" {
        for_each = concat(var.site_config_ip_restrictions, [])
        content {
          ip_address = lookup(ip_restriction.value, "ip_address", null)
          subnet_id  = lookup(ip_restriction.value, "virtual_network_subnet_ids", null)
        }
      }
      dynamic "cors" {
        for_each = merge(var.site_config_cors, {})
        content {
          allowed_origins     = lookup(cors.value, "allowed_origins", null)
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }

      ftps_state                = lookup(site_config.value, "ftps_state", null)
      http2_enabled             = lookup(site_config.value, "http2_enabled", null)
      linux_fx_version          = lookup(site_config.value, "linux_fx_version", null) == null ? null : lookup(site_config.value, "linux_fx_version_local_file_path", null) == null ? lookup(site_config.value, "linux_fx_version", null) : "${lookup(site_config.value, "linux_fx_version", null)}|${filebase64(lookup(site_config.value, "linux_fx_version_local_file_path", null))}"
      min_tls_version           = lookup(site_config.value, "min_tls_version", null)
      use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", null)
      websockets_enabled        = lookup(site_config.value, "websockets_enabled", null)
    }
  }

  dynamic "identity" {
    for_each = merge(var.identity, {})
    content {
      type         = lookup(identity.value, "type", null)
      identity_ids = lookup(identity.value, "identity_ids", null)

    }
  }
  tags = local.tags
}

# Vnet integration
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  count          = var.vnet_integration_required == true ? 1 : 0
  app_service_id = azurerm_function_app.fn[0].id
  subnet_id      = var.integration_subnet_id
}
