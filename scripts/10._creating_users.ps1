"firstName,lastName","Piotr,Pierzak","Marek,Admin","Jan,Testowy" | Set-Content C:\Users\a-igor\users.csv

$pass = ConvertTo-SecureString "Password123!" -AsPlainText -Force

Import-Csv "C:\Users\a-igor\users.csv" | ForEach-Object {
    $samAccount = ($_.firstName + "." + $_.lastName).ToLower()
    New-ADUser -Name "$($_.firstName) $($_.lastName)" `
               -SamAccountName $samAccount `
               -UserPrincipalName "$samAccount@mydomain.com" `
               -GivenName $_.firstName `
               -Surname $_.lastName `
               -AccountPassword $pass `
               -Enabled $true `
               -Path "CN=Users,DC=mydomain,DC=com"
}