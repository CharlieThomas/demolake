param location string
param userManagedIdentityName string
param resourceGroupName string
param applicationId string

var subscriptionId = subscription().subscriptionId

resource applicationServicePrincipal 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'createappspscript'
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
    scriptContent: 'result=$(az ad sp create --id ${applicationId}); echo $result | jq -c {appId} > $AZ_SCRIPTS_OUTPUT_PATH'
  }
}

