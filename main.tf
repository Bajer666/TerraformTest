provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "RG" {
    name = "RG-tftest-14370247382572"
    location = var.location 
}

resource "azurerm_storage_account" "storageaccount" {
    name = "storage3253252"
    resource_group_name =       azurerm_resource_group.RG.name
    location =                  azurerm_resource_group.RG.location
    account_replication_type =  "LRS"
    account_tier =              "Standard"
}

resource "azurerm_storage_container" "container" {
    name = "thisnewcontainer"
    storage_account_name = azurerm_storage_account.storageaccount.name
    container_access_type = "private"
}

resource "azurerm_storage_share" "fileshare" {
    name =                  "thisnewfileshare"
    storage_account_name =  azulrerm_storage_accoubnt.storageaccount.name
    quota =                 6
}
resource "azurerm_storage_share_file" "file" {
    name =                  "thisnewfile"
    storage_share_id =      azurerm_storage_share.fileshare.id
    source =                "./testResources/text.txt"
}