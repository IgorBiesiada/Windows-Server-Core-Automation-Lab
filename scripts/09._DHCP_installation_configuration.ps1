Install-WindowsFeature DHCP -IncludeManagementTools
Add-DhcpServerInDC -DnsName "DC01" -IPAddress 172.16.0.1
Add-DhcpServerv4Scope -Name "BiuroLAN" -StartRange 172.16.0.50 -EndRange 172.16.0.200 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -ScopeId 172.16.0.0 -OptionId 3 -Value 172.16.0.1
Set-DhcpServerv4OptionValue -ScopeId 172.16.0.0 -OptionId 6 -Value 172.16.0.1