param environmentName string = 'dev'
param location string = resourceGroup().location

param storageContainerNames array = [
  'raw'
  'base'
  'curated'
]

var uniquePostfix = uniqueString(resourceGroup().id)
var namePrefix = 'demolake-${environmentName}-'
var storageAccountName = '${take(replace(namePrefix, '-', ''), 24)}${uniquePostfix}'

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
