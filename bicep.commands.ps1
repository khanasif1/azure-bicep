<#
Command to complie and decompile 
ARM --> TO --> Bicep
Bicep --> TO --> ARM
#>
bicep --help
bicep build .\logicapp\template.json
bicep decompile .\logicapp\template.json

<#
Deploy Bicep resources
#>
az deployment group create -f .\logicapp\template.bicep -g rgbicep


<#
looping --> Deploy Bicep resources
#>
az deployment group create -f .\looping\main.bicep  -g rgbicep