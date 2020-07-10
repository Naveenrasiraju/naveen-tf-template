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
| app\_settings | n/a | `map(string)` | `{}` | no |
| application\_insights\_type | (optional) describe your variable | `string` | `"web"` | no |
| asp\_kind | (optional) describe your variable | `string` | `"Windows"` | no |
| asp\_max\_worker\_cnt | (optional) describe your variable | `number` | `2` | no |
| asp\_reserved | (optional) describe your variable | `bool` | `false` | no |
| asp\_sku\_cap | (optional) describe your variable | `string` | `null` | no |
| asp\_sku\_size | n/a | `string` | `"P1V2"` | no |
| asp\_sku\_tier | (optional) describe your variable | `string` | `"Premium"` | no |
| auth\_settings | (optional) describe your variable | <pre>map(object({<br>    auth_enabled = string<br>  }))</pre> | `{}` | no |
| client\_affinity\_enabled | (optional) describe your variable | `bool` | `null` | no |
| connection\_strings | n/a | <pre>map(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `{}` | no |
| create\_application\_insights\_resource | (optional) describe your variable | `bool` | `true` | no |
| environment | Environment | `string` | n/a | yes |
| existing\_asp\_name | (optional) describe your variable | `string` | `""` | no |
| existing\_asp\_res\_grp\_name | n/a | `string` | `""` | no |
| existing\_service\_plan\_enabled | (optional) describe your variable | `bool` | n/a | yes |
| fn\_app\_additional\_tags | Additional tags for the App Service resources, in addition to the resource group tags. | `map(string)` | `{}` | no |
| fn\_app\_location | (optional) describe your variable | `string` | `""` | no |
| fn\_enabled | (optional) describe your variable | `bool` | `true` | no |
| fn\_required | (optional) describe your variable | `bool` | `true` | no |
| https\_only | (optional) describe your variable | `bool` | n/a | yes |
| identity | n/a | <pre>map(object({<br>    identity_ids = string<br>    type         = string<br>  }))</pre> | `{}` | no |
| os\_type | (optional) describe your variable | `string` | `null` | no |
| owner | owner | `string` | n/a | yes |
| placement | placement | `string` | `"PUB"` | no |
| projectStream | project stream name | `string` | `"F4DP"` | no |
| region | region | `string` | n/a | yes |
| releaseVersion | releaseVersion | `string` | `"0.1.0"` | no |
| res\_grp\_name | (optional) describe your variable | `string` | n/a | yes |
| runtime\_version | (optional) describe your variable | `string` | `"~3"` | no |
| site\_config | n/a | <pre>map(object({<br>    always_on        = bool<br>    linux_fx_version = string<br>  }))</pre> | `{}` | no |
| site\_config\_cors | n/a | <pre>map(object({<br>    allowed_origins     = list(string)<br>    support_credentials = string<br>  }))</pre> | `{}` | no |
| site\_config\_ip\_restrictions | n/a | <pre>map(object({<br>    ip_address                 = string<br>    virtual_network_subnet_ids = string<br>  }))</pre> | `{}` | no |
| sourcezip | (optional) describe your variable | `string` | n/a | yes |
| subnet\_ids | n/a | `string` | `null` | no |
| vnet\_integration\_required | Vnet integration required for the function app? | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_service\_plans | Map output of the App Service Plans |
| fn\_app | Map output of the Fnapp Services |
