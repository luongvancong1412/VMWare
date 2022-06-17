<h1>Creating a Virtual Machine (VM)<h1>

<h2>Summary</h2>

- [Install a Guest OS in a VM](#install-a-guest-os-in-a-vm)
  - [1. Window Server 2019, 2022](#1-window-server-2019-2022)
    - [Step 1: Pre-Implementation](#step-1-pre-implementation)
    - [Step 2: Implementation Procedure](#step-2-implementation-procedure)
      - [Create a VM as per requirement](#create-a-vm-as-per-requirement)
      - [Install the Guest OS](#install-the-guest-os)
    - [Step 3: Post-Implementation](#step-3-post-implementation)
      - [Power on VM](#power-on-vm)
      - [Install Vmware Tools or Open VM Tools for Linux](#install-vmware-tools-or-open-vm-tools-for-linux)
      - [Change the computure name similar as VM display name](#change-the-computure-name-similar-as-vm-display-name)
      - [Assign IP Address/IP Settings (If required)](#assign-ip-addressip-settings-if-required)
      - [Join the System to Domain (If required)](#join-the-system-to-domain-if-required)
      - [Change the time zone](#change-the-time-zone)
      - [Activate the Guest OS License](#activate-the-guest-os-license)
      - [Disable IE Enhaned Security for Windows Servers](#disable-ie-enhaned-security-for-windows-servers)
      - [Turn off Firewall (Optional)](#turn-off-firewall-optional)
      - [Enable RDP/SSH](#enable-rdpssh)
      - [Test the VM access via RDP/SSH](#test-the-vm-access-via-rdpssh)
      - [Install Project Specific Applications](#install-project-specific-applications)
      - [VM Guest OS hardening](#vm-guest-os-hardening)
      - [Provide the VM details to End user/Customer/Client/Tenant](#provide-the-vm-details-to-end-usercustomerclienttenant)
  - [2. ESXi 7.x](#2-esxi-7x)
- [Install VMware Tools on a VM](#install-vmware-tools-on-a-vm)

# Install a Guest OS in a VM
## 1. Window Server 2019, 2022
### Step 1: Pre-Implementation
Xác định:
|Virtual Machine(VM)|Description|
|:---:|:---:|
|VM Name|VM-App001
|vCPU(s)| 2
|vMem|2 gb| 
|vDisk|vDisk - 1<br>vDisk - 2 (Optional)
|vNIC| 1 Network Card|
|Operating System (OS)| Windows Server 2019|

### Step 2: Implementation Procedure
#### Create a VM as per requirement
#### Install the Guest OS
### Step 3: Post-Implementation
#### Power on VM
#### Install Vmware Tools or Open VM Tools for Linux
#### Change the computure name similar as VM display name
#### Assign IP Address/IP Settings (If required)
#### Join the System to Domain (If required)
#### Change the time zone
#### Activate the Guest OS License
#### Disable IE Enhaned Security for Windows Servers
#### Turn off Firewall (Optional)
#### Enable RDP/SSH
#### Test the VM access via RDP/SSH
#### Install Project Specific Applications
#### VM Guest OS hardening
#### Provide the VM details to End user/Customer/Client/Tenant
## 2. ESXi 7.x

# Install VMware Tools on a VM