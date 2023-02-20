
param sqlServerName string
param sqlDatabaseName string
param location string
param dbaGroupName string
param dbaGroupSid string


resource sqlserver 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administrators: {
      azureADOnlyAuthentication: true
      principalType: 'Group'
      administratorType: 'ActiveDirectory'
      login: dbaGroupName
      sid: dbaGroupSid
      tenantId: subscription().tenantId
    }
  }
  resource sqldb 'databases' = {
    name: sqlDatabaseName
    location: location
  }
}



