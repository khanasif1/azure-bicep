resource asifbicepAlintaDemo 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'alintastoragedemobicep'
  location: 'australiaeast'
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}
