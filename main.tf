provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RG" {
  name     = "RG-tftest-14370247382572"
  location = var.location
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "storage3253252"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  resource_group_name      = azurerm_resource_group.RG.name
  location                 = azurerm_resource_group.RG.location
  tags = {
    Deployment = "Terraform"
    Environment = "Røv"
  }
  depends_on = [ azurerm_subscription_policy_assignment.requiretagz ]
}

resource "azurerm_storage_container" "container" {
  name                  = "thisnewcontainer"
  container_access_type = "private"
  storage_account_name  = azurerm_storage_account.storageaccount.name
}

resource "azurerm_storage_share" "fileshare" {
  name                 = "thisnewfileshare"
  quota                = 6
  storage_account_name = azurerm_storage_account.storageaccount.name

}
resource "azurerm_storage_share_file" "file" {
  name             = "thisnewfile"
  source           = "./testResources/text.txt"
  storage_share_id = azurerm_storage_share.fileshare.id
}
