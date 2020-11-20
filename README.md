## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| kubernetes | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| active\_directory | A map object for Active Directory. please refer https://www.terraform.io/docs/providers/azurerm/r/function_app.html | `any` | `{}` | no |
| app\_settings | App Settings. Package deploy configured | `map(string)` | `{}` | no |
| application\_insights\_type | App insights type | `string` | `"web"` | no |
| auth\_settings | Authentication Settings | <pre>map(object({<br>    auth_enabled = bool<br>  }))</pre> | `{}` | no |
| connection\_strings | connection strings for fn app | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| environment | Environment. Upto 5 character. For e.g. dev, dev01 , prd01 | `string` | n/a | yes |
| existing\_asp\_name | Existing App Service plan name | `string` | `""` | no |
| existing\_asp\_resource\_group\_name | Existing App Service plan resource Group | `string` | `""` | no |
| fn\_app\_additional\_tags | Additional tags for the App Service resources, in addition to the resource group tags. | `map(string)` | `{}` | no |
| host | Hostname without the stratos.shell/stratos.shell.com suffix | `string` | n/a | yes |
| instance | Instance number | `string` | `"001"` | no |
| integration\_subnet\_id | Subnet IDS for VNet integration | `string` | `""` | no |
| linux\_fx\_version | Linux Docker image to use | `string` | `""` | no |
| nameSuffix | name suffix for the function app | `string` | n/a | yes |
| os\_type | OS Type for the fn app. Should match with App Service plan | `string` | `null` | no |
| owner | owner | `string` | n/a | yes |
| placement | placement | `string` | `"PUB"` | no |
| project | project stream name | `string` | `"Stratos"` | no |
| projectStream | 4 character project stream name/code | `string` | n/a | yes |
| region | region. Choose from australia, europe, asia, europe | `string` | n/a | yes |
| releaseVersion | releaseVersion | `string` | `"100"` | no |
| resource\_group\_name | Resource Group name where the fn app needs to be created | `string` | `""` | no |
| runtime\_version | Run time version of the Fn app | `string` | `"~3"` | no |
| site\_config | Site config block for Fn app | <pre>map(object({<br>    always_on                 = bool<br>    http2_enabled             = bool<br>    ftps_state                = string<br>    use_32_bit_worker_process = bool<br>    websockets_enabled        = bool<br>  }))</pre> | `{}` | no |
| site\_config\_cors | Site config core parameters for Fn app | <pre>map(object({<br>    allowed_origins     = list(string)<br>    support_credentials = bool<br>  }))</pre> | `{}` | no |
| site\_config\_ip\_restrictions | site config ip restrictions block parameters for fn app | `any` | `[]` | no |
| workStream | 4 character project stream name/code | `string` | n/a | yes |

## Outputs

No output.
