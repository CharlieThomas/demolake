param synapseName string
param location string
param dfsEndpoint string


resource synapse 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: synapseName
  location: location
  properties: {
    defaultDataLakeStorage: {
      accountUrl: dfsEndpoint
      filesystem: 'curated'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
