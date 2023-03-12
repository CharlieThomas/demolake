param databricksName string
param resourceGroupName string 
param logAnalyticsName string

param workspaceId string = '/subscriptions/83f0ac3f-2fbb-4ae2-9466-9a47162519f7/resourceGroups/${resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/${logAnalyticsName}'

resource dbr 'Microsoft.Databricks/workspaces@2022-04-01-preview' existing = {
  name: databricksName
}

resource dbrdiag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'dbrdiagsettings'
  scope: dbr
  properties: {
    workspaceId: workspaceId
    logAnalyticsDestinationType: 'Dedicated'
    logs: [
      {
       categoryGroup: 'allLogs'
       enabled: true
      }
    ]
  }
}
