<h1> Kiến trúc </h1>

<h2>Summary</h2>

- [1. VMware vCenter Server - (VCSA)](#1-vmware-vcenter-server---vcsa)
- [2. vCenter Server - Tổng quan](#2-vcenter-server---tổng-quan)
- [3. Máy chủ vCenter - Tối đa cấu hình](#3-máy-chủ-vcenter---tối-đa-cấu-hình)
- [4. vCenter 7.0 - Kiến trúc](#4-vcenter-70---kiến-trúc)
- [5. Máy chủ ESXi và vCenter - Giao tiếp (Communication)](#5-máy-chủ-esxi-và-vcenter---giao-tiếp-communication)
- [6. Máy chủ vCenter - Dịch vụ](#6-máy-chủ-vcenter---dịch-vụ)
- [7. Triển khai VCSA - Lab](#7-triển-khai-vcsa---lab)


# 1. VMware vCenter Server - (VCSA)

- **vCenter** là **nền tảng quản lý** cho môi trường vSphere.
- **vCenter** Server cho phép quản lý tập trung **nhiều máy chủ ESXi** và **các máy ảo** của chúng.
- Máy chủ **vCenter** chỉ khả dụng như một thiết bị trong vSphere 7.0 trở lên
- VCSA là một **máy ảo dựa trên Linux** được cấu hình sẵn được tối ưu hóa để **chạy máy chủ vCenter** và các thành phần của máy chủ vCenter.
- Chúng ta có thể triển khai **vCenter Server Appliance** (VCSA) trên host **ESXi** trong cơ sở hạ tầng.
- **VCSA** cung cấp **các tính năng nâng cao** như vSphere HA, DRS, FT, vMotion, Storage vMotion ...

<a href="https://imgur.com/tQZ1P3U"><img src="https://i.imgur.com/tQZ1P3U.png" title="source: imgur.com" /></a>

# 2. vCenter Server - Tổng quan

Gói vCenter Server chứa phần mềm sau:
1. VMware **Photon OS**
2. Cơ sở dữ liệu **PostgreSQL**
3. **Dịch vụ** máy chủ vCenter

- **VCSA** cũng cung cấp quyền truy cập **SDK** vào môi trường cho các giải pháp như VMware **vRealize Automation 8.6.2**.
- Một **máy chủ vCenter duy nhất** chạy phiên bản 7.0 có thể quản lý:
  - **2500** host ESXi
  - **45.000** máy ảo

<a href="https://imgur.com/GNYxXh3"><img src="https://i.imgur.com/GNYxXh3.png" title="source: imgur.com" /></a>

- Máy chủ VMware vCenter:
  - **Tự động hóa**: Mở khóa sức mạnh của VMware vSphere thông qua quản lý chủ động
  - **Khả năng hiển thị**: Khả năng hiển thị sâu vào mọi cấp độ của cơ sở hạ tầng ảo
  - **Khả năng mở rộng**: Nền tảng quản lý có thể mở rộng

# 3. Máy chủ vCenter - Tối đa cấu hình

| S.No | Metric | vCenter Server 7.0 Giới hạn tối đa | Mô tả |
| --- | --- | --- | --- |
| 1 | **Host** cho mỗi phiên bản máy chủ vCenter | 2500 |
| 2 | **Bật nguồn máy ảo** (Power ON VMs) trên mỗi phiên bản máy chủ vCenter | 4000 |
| 3 | Máy ảo **đã đăng ký** trên mỗi Máy chủ vCenter | 45000 |
| 4 | Máy chủ vCenter **được liên kết(Linked)** | 15 |
| 5 | **Host** mỗi Cluster | 96 | Giới hạn 96 host mới được áp dụng **từ 7.0U1 trở đi** và chỉ hợp lệ cho các cụm không phải VSAN. <br> Giới hạn 7.0GA là **64 host mỗi cụm** |
| 6 | **Máy ảo** trên mỗi cụm | 1024 |
| 7 | Máy ảo trên **mỗi host** | 1024 |


# 4. vCenter 7.0 - Kiến trúc

- vCenter Server được hỗ trợ bởi vSphere Client, cơ sở dữ liệu vCenter Server và các máy chủ được quản lý.

<a href="https://imgur.com/CFX8GsV"><img src="https://i.imgur.com/CFX8GsV.png" title="source: imgur.com" /></a>

# 5. Máy chủ ESXi và vCenter - Giao tiếp (Communication)

- VSphere Client giao tiếp trực tiếp với vCenter Server. Để giao tiếp trực tiếp với máy chủ ESXi, chúng ta sử dụng **VMware Host Client**

<a href="https://imgur.com/ws5DUJJ"><img src="https://i.imgur.com/ws5DUJJ.png" title="source: imgur.com" /></a>

# 6. Máy chủ vCenter - Dịch vụ

Dịch vụ máy chủ vCenter bao gồm:
1. vCenter Server
2. VMware vSphere Client (HTML5)
3. Đăng nhập một lần VMware vCenter (VMware vCenter Single Sign-On)
4. Dịch vụ giấy phép
5. Dịch vụ tra cứu vCenter
6. Cơ quan cấp chứng chỉ VMware
7. Thư viện nội dung
8. VMware vSphere ESXi Dump Collector

Khi chúng ta triển khai vCenter Server Appliance, tất cả các dịch vụ này đều được bao gồm.

# 7. Triển khai VCSA - Lab
- vCenter Appliance (bao gồm PSC Install) là một quá trình hai giai đoạn
  - Giai đoạn 1 - Triển khai OVF
  - Giai đoạn 2 - Cấu hình NTP, SSH, SSO