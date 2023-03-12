param dataBricksName string
param location string

#disable-next-line use-resoure-id-functions
var managedResourceGroupId = replace(resourceGroup().id, '-rg', '-dbr-managed-rg')

resource dataBricks 'Microsoft.Databricks/workspaces@2022-04-01-preview' = {
  name: dataBricksName
  location: location
  properties: {
    managedResourceGroupId: managedResourceGroupId
  }
}

