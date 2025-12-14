Install-WindowsFeature Routing
New-NetNat -Name "LabNAT" -InternalIPInterfaceAddressPrefix "172.16.0.0/24"