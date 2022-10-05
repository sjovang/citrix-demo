DC1

az network bastion tunnel --name examplebastion --resource-group RG-Citrix-Network --target-resource-id /subscriptions/da3b3f56-230a-4ed2-998c-d8fc7cab33d6/resourceGroups/RG-ACTIVE-DIRECTORY/providers/Microsoft.Compute/virtualMachines/VM-DC1 --resource-port 3389 --port 13389