
param sqlServerName string
param sqlDatabaseName string
param location string
param dbaGroupName string
param dbaGroupSid string


param pw string = 'dcad9a44-f9a3-4f07-a76b-2035a5fdc796' 


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



