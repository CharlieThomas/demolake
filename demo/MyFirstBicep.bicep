param location string = resourceGroup().location

resource myFirstStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'myfirststorage23442'
  location: location
  sku: {
    name: 'Standard_LRS' 
  }
  kind: 'StorageV2' 
}
