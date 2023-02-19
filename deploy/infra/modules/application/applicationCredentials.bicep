param location string
param userManagedIdentityName string
param resourceGroupName string
param applicationId string

var subscriptionId = subscription().subscriptionId

resource applicationCredential 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createappscript'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/${subscriptionId}/resourcegroups/${resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${userManagedIdentityName}': {}
    }
  }
  properties: {
    azCliVersion: '2.37.0'
    retentionInterval: 'P1D'
    arguments: '\'${applicationId}\''
    scriptContent: 'result=$(az ad app credential reset --id ${applicationId}); echo $result > $AZ_SCRIPTS_OUTPUT_PATH'
  }
}

#disable-next-line outputs-should-not-contain-secrets // Getting the password to put into keyvault
output applicationpassword string = applicationCredential.properties.outputs.password
