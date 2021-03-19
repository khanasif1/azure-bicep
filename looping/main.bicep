param storageNameArray array = [
  'storage1asif786'
  'storage2asif786'
  'storage3asif786'
]

resource asifbicepstorage08032021_asifkhan 'Microsoft.Storage/storageAccounts@2019-06-01' = [for store in storageNameArray: {
  name: '${store}'
  location: 'australiaeast'
  kind: 'Storage'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}]