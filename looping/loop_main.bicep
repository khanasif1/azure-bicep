param storageNameArray array = [
  'storage1asif7777'
  'storage2asif8888'
  'storage3asif9999'
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
