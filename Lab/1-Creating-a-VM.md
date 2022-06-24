<h1>Tạo máy ảo (Virtual Machine - VM) thời gian thực <h1>

<h2>Summary</h2>

- [Cài đặt một Guest OS trên VM](#cài-đặt-một-guest-os-trên-vm)
  - [1. Window Server 2019, 2022](#1-window-server-2019-2022)
    - [Step 1: Pre-Implementation - Trước triển khai](#step-1-pre-implementation---trước-triển-khai)
    - [Step 2: Implementation Procedure - Quy trình thực hiện](#step-2-implementation-procedure---quy-trình-thực-hiện)
    - [Step 3: Post-Implementation - Sau khi cài đặt](#step-3-post-implementation---sau-khi-cài-đặt)
  - [2. ESXi 7.x](#2-esxi-7x)
    - [Step 1: Pre-Implementation](#step-1-pre-implementation)
    - [Step 2: Implementation Procedure](#step-2-implementation-procedure)
    - [Step 3: Post-Implementation](#step-3-post-implementation)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

# Cài đặt một Guest OS trên VM
## 1. Window Server 2019, 2022
### Step 1: Pre-Implementation - Trước triển khai

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

### Step 2: Implementation Procedure - Quy trình thực hiện

<h4>Step 2.1:Tạo một máy ảo (VM) theo yêu cầu</h4>

Thực hiện trong môi trường VMware workstation
- Tạo máy ảo mới, chọn `Custom > Next` và làm theo hướng dẫn

![Imgur](https://i.imgur.com/PhbSFW0.png)
- Đặt kích thước Disk, nên chọn `Store virtual disk as a single file`

![Imgur](https://i.imgur.com/Fu1wvwU.png)
- Thêm ISO image windows server 2019:

![Imgur](https://i.imgur.com/OP0B984.png)

<h4> Step 2.2: Cài đặt Guest OS </h4>

- Để mặc định, chọn Next để tiếp tục

![Imgur](https://i.imgur.com/CxIayQv.png)
- Chọn Install Now

![Imgur](https://i.imgur.com/6ADy86a.png)

- Chọn phiên bản OS muốn cài đặt

![Imgur](https://i.imgur.com/fKA4HDF.png)

- Click `I accept the license terms` và chọn Next để tiếp tục

![Imgur](https://i.imgur.com/Bdn6PnT.png)

- Chọn `Custum` để cài đặt mới

![Imgur](https://i.imgur.com/cppCRUQ.png)

- Chờ quá trình cài đặt hoàn thành

![Imgur](https://i.imgur.com/NVvANgM.png)


![Imgur](https://i.imgur.com/1OuDuNW.png)
### Step 3: Post-Implementation - Sau khi cài đặt

<h4> Step 3.1: Bật máy ảo (VM)</h4>

<h4> Step 3.2: Cài đặt Vmware Tools or Open VM Tools for Linux</h4>

- Click chuột phải chọn `Install VMware Tools...`

![Imgur](https://i.imgur.com/1HiTS1G.png)

- Vào `This PC`, Chọn `DVD Drive (D:) VMware Tools` để cài đặt.

![Imgur](https://i.imgur.com/qg4dZC7.png)

- Chọn Next để bắt đầu cài đặt và làm theo hướng dẫn

![Imgur](https://i.imgur.com/VqGGPZZ.png)

- Chọn Install để bắt đầu quá trình cài đặt

![Imgur](https://i.imgur.com/XKm6SzJ.png)


<h4> Step 3.3: Thay đổi tên Computer name giống như tên hiển thị máy ảo</h4>

- Vào `Server Manager>Local server`, click vào `computer name`

![Imgur](https://i.imgur.com/l0VdJsg.png)

- Chọn vào `Change...`

![Imgur](https://i.imgur.com/xYVNafk.png)

- Nhập tên vào ô `Computer name` và chọn `OK`

![Imgur](https://i.imgur.com/MNKmmXg.png)

- Khởi động lại để hoàn tất quá trình

![Imgur](https://i.imgur.com/3OKWG0d.png)

- Kết quả, tên đã được thay đổi

![Imgur](https://i.imgur.com/kJFamJ6.png)

> Thêm Disk

- Đối với VMware workstation, phải chuột vào đối tượng chọn Settings
![Imgur](https://i.imgur.com/Xxoy0Ti.png)

- Chọn `Add` để thêm `Hardware`

![Imgur](https://i.imgur.com/UmVR4sD.png)

- Chọn `Hard disk > Next`

![Imgur](https://i.imgur.com/ShOo1eF.png)

- Chọn `Create a new virtual disk > Next`

![Imgur](https://i.imgur.com/eb6OEYO.png)

- Nhập Dung lượng disk chọn `Next`

![Imgur](https://i.imgur.com/mMh3tut.png)

- Hard disk đã thêm:

![Imgur](https://i.imgur.com/0CSu9d0.png)

- Mở Disk Management

![Imgur](https://i.imgur.com/XyjRQDP.png)

- Click vào Disk mới thêm chọn `Online`
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

<h4> Step 3.4:Đặt IP Address/IP Settings (Nếu cần)</h4>

<h4> Step 3.5:Join the System to Domain (Nếu cần)</h4>

<h4> Step 3.6: Thay đổi time zone</h4>

![Imgur](https://i.imgur.com/l2o8Xiv.png)

![Imgur](https://i.imgur.com/yol6ffH.png)

![Imgur](https://i.imgur.com/jfdvREr.png)

![Imgur](https://i.imgur.com/WZTSxom.png)

<h4> Step 3.7: Activate the Guest OS License</h4>

<h4> Step 3.8: Disable IE Enhaned Security for Windows Servers </h4>

![Imgur](https://i.imgur.com/WkYQFmi.png)

<h4> Step 3.9: Turn off Firewall (Optional)</h4>

- Nếu sử dụng thiết bị firewall riêng

<h4> Step 3.10: Enable RDP/SSH </h4>

![Imgur](https://i.imgur.com/wxaS9Ey.png)

![Imgur](https://i.imgur.com/li1vxhG.png)

<h4> Step 3.11: Test the VM access via RDP/SSH </h4>

![Imgur](https://i.imgur.com/3ejFNzb.png)

![Imgur](https://i.imgur.com/bLTKmUf.png)

![Imgur](https://i.imgur.com/rP0IovV.png)

![Imgur](https://i.imgur.com/k1wLuGN.png)

![Imgur](https://i.imgur.com/Y6kZDYE.png)

![Imgur](https://i.imgur.com/TuypZnM.png)

<h4> Step 3.12: Install Project Specific Applications</h4>

<h4> Step 3.13: VM Guest OS hardening</h4>

<h4> Step 3.14: Provide the VM details to End user/Customer/Client/Tenant</h4>

## 2. ESXi 7.x
### Step 1: Pre-Implementation
Xác định các yêu cầu:
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

<h4> Create a VM as per requirement</h4>

<h4> Install the Guest OS </h4>

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
> Thực hiện trong lab sau

# Tài liệu tham khảo