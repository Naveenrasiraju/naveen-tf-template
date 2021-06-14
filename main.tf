module "tag" {
  source         = "git::https://sede-ds-adp.visualstudio.com/Platform%20-%20General/_git/sedp-tf-az-tagging?ref=v0.3.2"
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
  name = var.resource_group_name == "" ? local.resource_group_name : var.resource_group_name

}


resource "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_cache_name
  location            = var.redis_cache_location
  resource_group_name = var.redis_cache_resource_group_name
  capacity            = var.redis_cache_capacity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_sku_name
  enable_non_ssl_port = var.redis_cache_enable_non_ssl_port

  redis_configuration {
    maxmemory_policy   = var.redis_cache_maxmemory_policy
    maxmemory_reserved = var.redis_cache_maxmemory_reserved
    maxmemory_delta    = var.redis_cache_maxmemory_delta
  }
}

resource "null_resource" "redis_cache_georeplication" {
  count         = var.has_redis_cache_georeplication ? 1 : 0

  provisioner "local-exec" {
    command     = "az redis server-link create --name ${var.redis_cache_name} --replication-role ${var.redis_cache_replication_role} --resource-group ${var.redis_cache_resource_group_name} --server-to-link ${var.redis_cache_georeplication_name}"
  }

  depends_on    = [azurerm_redis_cache.redis_cache]
}