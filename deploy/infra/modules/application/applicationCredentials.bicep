param location string
param userManagedIdentityName string

var subscriptionId = subscription().subscriptionId

resource createapp 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createappscript'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/${subscriptionId}/resourcegroups/demolake-dev-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${userManagedIdentityName}': {}
    }
  }
  properties: {
    azCliVersion: '2.37.0'
    retentionInterval: 'P1D'
    scriptContent: 'result=$(az ad app credential reset --id e0814929-6b10-45f1-8c83-216fd296bc2e); echo $result > $AZ_SCRIPTS_OUTPUT_PATH'
  }
}

output appregoutput string = createapp.properties.outputs.appId
