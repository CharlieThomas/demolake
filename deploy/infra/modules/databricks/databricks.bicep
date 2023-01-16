param dataBricksName string
param location string

resource dataBricks 'Microsoft.Databricks/workspaces@2022-04-01-preview' = {
  name: dataBricksName
  location: location
  properties: {
    managedResourceGroupId: replace(resourceGroup().id, '-rg', '-dbr-managed-rg')
  }
}

