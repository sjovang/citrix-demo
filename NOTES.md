DC1

az network bastion tunnel --name examplebastion --resource-group RG-Citrix-Network --target-resource-id /subscriptions/da3b3f56-230a-4ed2-998c-d8fc7cab33d6/resourceGroups/RG-ACTIVE-DIRECTORY/providers/Microsoft.Compute/virtualMachines/VM-DC1 --resource-port 3389 --port 13389

az network bastion tunnel --name examplebastion --resource-group RG-Citrix-Network --target-resource-id /subscriptions/da3b3f56-230a-4ed2-998c-d8fc7cab33d6/resourceGroups/RG-CITRIX-CLOUD-CONNECTORS/providers/Microsoft.Compute/virtualMachines/vm-cc-1 --resource-port 3389 --port 13390

$pwd = ConvertTo-Securestring '' -AsPlainText -Force
$c = New-Object -typename System.Management.Automation.PSCredential -argumentlist "demogod",$pwd
add-computer  -domain "ksulab.cloud" -restart -credentials $c

we still have a problem with deleting secrets because the access policy is deleted before the secrets from other modules