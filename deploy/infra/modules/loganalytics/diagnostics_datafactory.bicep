param datafactoryName string
param workspaceId string = '/subscriptions/83f0ac3f-2fbb-4ae2-9466-9a47162519f7/resourceGroups/demolake-dev-rg/providers/Microsoft.OperationalInsights/workspaces/demolake-dev-la'

resource adf 'Microsoft.DataFactory/factories@2018-06-01' existing = {
  name: datafactoryName
}

resource adfdiag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'adfdiagsettings'
  scope: adf
  properties: {
    workspaceId: workspaceId
    logAnalyticsDestinationType: 'Dedicated'
    logs: [
      {
       categoryGroup: 'allLogs'
       enabled: true
      }
    ]
    metrics: [
      {
        category: 'allMetrics'
        enabled: true
      }
    ]
  }
}
