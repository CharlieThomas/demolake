param storageAccountName string
param location string
param storageContainerNames array

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true
  }

  resource blobStorage 'blobServices' = {
    name: 'default'
    resource containers 'containers' = [for containerName in storageContainerNames: {
      name: containerName
    }]
  }
}

output resourceId string = storageAccount.id
output name string = storageAccount.name
output dfsEndpoint string = storageAccount.properties.primaryEndpoints.dfs
