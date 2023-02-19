param keyvaultName string
param secretName string
param location string

@secure()
param secretValue string

resource keyvault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyvaultName
  location: location
  properties: {
    tenantId: tenant().tenantId 
    accessPolicies: [
      {
        objectId: '1fbe13e2-153d-428c-84db-dde02371526c'
        tenantId: tenant().tenantId 
        permissions: {
          secrets: ['list', 'get']
          keys: ['list', 'get']
        }
      }
    ]
    sku: {
      family: 'A'
      name: 'standard' 
    }
  }
  resource secret 'secrets' = {
    name: secretName
    properties: {
      value: secretValue
    }
  }
}

