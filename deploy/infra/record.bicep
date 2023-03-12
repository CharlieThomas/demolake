resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'malake'
  location: 'westeurope'
  sku: { 
    name: 'Standard_LRS' 
  }
  kind: 'BlobStorage' 
}
