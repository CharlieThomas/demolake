
@description('Generated from /subscriptions/83f0ac3f-2fbb-4ae2-9466-9a47162519f7/resourceGroups/demolake-dev-rg/providers/Microsoft.Sql/servers/demolake-dev-svr/databases/demolake-dev-db')
resource demolakedevdb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  sku: {
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 34359738368
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    licenseType: 'LicenseIncluded'
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    maintenanceConfigurationId: '/subscriptions/83f0ac3f-2fbb-4ae2-9466-9a47162519f7/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
  }
  location: 'westeurope'
  name: 'demolake-dev-svr/demolake-dev-db'
}
