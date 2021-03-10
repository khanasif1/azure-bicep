resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'asifbicepstorage08032021'
  location:'australiaeast'
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}