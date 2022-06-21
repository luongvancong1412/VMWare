<h1> Quy trình xây dựng host ESXi </h1>

<h2> Summary</h2>

- [1. Các khái niệm cơ bản về ảo hoá](#1-các-khái-niệm-cơ-bản-về-ảo-hoá)
- [2. Tổng quan về ESXi](#2-tổng-quan-về-esxi)
- [3. Kiến trúc ESXi](#3-kiến-trúc-esxi)
- [4. ESXi Host Build Procedure](#4-esxi-host-build-procedure)
  - [4.1 Các bước trước khi cài đặt ESXi](#41-các-bước-trước-khi-cài-đặt-esxi)
  - [4.2 Quy trình cài đặt ESXi](#42-quy-trình-cài-đặt-esxi)
  - [4.3 Các bước sau khi cài đặt ESXi](#43-các-bước-sau-khi-cài-đặt-esxi)

----
<h3>Nội dung</h3>

- Các khái niệm cơ bản về ảo hoá
- Tổng quan về ESXi
- Quy trình Buid host ESXi
- Lab - Cài đặt ESXi

# 1. Các khái niệm cơ bản về ảo hoá
**Host/Node/Server:**

<a href="https://imgur.com/UV8FROF"><img src="https://i.imgur.com/UV8FROF.png" title="source: imgur.com" width=35% align=right /></a>

- Máy chủ vật lý cung cấp tài nguyên cho ESXi hypervisor.
- Ví dụ: Máy chủ vật lý HPE, DELL,IBM,...

**Operating System:**
- Phầm mềm được thiết kế để phân bổ tài nguyên vật lý cho các application
- Ví dụ: MS Windows, Linux, Solaris.

**Hypervisor:**
- Hệ điều hành hoặc phần mềm chuyên dụng để chạy máy ảo (VMs)
- Ví dụ: ESXi, VMW Workstation, Fusion, MS Hyper-V & Oracle Virtual Box

Virtual Machine:
- Nó là một máy được tạo phầm mềm và trông giống như một máy chủ vật lý.
- Ứng dụng chuyên dụng trừu tượng hoá tài nguyên phần cứng thành phần mềm.
- Ví dụ: ESXi - VMs, MS Hyper-V - VMs, Oracle Virtual Box VMs

Guest OS:

<a href="https://imgur.com/KYu8Cdz"><img src="https://i.imgur.com/KYu8Cdz.png" title="source: imgur.com" width=35% align=right /></a>

- Hệ điều hành chạy trong Virtual Machine
- Eg: MS Windows, Linux, Solaris.

Application:
- Phần mềm chạy trên hệ điều hành, sử dụng tài nguyên vật lý hoặc ảo.
- Eg: MS Office, Chrome, SAP, MS SQL, Oracle,...

vSphere:
- Sản phẩm ảo hoá server của VMware kết hợp ESXi Hypervisor và vCenter Server Management Platform.

# 2. Tổng quan về ESXi

- ESXi là bare metal VMware vSphere Hypervisor.
<a href="https://imgur.com/KYu8Cdz"><img src="https://i.imgur.com/KYu8Cdz.png" title="source: imgur.com" width=35% align=right /></a>
- ESXi cài đặt trực tiếp trên máy chủ vật lý cho phép truy cập trực tiếp vào tất cả các tài nguyên máy chủ (CPU, Mem, Disk or Storage, NIC).
- Cho phép các máy ảo chạy với hiệu suất gần như nguyên bản,không giống như hosted hypervisors (tìm hiểu thêm?)
- ESXi có thể cài đặt trên hard disk, SAN LUNs, SD Card, SATADOM. (Tìm hiểu thêm?)
- ESXi có một small disk footprint (tìm hiểu thêm) để tăng cường bảo mật và độ tin cậy.
- ESXi 7.x cho phép
  - Sử dụng lên đến 768 Logical CPUs trên mỗi host
  - Sử dụng lên đến 16 TB RAM trên mỗi host
  - Triển khai (Deployment) lên đến 1024 virtual machines trên mỗi host

# 3. Kiến trúc ESXi

<a href="https://imgur.com/itSnG04"><img src="https://i.imgur.com/itSnG04.png" title="source: imgur.com" /></a>

# 4. ESXi Host Build Procedure
## 4.1 Các bước trước khi cài đặt ESXi
- Xác minh danh sách tương thích phần cứng
- Chọn phần cứng tương thích (Máy chủ Tower/Rack mount/ Blade)
- Hệ thống cáp máy chủ hoạt động với sự trợ giúp của Nhà cung cấp
- Định cấu hình HPE-ILO hoặc DELL- IDRAC hoặc IBM- RSA hoặc Fujitsu - iRMC
- Kết nối với các Máy chủ bằng địa chỉ IP quản lý từ xa
- Cài đặt hoặc Upgrade Firmware mới nhất
- Bật RAID 1 hoặc 5 ở BIOS level
- Bật Intel-VT hoặc AMD-V ở BIOS Level
- Download tệp ESXi 7.x ISO hoặc tệp ISO Custom
- Nhận IP Settings từ Networking Team hoặc IP Inventory list (Danh sách kiểm kê IP)
- Nhận thông tin chi tiết về Storage từ Storage team.
- Tạo bản ghi host (A) và PTR records trong DNS server

## 4.2 Quy trình cài đặt ESXi
- Mount ISO qua option Virtual media
- Reset Server vật lý bằng Power Mgmt.Option
- Theo dõi quá trình khởi động ESXi từ Remote Mgmt.Console
- Làm theo hướng dẫn trên màn hình để cài đặt, tức là nhấn F11

## 4.3 Các bước sau khi cài đặt ESXi
- Thay đổi thông tin đăng nhập gốc qua SSH/Enable SSH
- Bật NTP, Port -123: Đồng bộ hoá theo thời gian (For Time Syncronization)
- Bật SNMP, Port - 161,162: Để giám sát máy chủ ESXi
- Áp dụng các bản vá lỗi trên host ESXi (Optional)
- Cấu hình Mạng host ESXi -vSwitch, DvSwitch
- Cấu hình Storage trên host ESXi - Local, NAS, ISCSI và SAN
- Chuyển nhương giấy phép ESXi (Assign ESXi License)
- Tắt chế độ ESXi lockdown
- Cấu hình ESXi Syslog server
- Xác thực trang thái kết nối host ESXi và kiểm tra Health
- Tạo một VMs Test và Kiểm tra image Backup
- Mở các port Firewall cần thiết (Optional)
- Xác thực Dung lượng disk host ESXi
- Set VMs auto start với host (Optional)

> Thực hành: [ESXi Host Build Procedure](../../Lab/2-ESXi-Host-Build-Procedure.md)