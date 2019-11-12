# Create public IPs
resource "azurerm_public_ip" "linuxterraformpublicip" {
    name                         = "linuxPublicIP"
    location                     = "australiaeast"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "linuxterraformnsg" {
    name                = "LinuxNetworkSecurityGroup"
    location            = "australiaeast"
    resource_group_name = azurerm_resource_group.myterraformgroup.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Create network interface
resource "azurerm_network_interface" "linuxterraformnic" {
    name                      = "linuxNIC"
    location                  = "australiaeast"
    resource_group_name       = azurerm_resource_group.myterraformgroup.name
    network_security_group_id = azurerm_network_security_group.linuxterraformnsg.id

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.linuxterraformpublicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.myterraformgroup.name
    }
    
    byte_length = 8
}


# Create virtual machine
/*resource "azurerm_virtual_machine" "linuxterraformvm" {
    name                  = "linuxVM"
    location              = "australiaeast"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.linuxterraformnic.id]
    vm_size               = "Standard_B1s"

    storage_os_disk {
        name              = "LinuxOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "myvm"
        admin_username = "azureuser"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSgod1nCJ5zQm7wlhAuNpaJZEwAy3IuA0WMWX2nnIaZ/AQmc5+AiJPmVucmcq9nO7jVLoVy2Ic/XCS048KA0yb6WkJJK93xxU3oJA1xhIpFbGls1aPS3tVpgdnrJE2uq1pb/fk8WjynjJj8tFzFaaQF77RZ5X3eY9MMJQtq1TBZO95V1kffXa7Al69Q9LScPEFsHUXoosJI1dI6HhTK4tav7TMPdjsx+xJp7Ien6+vBrt6U7PgI6v9k3+Ymvpk0HI/dEftizYhAkHTz6NOzQBpTy5TCrSzRHmtGpnOwmw0tdpPP2j8XB/K7syE38htscbNz2vt9bK5HQIbU02KAdap iamro@MAXSURFACEBOOK"
        }
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.bootdiagstorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}
*/
