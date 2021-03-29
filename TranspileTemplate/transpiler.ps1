<#
Command to complie and decompile 
ARM --> TO --> Bicep
Bicep --> TO --> ARM
#>
bicep --help
bicep build .\TranspileTemplate\template.bicep
bicep decompile .\TranspileTemplate\template.json

<#
Deploy transpiled template
#>
az deployment group create -f .\TranspileTemplate\template.bicep  -g rgbicep