# 🏗️ Windows Server Core - Active Directory Home Lab

![Windows Server](https://img.shields.io/badge/OS-Windows%20Server%20Core-blue) ![PowerShell](https://img.shields.io/badge/Scripting-PowerShell-yellow) ![VirtualBox](https://img.shields.io/badge/Virtualization-VirtualBox-orange)

## 🎯 Project Overview
This project documents the deployment of a complete **Active Directory Domain Services (AD DS)** environment using **Windows Server Core** (headless version).

The main objective is to simulate a real-world enterprise scenario where server resources are optimized, and management is performed primarily via **PowerShell** and **CLI**, rather than the GUI. This project focuses on automation and "Infrastructure as Code" principles.

### 🛠️ Tech Stack
* **Hypervisor:** Oracle VirtualBox
* **Operating System:** Windows Server 2022 Core
* **Tools:** PowerShell, SConfig

---

## ⚙️ Configuration Log

Below are the initial steps taken to provision the server.

### 1. Network Interface Management
The first step was to inspect and organize the network interfaces. I needed to distinguish between the NAT adapter (Internet access) and the Internal adapter (Lab network).

I used PowerShell to list the adapters, identify them by IP/MAC, and assign descriptive names.

**PowerShell Command:**
```powershell
# 1. Inspect current network adapters (to identify NAT vs Internal)
Get-NetAdapter

# 2. Rename the NAT adapter (Internet Access)
Rename-NetAdapter -Name "Ethernet" -NewName "Internet"

# 3. Rename the Internal Network adapter (Lab Environment)
Rename-NetAdapter -Name "Ethernet 2" -NewName "LAN"

# 4. Verify the new configuration
Get-NetAdapter
```
![Network Adapters Config](screenshots/01_adapters.png)

The second step was to configured the internal network adapter (`LAN`) with a static IPv4 address and set the DNS server to localhost (Loopback). This is a critical step for promoting the server to a Domain Controller.

* **IP Address:** `172.16.0.1`
* **Subnet Mask:** `255.255.255.0` (/24)
* **DNS Server:** `127.0.0.1`

**PowerShell Command:**
```powershell
#1. setting ip and mask
New-NetIPAddress -IPAddress "172.16.0.1" -InterfaceAlias "LAN" -PrefixLength 24
```
![New adapter ip](screenshots/02_ipadapter.png)

**PowerShell Command:**
```powershell
#1. setting DNS
Set-DnsClientServerAddress -InterfaceAlias "LAN" -ServerAddresses ("127.0.0.1")
```

![DNS ip](screenshots/03_dns.png)

### 2. Changing the hostname
I renamed the server to follow a standard naming convention (DC01) to ensure easy identification and management within the network infrastructure.

**PowerShell Command:**
```powershell
#1. Rename computer and force restart
Rename-Computer -NewName "DC01" -Restart
```
## After restart host name is DC01

![Hostname](screenshots/04_hostname.png)

### 4. Active Directory Deployment (Domain Controller)
I installed the Active Directory Domain Services (AD DS) role and promoted the server to a Domain Controller, establishing a new forest named `mydomain.com.local`.

**PowerShell Commands:**
```powershell
# 1. Install AD DS Role and Management Tools
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# 2. Promote Server to Domain Controller (Create New Forest)
# Note: You will be prompted for the Safe Mode Administrator Password
Install-ADDSForest -DomainName "mydomain.com" -InstallDns
```

![domain_service_installation](screenshots/05_AD_domain_services.png)

![domain_name](screenshots/06_mydomain.png)

### 5. Post-Deployment User Security
To enhance security and follow best practices, I moved away from using the default built-in `Administrator` account. I created a personalized administrative user and granted it elevated privileges by adding it to the **Domain Admins** group.