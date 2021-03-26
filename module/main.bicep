module hubVent 'vnet.bicep' = {
  name: 'hubVentbicep'
  params: {
    vnetname: 'hub-vent'
    addressSpaces: [
      '192.168.0.0/24'
    ]
    subnets: [
      {
        name: 'hubsubnet'
        properties: {
          addressPrefix: '192.168.0.0/25'
        }
      }
    ]
  }
}
module subVent 'vnet.bicep' = {
  name: 'spokeVentbicep'
  params: {
    vnetname: 'sub-vent'
    addressSpaces: [
      '10.0.0.0/24'
    ]
    subnets: [
      {
        name: 'sub1net'
        properties: {
          addressPrefix: '10.0.0.0/25'
        }
      }
    ]
  }
}
