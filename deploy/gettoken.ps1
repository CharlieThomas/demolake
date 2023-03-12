$body = @{application_id= '30d92e31-03d5-4c44-814c-802f1f2602c5'}
Invoke-DatabricksApiRequest -Method "POST" -EndPoint "/2.0/token-management/on-behalf-of/tokens" -Body $body