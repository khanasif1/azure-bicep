resource asifbicepstorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'asifbicepstorage'
  location: 'australiaeast'
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}