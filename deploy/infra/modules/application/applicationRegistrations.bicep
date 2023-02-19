param location string
param userManagedIdentityName string
param resourceGroupName string
param applicationName string

var subscriptionId = subscription().subscriptionId

resource applicationRegistration 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
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
    scriptContent: 'result=$(az ad app create --display-name ${applicationName}); echo $result | jq -c {appId} > $AZ_SCRIPTS_OUTPUT_PATH'
  }
}

output applicationId string = applicationRegistration.properties.outputs.appId
