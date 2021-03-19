<#
Command to complie and decompile 
ARM --> TO --> Bicep
Bicep --> TO --> ARM
#>
bicep --help
bicep build .\template.json
bicep decompile .\template.json

<#Deploy Bicep resources#>
az deployment group create -f .\template.bicep -g rgbicep