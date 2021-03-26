<#
Deploy Bicep resources
#>
az deployment group create -f .\main.bicep -g rgbicep


<#
looping --> Deploy Bicep resources
#>
az deployment group create -f .\looping\main.bicep  -g rgbicep

<#
module deployment - vnet
#>
az deployment group create -f .\module\main.bicep  -g rgbicep
