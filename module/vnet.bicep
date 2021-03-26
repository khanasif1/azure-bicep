param vnetname string
param addressSpaces array
param subnets array

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: '${vnetname}'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: addressSpaces
    }
    subnets: subnets
  }
}
output name string = vnet.name
output id string = vnet.id
