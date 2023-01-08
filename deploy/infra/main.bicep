param environmentName string = 'dev'
param location string = resourceGroup().location

param storageContainerNames array = [
  'raw'
  'base'
  'curated'
]

var uniquePostfix = uniqueString(resourceGroup().id)
var namePrefix = 'demolake-${environmentName}-'

var storageAccountName = '${take(replace(namePrefix, '-', ''), 24)}${uniquePostfix}'
var dataFactoryName = '${namePrefix}adf'
var dataBricksName = '${namePrefix}dbr'
var synapseName = '${namePrefix}syn'

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

module synapse 'modules/synapse/synapse.bicep' = {
  name: 'synapseModule'
  params: {
    dfsEndpoint: storageAccount.outputs.dfsEndpoint
    location: location
    synapseName: synapseName
  }
}
