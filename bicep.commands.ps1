<#
Deploy Bicep resources
#>
az deployment group create -f .\gen_main.bicep -g rgbicep


<#
looping --> Deploy Bicep resources
#>
az deployment group create -f .\looping\loop_main.bicep  -g rgbicep

<#
module deployment - vnet
#>
az deployment group create -f .\module\module_main.bicep  -g rgbicep
