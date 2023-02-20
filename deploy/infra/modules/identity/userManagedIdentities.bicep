param userAssignedIdentityName string
param identityResourceGroupName string

resource msi 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name: userAssignedIdentityName
  scope: resourceGroup(identityResourceGroupName)
}

output msdId string = msi.properties.
