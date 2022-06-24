<h1>Tạo máy ảo (Virtual Machine - VM) thời gian thực <h1>

<h2>Summary</h2>

- [Cài đặt một Guest OS trên VM](#cài-đặt-một-guest-os-trên-vm)
  - [1. Window Server 2019, 2022](#1-window-server-2019-2022)
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
    - [Step 1: Pre-Implementation](#step-1-pre-implementation)
    - [Step 2: Implementation Procedure](#step-2-implementation-procedure)
      - [Create a VM as per requirement](#create-a-vm-as-per-requirement)
      - [Install the Guest OS](#install-the-guest-os)
    - [Step 3: Post-Implementation](#step-3-post-implementation-1)
      - [Power on VM](#power-on-vm-1)
      - [Install Vmware Tools or Open VM Tools for Linux](#install-vmware-tools-or-open-vm-tools-for-linux-1)
      - [Change the computure name similar as VM display name](#change-the-computure-name-similar-as-vm-display-name-1)
      - [Assign IP Address/IP Settings (If required)](#assign-ip-addressip-settings-if-required-1)
      - [Join the System to Domain (If required)](#join-the-system-to-domain-if-required-1)
      - [Change the time zone](#change-the-time-zone-1)
      - [Activate the Guest OS License](#activate-the-guest-os-license-1)
      - [Disable IE Enhaned Security for Windows Servers](#disable-ie-enhaned-security-for-windows-servers-1)
      - [Turn off Firewall (Optional)](#turn-off-firewall-optional-1)
      - [Enable RDP/SSH](#enable-rdpssh-1)
      - [Test the VM access via RDP/SSH](#test-the-vm-access-via-rdpssh-1)
      - [Install Project Specific Applications](#install-project-specific-applications-1)
      - [VM Guest OS hardening](#vm-guest-os-hardening-1)
      - [Provide the VM details to End user/Customer/Client/Tenant](#provide-the-vm-details-to-end-usercustomerclienttenant-1)
- [Install VMware Tools on a VM](#install-vmware-tools-on-a-vm)

# Cài đặt một Guest OS trên VM
## 1. Window Server 2019, 2022
<h3> Step 1: Pre-Implementation - Trước triển khai</h3>
Xác định yêu cầu của khách hàng:
|Virtual Machine(VM)|Description|
|:---:|:---:|
|VM Name|VM-App001
|vCPU(s)| 2
|vMem|2 gb| 
|vDisk - 1| 40 gb
|vDisk - 2(Optional)
|vNIC| 1 Network Card|
|Operating System (OS)| Windows Server 2019|

<h3> Step 2: Implementation Procedure - Quy trình thực hiện</h3>

<h4>Step 2.1:Tạo một máy ảo (VM) theo yêu cầu</h4>

Thực hiện trong môi trường VMware workstation
- Tạo máy ảo mới, chọn `Custom > Next` và làm theo hướng dẫn

![Imgur](https://i.imgur.com/PhbSFW0.png)
- Đặt kích thước Disk, nên chọn `Store virtual disk as a single file`

![Imgur](https://i.imgur.com/Fu1wvwU.png)
- Thêm ISO image windows server 2019:

![Imgur](https://i.imgur.com/OP0B984.png)

<h4> Cài đặt Guest OS </h4>

![Imgur](https://i.imgur.com/CxIayQv.png)
![Imgur](https://i.imgur.com/6ADy86a.png)
![Imgur](https://i.imgur.com/fKA4HDF.png)
![Imgur](https://i.imgur.com/Bdn6PnT.png)
![Imgur](https://i.imgur.com/cppCRUQ.png)
![Imgur](https://i.imgur.com/NVvANgM.png)
![Imgur](https://i.imgur.com/1OuDuNW.png)
### Step 3: Post-Implementation
#### Power on VM
#### Install Vmware Tools or Open VM Tools for Linux
![Imgur](https://i.imgur.com/1HiTS1G.png)
![Imgur](https://i.imgur.com/qg4dZC7.png)
![Imgur](https://i.imgur.com/VqGGPZZ.png)
![Imgur](https://i.imgur.com/XKm6SzJ.png)
#### Change the computure name similar as VM display name
![Imgur](https://i.imgur.com/l0VdJsg.png)
![Imgur](https://i.imgur.com/xYVNafk.png)
![Imgur](https://i.imgur.com/MNKmmXg.png)
![Imgur](https://i.imgur.com/3OKWG0d.png)
![Imgur](https://i.imgur.com/kJFamJ6.png)

> Thêm Disk
![Imgur](https://i.imgur.com/Xxoy0Ti.png)
![Imgur](https://i.imgur.com/UmVR4sD.png)
![Imgur](https://i.imgur.com/ShOo1eF.png)
![Imgur](https://i.imgur.com/eb6OEYO.png)
![Imgur](https://i.imgur.com/mMh3tut.png)
![Imgur](https://i.imgur.com/0CSu9d0.png)
![Imgur](https://i.imgur.com/XyjRQDP.png)
![Imgur](https://i.imgur.com/7Zrn7UL.png)
![Imgur](https://i.imgur.com/uDkQ7mx.png)
![Imgur](https://i.imgur.com/MsmGtKK.png)
> Tạo phân vùng mới
![Imgur](https://i.imgur.com/oHA5BGN.png)
![Imgur](https://i.imgur.com/CTEYgRT.png)
![Imgur](https://i.imgur.com/UZR8A3H.png)
![Imgur](https://i.imgur.com/yLyVEwS.png)
![Imgur](https://i.imgur.com/phTtZZx.png)
![Imgur](https://i.imgur.com/a1ddQ7j.png)
![Imgur](https://i.imgur.com/wDFyTTy.png)

#### Assign IP Address/IP Settings (If required)
#### Join the System to Domain (If required)
#### Change the time zone
![Imgur](https://i.imgur.com/l2o8Xiv.png)
![Imgur](https://i.imgur.com/yol6ffH.png)
![Imgur](https://i.imgur.com/jfdvREr.png)
![Imgur](https://i.imgur.com/WZTSxom.png)
#### Activate the Guest OS License
#### Disable IE Enhaned Security for Windows Servers
![Imgur](https://i.imgur.com/WkYQFmi.png)
#### Turn off Firewall (Optional)
#### Enable RDP/SSH
![Imgur](https://i.imgur.com/wxaS9Ey.png)
![Imgur](https://i.imgur.com/li1vxhG.png)
#### Test the VM access via RDP/SSH
![Imgur](https://i.imgur.com/3ejFNzb.png)
![Imgur](https://i.imgur.com/bLTKmUf.png)
![Imgur](https://i.imgur.com/rP0IovV.png)
![Imgur](https://i.imgur.com/k1wLuGN.png)
![Imgur](https://i.imgur.com/Y6kZDYE.png)
![Imgur](https://i.imgur.com/TuypZnM.png)
#### Install Project Specific Applications
#### VM Guest OS hardening
#### Provide the VM details to End user/Customer/Client/Tenant
## 2. ESXi 7.x
### Step 1: Pre-Implementation
Xác định:
|Virtual Machine(VM)|Description|
|:---:|:---:|
|VM Name|VM-ESXi7
|vCPU(s)|2
|vMem|4 gb|
|vDisk - 1|40 gb
|vDisk - 2(Optional)
|vNIC|1 |
|Operating System (OS)|ESXi 7.0.3 |

### Step 2: Implementation Procedure
#### Create a VM as per requirement

#### Install the Guest OS
![Imgur](https://i.imgur.com/CjnfyP1.png)
![Imgur](https://i.imgur.com/tmWUIpm.png)
![Imgur](https://i.imgur.com/HeJEZxv.png)
![Imgur](https://i.imgur.com/qzw7AwM.png)
![Imgur](https://i.imgur.com/s3j3dpF.png)
![Imgur](https://i.imgur.com/eIqqbnt.png)
![Imgur](https://i.imgur.com/eVEX3lk.png)
![Imgur](https://i.imgur.com/T5U8T6T.png)
![Imgur](https://i.imgur.com/XlNsOLp.png)
![Imgur](https://i.imgur.com/1Tg6aZN.png)
![Imgur](https://i.imgur.com/lgj7yN8.png)
![Imgur](https://i.imgur.com/Sf01bmh.png)
![Imgur](https://i.imgur.com/xFszzkH.png)
![Imgur](https://i.imgur.com/lJS8pmQ.png)
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
# Install VMware Tools on a VM