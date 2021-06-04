alert_metrics = [
  
    {
        metric_name       = "Http2xx"
        aggregation       = "Maximum"
        operator          = "GreaterThan"
        threshold         = 1
    },
    {
        metric_name       = "Http5xx"
        aggregation       = "Maximum"
        operator          = "GreaterThan"
        threshold         = 1
    },
    {
        metric_name       = "HealthCheckStatus"
        aggregation       = "Maximum"
        operator          = "GreaterThan"
        threshold         = 1
    }
]

alert_logs = [
    {

    },
    {
        
    }
]