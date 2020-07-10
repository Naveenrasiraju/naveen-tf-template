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
  default     = "0.1.0"
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

variable "app_prefix" {
  description = "App resourcess name prefix."
  type        = string
}
variable "res_grp_name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "existing_service_plan_enabled" {
  type        = bool
  description = "(optional) describe your variable"
}

variable "create_application_insights_resource" {
  type        = bool
  default     = true
  description = "(optional) describe your variable"
}


variable "os_type" {
  type        = string
  default     = null
  description = "(optional) describe your variable"
}



variable "asp_kind" {
  type        = string
  default     = "Windows"
  description = "(optional) describe your variable"
}
variable "asp_reserved" {
  type        = bool
  default     = false
  description = "(optional) describe your variable"
}
variable "asp_sku_tier" {
  type        = string
  default     = "Premium"
  description = "(optional) describe your variable"
}

variable "asp_sku_size" {
  type    = string
  default = "P1V2"
}

variable "asp_sku_cap" {
  type        = string
  default     = null
  description = "(optional) describe your variable"
}
variable "asp_max_worker_cnt" {
  type        = number
  default     = 2
  description = "(optional) describe your variable"
}

variable "fn_app_location" {
  type        = string
  default     = ""
  description = "(optional) describe your variable"
}

variable "existing_asp_name" {
  type        = string
  default     = ""
  description = "(optional) describe your variable"
}

variable "existing_asp_res_grp_name" {
  default = ""
  type    = string
}

variable "auth_settings" {
  type = map(object({
    auth_enabled = string
  }))
  description = "(optional) describe your variable"
  default     = {}
}

variable "active_directory" {

  type = map(object({
    client_id     = string
    client_secret = string
  }))
  default = {}

}

variable "connection_strings" {
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
  default = {}
}

variable "identity" {
  type = map(object({
    identity_ids = string
    type         = string
  }))
  default = {}
}

variable "application_insights_type" {
  type        = string
  default     = "web"
  description = "(optional) describe your variable"
}
variable "site_config" {
  type = map(object({
    always_on        = bool
    linux_fx_version = string
  }))
  default = {}
}

variable "site_config_ip_restrictions" {
  type = map(object({
    ip_address                 = string
    virtual_network_subnet_ids = string
  }))
  default = {}
}

variable "site_config_cors" {
  type = map(object({
    allowed_origins     = list(string)
    support_credentials = string
  }))
  default = {}
}



variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "fn_required" {
  type        = bool
  default     = true
  description = "(optional) describe your variable"
}

variable "client_affinity_enabled" {
  type        = bool
  default     = null
  description = "(optional) describe your variable"
}

variable "fn_enabled" {
  type        = bool
  default     = true
  description = "(optional) describe your variable"
}

variable "https_only" {
  type        = bool
  description = "(optional) describe your variable"
}

variable "runtime_version" {
  type        = string
  default     = "~3"
  description = "(optional) describe your variable"
}


variable "subnet_ids" {
  type    = string
  default = null
}

variable "sourcezip" {
  type        = string
  description = "(optional) describe your variable"
}
