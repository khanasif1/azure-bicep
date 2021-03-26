# Azure Bicep
I have build this repository to explore Azure Bicep. I have tried to build some sample to demistify Azure Bicep.

<img src="https://github.com/khanasif1/azure-bicep/blob/main/image/bicep.jpg" alt="bicep" height="300">

# How to use repo...

## Install bicep

- Firstly we need to install bicep CLI. Use file *[installbicept.ps1](https://github.com/khanasif1/azure-bicep/blob/main/installbicept.ps1)
- Sample can be executed using  *[bicep.commands.ps1](https://github.com/khanasif1/azure-bicep/blob/main/bicep.commands.ps1) . Sample which are available are as below:
  - Using looping with bicep
  - Build bicep samples in modular fashion
  - Transpile bicep to ARM and vice-versa


# Looping
<img src="https://github.com/khanasif1/azure-bicep/blob/main/image/looping.png" alt="loop" height="30">

  Looping folder has main file. Looping needs an array data to loop on. The file can be executed using script below:
```powershell
az deployment group create -f .\looping\main.bicep  -g rgbicep
```


<img src="https://github.com/khanasif1/azure-bicep/blob/main/image/module.png" alt="loop" height="50">

<img src="https://github.com/khanasif1/azure-bicep/blob/main/image/transpile.png" alt="loop" height="50">

