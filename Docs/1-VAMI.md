<h1> vCenter Appliance Management Interface (VAMI) Use cases</h1>

<h2>Summary</h2>

- [vCenter Inventory Objects](#vcenter-inventory-objects)
- [vCenter Server Managermanet Interface (VAMI) - Use cases](#vcenter-server-managermanet-interface-vami---use-cases)
  - [VAMI](#vami)
  - [Use Cases](#use-cases)
- [Organize an inventory of virtual objects - Tổ chức kiểm kê các đối tượng ảo](#organize-an-inventory-of-virtual-objects---tổ-chức-kiểm-kê-các-đối-tượng-ảo)
- [Data Center (DC)](#data-center-dc)
- [Hosts & Clusters](#hosts--clusters)
- [VMs & Templates](#vms--templates)
- [vCenter - Lab](#vcenter---lab)


# vCenter Inventory Objects

# vCenter Server Managermanet Interface (VAMI) - Use cases

## VAMI

- VAMI hữu ích khi cấu hình, vận hành vCenter server sau khi triển khai.
- Điều kiện tiên quyết:
  - vCenter Server được triển khai và chạy thành công.

- Thủ tục đăng nhập:
  - Trong trình duyệt Web, đi tới vCenter Server Management Interface:
    - https://appliance-IPaddress-or-FQDN:5480
  - Ví dụ: https://192.168.10.79:5480/
  - Đăng nhập với quyền `root`.
  - Mật khẩu root mặc định là mật khẩu đặt trong khi triển khai vCenter Server.

## Use Cases

STT| VAMI Uses Cases| Việt hoá|
|:---:|---|---|
1|View vCenter ServerHealth Status| Xem trạng thái tình trạng máy chủ vCenter|
2|Reboot or Shut Down vCenter Server| Khởi động lại hoặc tắt máy chủ vCenter
3|Create a Support Bundle|Tạo 1 Support Bundle
4|Monitor CPU and Memory Use| Giám sát sử dụng CPU và Memory
5|Monitor Disk Use| Giám sát sử dụng đĩa
6|Monitor Network Use| Giám sát sử dụng Network
7|Monitor Database Use| Giám sát sử dụng Database
8|Enable or Disable SSH and Bash Shell Access| Bật hoặc tắt quyền truy cập SSH và Bash Shell
9|Configure the DNS, IP Address, and Proxy Settings| Cấu hình DNS, Địa chỉ IP và Proxy
10|Reconfigure the Primary Network Identifier| Định cấu hình Primary Network Identifier
11|Edit the Firewall Settings| Chỉnh sửa cài đặt Firewall
12|Configure the System Time Zone and Time Synchronization Settings| Cấu hình cài đặt đồng bộ hoá múi giờ và múi giờ hệ thống.
13|Start, Stop, and Restart Services| Khởi động, Dừng và khởi động lại dịch vụ
14|Configure Update Settings| Cấu hình cài đặt Cập nhật
15|Change the Password and Password Expiration Settings of the Root User| Thay đổi mật khẩu và hết hạn mật khẩu của người rùng root
16|Forward vCenter Server Log Files to Remote Syslog Server| Forward file nhật ký máy chủ Server máy chủ nhật ký từ xa
17|Configure and Schedule Backups| Cấu hình và lên lịch sao lưu

# Organize an inventory of virtual objects - Tổ chức kiểm kê các đối tượng ảo

- Create a Data Center (s) - Tạo các Trung tâm Dữ liệu
- Create a Folder (s) - Tạo các Thư mục

- Add a Host (s) to a Folder or a Data Center -  Thêm các Host và Thư mục hoặc Trung tâm Dữ liệu.

- Creating and Configuring Clusters - Tạo và cấu hình Clusters

- Extend a Cluster -  Mở rộng 1 Cluster

# Data Center (DC)
- Trung tâm dữ liệu ảo là nơi chứa tất cả các đối tượng kiểm kê cần thiết để hoàn thành một mội trường đầy đủ chức năng để vận hành máy ảo
- Chúng ta có thể tạo nhiều trung tâm dữ liệu để tổ chức các nhóm môi trường đáp ứng các nhu cầu khác nhau của người dùng
- Mỗi Data center bao gồm: hosts, VMs, templates, datastores và networks

<a href="https://imgur.com/yaBivp2"><img src="https://i.imgur.com/yaBivp2.png" title="source: imgur.com" /></a>

Ví dụ:
- Có thể tạo 1 Datacenter cho từng đơn vị tổ chức trong doanh nghiệp.
- Tạo một số trung tâm dữ liệu cho các môi trường hiệu suất cao hoặc các trung tâm dữ liệu môi trường ít yêu cầu hơn.

# Hosts & Clusters

**ESXi Host:**
- Host là máy chủ sử dụng phần mềm ảo hoá, chẳng hạn như ESXi, để chạy các máy ảo.
- Host cung cấp tài nguyên CPU và Memory để máy ảo sử dụng

<a href="https://imgur.com/N5SxF94"><img src="https://i.imgur.com/N5SxF94.png" title="source: imgur.com" /></a>

**Cluster:**
- Cluster là một nhóm các host. Khi thêm host (máy chủ) vào 1 cluster, tài nguyên của host sẽ trở thành 1 phần tài nguyên của cluster
- Cluster quản lý tài nguyên của tất cả các máy chủ bên trong nó.
- Cluster cho phép các giải pháp High Availlability (HA) và Distributed Resource Scheduler (DRS) 

<a href="https://imgur.com/ovksJXm"><img src="https://i.imgur.com/ovksJXm.png" title="source: imgur.com" /></a>

# VMs & Templates
- A template is a master copy of a virtual machine. We use templates to create and provision new VMs.
- A template typically includes:
  - A guest operating system
  - One or more applications
  - A specific VM configuration

<a href="https://imgur.com/lgZdSO1"><img src="https://i.imgur.com/lgZdSO1.png" title="source: imgur.com" /></a>

Purpose:
- We can quickly deploy the multiple virtual machines (Fast Provisioning)
- It will reduce the deployment time of virtual machines.

- Template là bản sao chính (master) của máy ảo. Chúng ta có thể sử dụng các template để tạo và cung cấp máy ảo mới.
- Một Template thường bao gồm:
  - 1 Guest OS
  - 1 hoặc nhiều application
  - 1 cấu hình máy ảo cụ thể
- Mục đích tạo template:
  - Triển khai nhanh chóng nhiều máy ảo (Fast Provisioning)
  - Giảm thời gian deploy máy ảo

# vCenter - Lab


