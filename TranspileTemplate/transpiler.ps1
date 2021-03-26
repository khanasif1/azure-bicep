<#
Command to complie and decompile 
ARM --> TO --> Bicep
Bicep --> TO --> ARM
#>
bicep --help
bicep build .\TranspileTemplate\template.json
bicep decompile .\TranspileTemplate\template.bicep
