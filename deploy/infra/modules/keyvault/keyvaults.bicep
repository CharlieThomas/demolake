param keyvaultName string
param location string

resource keyvault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyvaultName
  location: location
  properties: {
    accessPolicies: [
      {
        objectId: 
      }
    ]
    sku: {
      family: 'A'
      name: 'standard' 
    }
    tenantId: tenant().tenantId 
  }
}
