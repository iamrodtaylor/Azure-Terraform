// NOTE: this is a hack.
// the AD Domain takes ~3m to provision, so we don't try and join an non-existant domain we sleep
// unfortunately we can't depend on the Domain Creation VM Extension since there's a reboot.
// We sleep for 7 minutes here to give Azure some breathing room.
resource "null_resource" "wait-for-domain-to-provision" {
  provisioner "local-exec" {
    #Use Start-Sleep if running Terraform in Powershell
    command = "Start-Sleep 420"
    interpreter = ["PowerShell", "-Command"]

    #Use sleep if running Terraform in bash
    #command = "sleep 420" 
  }

  depends_on = ["azurerm_virtual_machine.client"]
}
