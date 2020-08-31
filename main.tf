module "tag" {
  source         = "git::https://sede-ds-adp.visualstudio.com/Platform%20-%20General/_git/sedp-tf-az-tagging?ref=v0.3.0"
  projectStream  = var.projectStream
  workStream     = var.workStream
  environment    = var.environment
  owner          = var.owner
  region         = var.region
  placement      = var.placement
  releaseVersion = var.releaseVersion
}



data "azurerm_user_assigned_identity" "this" {
  name                = local.useridentity
  resource_group_name = upper(local.vnet_rg)
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_app_service_plan" "asp" {
  name                = var.existing_asp_name
  resource_group_name = var.existing_asp_resource_group_name
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = lower(local.storage_name)
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = module.tag.location_primary
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = merge(local.tags, { functionapp = local.name })
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.integration_subnet_id == "" ? local.integration_subnet_id : var.integration_subnet_id]
  }
}

# Application Insights
resource "azurerm_application_insights" "app_insights" {
  name                = "${var.projectStream}${var.workStream}-${var.environment}-ai${var.nameSuffix}"
  location            = module.tag.location_primary
  resource_group_name = data.azurerm_resource_group.rg.name
  application_type    = var.application_insights_type
  tags                = merge(local.tags, { functionapp = local.name })
}




resource "azurerm_function_app" "fn" {
  name                       = local.name
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = module.tag.location_primary
  app_service_plan_id        = data.azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  #  app_settings               = merge(var.app_settings, local.website_run_from_package, local.app_insights)
  app_settings = merge(var.app_settings, local.app_insights)
  dynamic "connection_string" {
    for_each = concat(var.connection_strings, [])
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }
  //  dynamic "auth_settings" {
  //    for_each = var.auth_settings
  //    content {
  //      enabled = auth_settings.auth_enabled
  //      dynamic active_directory {
  //        for_each = var.active_directory
  //        content {
  //          client_id     = active_directory.client_id
  //          client_secret = active_directory.client_secret
  //        }
  //      }
  //    }
  //  }

  os_type    = var.os_type
  enabled    = true
  https_only = true
  version    = var.runtime_version
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
      linux_fx_version          = lookup(site_config.value, "linux_fx_version", null)
      min_tls_version           = lookup(site_config.value, "min_tls_version", null)
      use_32_bit_worker_process = lookup(site_config.value, "use_32_bit_worker_process", null)
      websockets_enabled        = lookup(site_config.value, "websockets_enabled", null)
    }
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [local.identity_ids]
  }

  tags = local.tags
}

data "azurerm_client_config" "current" {
}


# Vnet integration
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_function_app.fn.id
  subnet_id      = var.integration_subnet_id == "" ? local.integration_subnet_id : var.integration_subnet_id
}
