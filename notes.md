Powershell - Set environment variable called ARM_ACCESS_KEY via querying the key
The build.tf file references the state file "terraform.tfstate" in Azure and terraform knows how to query it using this ARM_ACCESS_KEY
$env:ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name rodkeyvault --query value -o tsv)

