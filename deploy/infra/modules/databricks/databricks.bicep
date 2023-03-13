param dataBricksName string
param location string

var managedResourceGroupId = replace(resourceGroup().id, '-rg', '-dbr-managed-rg')

resource dataBricks 'Microsoft.Databricks/workspaces@2022-04-01-preview' = {
  name: dataBricksName
  location: location
  properties: {
    #disable-next-line use-resource-id-functions
    managedResourceGroupId: managedResourceGroupId
  }
}

