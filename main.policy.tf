##
## POLICIES
##

resource "azurerm_subscription_policy_assignment" "requiretagz" {
  name                 = "imassigningthisnow"
  subscription_id      = var.subscriptionID
  policy_definition_id = azurerm_policy_set_definition.Initiative.id
  description          = "This is my first assignment using terraform huhuuu"
  display_name         = "I'm assigning this now shut up"
}

resource "azurerm_policy_set_definition" "Initiative" {
  name         = "mynewinitiative"
  display_name = "My Newest Initiative"
  description  = "Descriptioøøøøn"
  policy_type  = "Custom"

  policy_definition_reference {
    # Require a tag and its value on resources (not including resource groups)
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62"
    parameter_values = jsonencode({
      tagName  = { value : "Deployment" },
      tagValue = { value : "Terraform" }

    })
  }
}
