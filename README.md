# azure_aaa


```bash

# publicにしたくなくて、privateでインスタンスを閉じたいならあり。
# aci-vnet, aci-subnetも一緒に作成される。
az container create \
  --name appcontainer \
  --resource-group resascsharp_group \
  --image mcr.microsoft.com/azuredocs/aci-helloworld \
  --vnet aci-vnet \
  --vnet-address-prefix 10.0.0.0/16 \
  --subnet aci-subnet \
  --subnet-address-prefix 10.0.0.0/24
```
