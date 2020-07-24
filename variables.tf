variable "placement" {
  description = "placement"
  default     = "PUB"
  type        = string
}


variable "projectStream" {
  description = "project stream name"
  type        = string
  default     = "F4DP"
}

variable "region" {
  type        = string
  description = "region"
}

variable "releaseVersion" {
  description = "releaseVersion"
  default     = "100"
}


variable "owner" {
  description = "owner"
  type        = string
}

variable "vnet_integration_required" {
  type        = bool
  default     = true
  description = "Vnet integration required for the function app?"
}

variable "environment" {
  description = "Environment"
  type        = string
}


variable "fn_app_additional_tags" {
  description = "Additional tags for the App Service resources, in addition to the resource group tags."
  type        = map(string)
  default     = {}
}


variable "fnAppName" {
  description = "Name of the Fn App. Has to be unique worldwide"
  type        = string
}
variable "res_grp_name" {
  type        = string
  description = "Resource Group name where the fn app needs to be created"
}



variable "create_application_insights_resource" {
  type        = bool
  default     = true
  description = "Require application insights resource?"
}


variable "os_type" {
  type        = string
  default     = null
  description = "OS Type for the fn app. Should match with App Service plan"
}




variable "existing_asp_name" {
  type        = string
  default     = ""
  description = "Existing App Service plan name"
}

variable "existing_asp_res_grp_name" {
  default     = ""
  type        = string
  description = "Existing App Service plan resource Group"
}

variable "auth_settings" {
  type = map(object({
    auth_enabled = bool
  }))
  description = "Authentication Settings "
  default     = {}
}


variable "active_directory" {
  type        = any
  default     = {}
  description = "A map object for Active Directory. please refer https://www.terraform.io/docs/providers/azurerm/r/function_app.html"
}



variable "connection_strings" {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default     = []
  description = "connection strings for fn app"
}

variable "identity" {
  type        = any
  default     = {}
  description = "identity for fn app. please refer https://www.terraform.io/docs/providers/azurerm/r/function_app.html"
}


variable "application_insights_type" {
  type        = string
  default     = "web"
  description = "App insights type"
}
variable "site_config" {
  type = map(object({
    always_on                 = bool
    linux_fx_version          = string
    http2_enabled             = bool
    ftps_state                = string
    use_32_bit_worker_process = bool
    websockets_enabled        = bool
  }))
  default     = {}
  description = "Site config block for Fn app"
}


variable "site_config_ip_restrictions" {
  type        = any
  default     = []
  description = "site config ip restrictions block parameters for fn app"
}

variable "site_config_cors" {
  type = map(object({
    allowed_origins     = list(string)
    support_credentials = string
  }))
  default     = {}
  description = "Site config core parameters for Fn app"
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "App Settings. Package deploy configured"
}

variable "fn_required" {
  type        = bool
  default     = true
  description = "Is Fn app required?"
}

variable "client_affinity_enabled" {
  type        = bool
  default     = null
  description = "Should client affinity be enabled?"
}

variable "fn_enabled" {
  type        = bool
  default     = true
  description = "Should fn app be enabled?"
}


variable "fnapp_version" {
  type        = string
  default     = "~3"
  description = "Run time version of the Fn app"
}


variable "integration_subnet_id" {
  type        = string
  default     = null
  description = "Subnet IDS for VNet integration"
}

variable "sourcezip" {
  type        = string
  default     = ""
  description = "Zip file location to be used to do the deployment. Should be publicly accessible"
}
