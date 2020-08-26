variable "placement" {
  description = "placement"
  default     = "PUB"
  type        = string
}


variable "project" {
  description = "project stream name"
  type        = string
  default     = "Stratos"
}
variable "projectStream" {
  description = " 4 character project stream name/code "
  type        = string
}

variable "workStream" {
  description = " 4 character project stream name/code "
  type        = string
}

variable "region" {
  type        = string
  description = "region. Choose from australia, europe, asia, europe"
}

variable "releaseVersion" {
  description = "releaseVersion"
  default     = "100"
}


variable "owner" {
  description = "owner"
  type        = string
}


variable "environment" {
  description = "Environment. Upto 5 character. For e.g. dev, dev01 , prd01"
  type        = string
}


variable "fn_app_additional_tags" {
  description = "Additional tags for the App Service resources, in addition to the resource group tags."
  type        = map(string)
  default     = {}
}



variable "resource_group_name" {
  type        = string
  description = "Resource Group name where the fn app needs to be created"
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

variable "existing_asp_resource_group_name" {
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

variable "nameSuffix" {
  type        = string
  description = "name suffix for the function app"
}
variable "site_config_ip_restrictions" {
  type        = any
  default     = []
  description = "site config ip restrictions block parameters for fn app"
}

variable "site_config_cors" {
  type = map(object({
    allowed_origins     = list(string)
    support_credentials = bool
  }))
  default     = {}
  description = "Site config core parameters for Fn app"
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "App Settings. Package deploy configured"
}


variable "runtime_version" {
  type        = string
  default     = "~3"
  description = "Run time version of the Fn app"
}


variable "integration_subnet_id" {
  type        = string
  default     = ""
  description = "Subnet IDS for VNet integration"
}
