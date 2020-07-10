## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| active\_directory | n/a | <pre>map(object({<br>    client_id     = string<br>    client_secret = string<br>  }))</pre> | `{}` | no |
| app\_prefix | App resourcess name prefix. | `string` | n/a | yes |
| app\_settings | App Settings. Package deploy configured | `map(string)` | `{}` | no |
| application\_insights\_type | App insights type | `string` | `"web"` | no |
| asp\_kind | App service plan kind. Should be able to accomodate the fn app | `string` | `"Windows"` | no |
| asp\_max\_worker\_cnt | App Service plan max worker count | `number` | `2` | no |
| asp\_reserved | Reserved field for App Service plan (Linux). Boolean | `bool` | `false` | no |
| asp\_sku\_cap | App Service plan capacity | `string` | `null` | no |
| asp\_sku\_size | App service plan size | `string` | `"P1V2"` | no |
| asp\_sku\_tier | Tier of the app service plan | `string` | `"Premium"` | no |
| auth\_settings | Authentication Settings | <pre>map(object({<br>    auth_enabled = string<br>  }))</pre> | `{}` | no |
| client\_affinity\_enabled | Should client affinity be enabled? | `bool` | `null` | no |
| connection\_strings | connection strings for fn app | <pre>map(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `{}` | no |
| create\_application\_insights\_resource | Require application insights resource? | `bool` | `true` | no |
| environment | Environment | `string` | n/a | yes |
| existing\_asp\_name | Existing App Service plan name | `string` | `""` | no |
| existing\_asp\_res\_grp\_name | Existing App Service plan resource Group | `string` | `""` | no |
| existing\_service\_plan\_enabled | Existing service plan enabled ? | `bool` | n/a | yes |
| fn\_app\_additional\_tags | Additional tags for the App Service resources, in addition to the resource group tags. | `map(string)` | `{}` | no |
| fn\_app\_location | Function App location | `string` | `""` | no |
| fn\_enabled | Should fn app be enabled? | `bool` | `true` | no |
| fn\_required | Is Fn app required? | `bool` | `true` | no |
| identity | identity for fn app | <pre>map(object({<br>    identity_ids = string<br>    type         = string<br>  }))</pre> | `{}` | no |
| os\_type | OS Type for the fn app. Should match with App Service plan | `string` | `null` | no |
| owner | owner | `string` | n/a | yes |
| placement | placement | `string` | `"PUB"` | no |
| projectStream | project stream name | `string` | `"F4DP"` | no |
| region | region | `string` | n/a | yes |
| releaseVersion | releaseVersion | `string` | `"0.1.0"` | no |
| res\_grp\_name | Resource Group name where the fn app needs to be created | `string` | n/a | yes |
| runtime\_version | Run time version of the Fn app | `string` | `"~3"` | no |
| site\_config | Site config block for Fn app | <pre>map(object({<br>    always_on                 = bool<br>    linux_fx_version          = string<br>    http2_enabled             = bool<br>    ftps_state                = string<br>    use_32_bit_worker_process = bool<br>    websockets_enabled        = bool<br>  }))</pre> | `{}` | no |
| site\_config\_cors | Site config core parameters for Fn app | <pre>map(object({<br>    allowed_origins     = list(string)<br>    support_credentials = string<br>  }))</pre> | `{}` | no |
| site\_config\_ip\_restrictions | site config ip restrictions block parameters for fn app | <pre>map(object({<br>    ip_address                 = string<br>    virtual_network_subnet_ids = string<br>  }))</pre> | `{}` | no |
| sourcezip | Zip file location to be used to do the deployment. Should be publicly accessible | `string` | n/a | yes |
| subnet\_ids | Subnet IDS for VNet integration | `string` | `null` | no |
| vnet\_integration\_required | Vnet integration required for the function app? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service\_plans | Map output of the App Service Plans |
| fn\_app | Map output of the Fnapp Services |
