param environmentName string = 'dev'
param location string = resourceGroup().location

param storageContainerNames array = [
  'raw'
  'base'
  'curated'
]

var uniquePostfix = uniqueString(resourceGroup().id)
var namePrefix = 'demolake-${environmentName}-'

var storageAccountName = take('${replace(namePrefix, '-', '')}${uniquePostfix}', 24)
var dataFactoryName = take('${namePrefix}adf-${uniquePostfix}', 24)
var dataBricksName = '${namePrefix}dbr'
/*
var synapseName = '${namePrefix}syn'
*/
var keyvaultName = take('${namePrefix}kv-${uniquePostfix}',24)
var userManagedIdentityName = 'github-demolake-msi'
var applicationName = '${namePrefix}app'
var sqlServerName = take('${namePrefix}svr-${uniquePostfix}', 24)
var sqlDatabaseName = '${namePrefix}db'
var logAnalyticsName = '${namePrefix}log'

var dbaGroupName = 'demolake-dev-group'
var dbaGroupSid = 'dcad9a44-f9a3-4f07-a76b-2035a5fdc796'

module logAnalytics 'modules/loganalytics/loganalytics.bicep' = {
  name: 'logAnalyticsModule'
  params: {
    location: location
    logAnalyticsName: logAnalyticsName
  }
}

module storageAccount 'modules/storage/storageAccounts.bicep' = {
  name: 'storageAccountModule'
  params: {
    location: location
    storageAccountName: storageAccountName
    storageContainerNames: storageContainerNames
  }
}

module dataFactory 'modules/datafactory/dataFactories.bicep' = {
  name: 'dataFactoryModule'
  params: {
    dataFactoryName: dataFactoryName
    location: location
  }
}

module dataBricks 'modules/databricks/databricks.bicep' = {
  name: 'dataBricksModule'
  params: {
    dataBricksName: dataBricksName
    location: location
  }
}

/*
module synapse 'modules/synapse/synapse.bicep' = {
  name: 'synapseModule'
  params: {
    dfsEndpoint: storageAccount.outputs.dfsEndpoint
    location: location
    synapseName: synapseName
  }
}
*/

module storageAccountRbacDataFactory 'modules/storage/storageAccount-rbac.bicep' = {
  name: 'storageAccountRbacDataFactoryModule'
  dependsOn: [
    storageAccount
    dataFactory
  ]
  params: {
    principalId: dataFactory.outputs.managedIdentity 
    storageAccountName: storageAccount.outputs.name
    role: 'storageBlobDataContributor'
  }
}


module applicationRegistration 'modules/application/applicationRegistrations.bicep' = {
  name: 'applicationRegistrationModule'
  scope: resourceGroup('github-actions-rg')
  params: {
    applicationName: applicationName
    location: location
    resourceGroupName: 'github-actions-rg'
    userManagedIdentityName: userManagedIdentityName
  }
}

module applicationCredential 'modules/application/applicationCredentials.bicep' = {
  name: 'aplicationCredentialModule'
  scope: resourceGroup('github-actions-rg')
  dependsOn: [
    applicationRegistration
  ]
  params: {
    location: location
    userManagedIdentityName: userManagedIdentityName
    applicationId: applicationRegistration.outputs.applicationId
    resourceGroupName: 'github-actions-rg'
  }
}

module keyVault 'modules/keyvault/keyvaults.bicep' = {
  name: 'keyvaultModule'
  dependsOn: [
    applicationCredential
  ]
  params: {
    keyvaultName: keyvaultName
    location: location
    secretName: 'applicationkey'
    secretValue: applicationCredential.outputs.applicationpassword
  }
}

module sqlserver 'modules/sqldb/sqldb.bicep' = {
  name: 'sqlservermodule'
  params: {
    dbaGroupName: dbaGroupName
    dbaGroupSid: dbaGroupSid
    location: location
    sqlDatabaseName: sqlDatabaseName
    sqlServerName: sqlServerName
  }
}

module adfdiag 'modules/loganalytics/diagnostics_datafactory.bicep' = {
  name: 'adfdiagmodule'
  dependsOn: [
    dataFactory
  ]
  params: {
    datafactoryName: dataFactoryName
    resourceGroupName: resourceGroup().name
    logAnalyticsName: logAnalyticsName
  }
}

module dbrdiag 'modules/loganalytics/diagnostics_databricks.bicep' = {
  name: 'dbrdiagmodule'
  dependsOn: [
    dataBricks
  ]
  params: {
    databricksName: dataBricksName
    resourceGroupName: resourceGroup().name
    logAnalyticsName: logAnalyticsName
  }
}

output appid string = applicationRegistration.outputs.applicationId
output databricksName string = dataBricksName
output datafactoryName string = dataFactoryName

