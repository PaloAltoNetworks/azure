# VM-Series Simple Template

This ARM template deploys a VM-Series next generation firewall VM in an Azure resource group. It lets you select your:

- Resource Group and Storage Account inside it
- VNET's CIDR (/16 range) with 4 subnets: Mgmt (0.0/24), Untrust (1.0/24), Trust (2.0/24), and DMZ (3.0/24)
- Azure VM size and login for VM-Series (BYOL edition) with 4 NIC's that map to above subnets

This template is meant to let you do customized deployments of VM-Series instead of deploying from the Azure Marketplace. You can deploy using the "Deploy to Azure" button below or download the template and customize it to your needs. You can also fork the templates into your own GitHub repository.

[<img src="http://azuredeploy.net/deploybutton.png"/>](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Falpai%2Fazure%2Fmaster%2Fvmseries-simple-template%2FazureDeploy.json)
[<img src="https://camo.githubusercontent.com/536ab4f9bc823c2e0ce72fb610aafda57d8c6c12/687474703a2f2f61726d76697a2e696f2f76697375616c697a65627574746f6e2e706e67" data-canonical-src="http://armviz.io/visualizebutton.png" style="max-width:100%;">](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Falpai%2Fazure%2Fmaster%2Fvmseries-simple-template%2FazureDeploy.json)


## Deploy ARM Template using Azure CLI in ARM mode

1. Download the two JSON files: azureDeploy.json and azureDeploy.parameters.json
1. Customize the azureDeploy.parameters.json file and then deploy it from your computer.
1. Install the latest <a href="https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-install/">Azure CLI</a> for your computer.</li>
1. Validate and deploy the ARM template:

``` azure
    azure login
    azure config mode arm
    azure  group  template  validate  -g YourResourceGroupName \
        -e  azureDeploy.json   -f  azureDeploy.parameters.json
    azure group create -v -n YourResourceGroupName -l YourAzureRegion  \
        -d  YourDeploymentLabel  -f azureDeploy.json -e azureDeploy.parameters.json
```

**Check the status of your deployment:**

- CLI: `azure vm show  -g YourResourceGroupName  -n YourDeploymentLabel`
- Azure Portal: Your Resource Group > Deployment or Alert Logs


If you are creating customized ARM templates you can use the following information to deploy VM-Series:

- Publisher name: paloaltonetworks
- Offer: vmseries1
- SKU: byol or bundle1 or bundle2
- Version: 7.1.0 or latest (recommended)
