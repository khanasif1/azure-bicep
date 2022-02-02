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
module spokeVent 'vnet.bicep' = {
  name: 'spokeVentbicep'
  params: {
    vnetname: 'spoke-vent'
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
module HubToSpokePeering 'peering.bicep' = {
  name: 'hub-to-spoke-peering'
  params: {
    localVnetName: hubVent.outputs.name
    remoteVnetName: 'spoke-vent'
    remoteVnetId: spokeVent.outputs.id
  }
}
