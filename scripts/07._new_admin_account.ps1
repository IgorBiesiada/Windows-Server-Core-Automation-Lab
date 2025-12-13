$Password = ConvertTo-SecureString "YourStrongPassword123!" -AsPlainText -Force
New-ADUser -Name "Igor Admin" `
           -SamAccountName "a-igor" `
           -UserPrincipalName "a-igor@mydomain.com" `
           -AccountPassword $Password `
           -Enabled $true `
           -PasswordNeverExpires $true `
           -Path "OU=ADMINS,DC=mydomain,DC=com"
Add-ADGroupMember -Identity "Domain Admins" -Members "a-igor"
Add-ADGroupMember -Identity "Administrators" -Members "a-igor"