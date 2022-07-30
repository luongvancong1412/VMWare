<h1>Cài đặt, cấu hình và quản lý</h1>

<h2>Summary</h2>

- [1. vCenter 7.0 Kiến trúc](#1-vcenter-70-kiến-trúc)
- [2. Quy trình xây dựng vCenter- Kịch bản thời gian thực tế](#2-quy-trình-xây-dựng-vcenter--kịch-bản-thời-gian-thực-tế)
  - [2.1 Các bước trước khi cài đặt vCenter](#21-các-bước-trước-khi-cài-đặt-vcenter)
  - [2.2 Quy trình Cài đặt vCenter](#22-quy-trình-cài-đặt-vcenter)
- [3. Các Bước Cài đặt sau vCenter](#3-các-bước-cài-đặt-sau-vcenter)
- [4. vCenter Server Deploy - Yêu cầu tài nguyên](#4-vcenter-server-deploy---yêu-cầu-tài-nguyên)
- [5. vCenter Server Appliance - Log files](#5-vcenter-server-appliance---log-files)

# 1. vCenter 7.0 Kiến trúc

- vCenter Server được hỗ trợ bởi vSphere Client, cơ sở dữ liệu vCenter Server và máy chủ được quản lý bằng host.


<a href="https://imgur.com/vWil5qB"><img src="https://i.imgur.com/vWil5qB.png" title="source: imgur.com" /></a>

- Sau khi cài đặt vCenter, nó sẽ đi kèm với một số Mo-dun bổ sung, chúng ta không cần cài đặt mo-dum mà nó mặc định đi kèm với server vCenter
  - Một trong những mô-đun bổ sung là tệp html5 Client vSphere
- Chúng ta có thể truy cập máy chủ vCenter và máy chủ trung tâm gắn với 1 database mặc định có tên là postgresql
- Có thành phần bổ sung là Platform Services Controller (PSC) để kiểm soát dịch vụ nền tảng đi kèm với một đăng nhập duy nhất (Single Sign-On) của máy chủ vCenter
  - máy chủ vCenter theo mặc định có 2 tài khoản quản trị viên
    - 1 là tài khoản người máy root giống như máy chủ ESX
    - 1 tài khoản quản trị viên khác là quản trị viên theo tỷ lệ vsphere dot cục bộ
  - Chúng ta có thể sử dụng Directory Domain hoạt động inte gration, vì vậy khi cài đặt 1 máy chủ vCenter, chúng ta phải tạo 1 bản ghi DNS và join vào miền...
- vSphere Client:
  - Giao diện người dùng dựa trên HTML 5 cho phép kết nối với các phiên bản vCenter Server bằng cách sử dụng trình duyệt Web.

# 2. Quy trình xây dựng vCenter- Kịch bản thời gian thực tế

## 2.1 Các bước trước khi cài đặt vCenter

- Xác minh rằng hệ thống đáp ứng các yêu cầu phần mềm và phần cứng **tối thiểu** cho Cài đặt VCSA
- Tải xuống tệp tin **ISO** vCenter Server **(VCSA)** từ Trang web của VMware.
- Mount nó vào một máy ảo mạng hoặc máy chủ vật lý mà chúng ta muốn thực hiện việc triển khai từ đó
- Máy mà chúng ta triển khai công cụ phải chạy trên **Windows**, Linux hoặc Mac OS
- Thu thập chi tiết **host ESXi đích** nơi Máy chủ vCenter đích sẽ được triển khai
- Xác minh rằng host ESXi không ở chế độ khóa (lockdown) hoặc bảo trì (**maintenance**)
- Xác minh rằng máy chủ NTP đang ở trạng thái chạy
- Nhận **Cài đặt IP** từ Network Team hoặc danh sách Kiểm kê IP (IP Inventory list)
- Nhận thông tin chi tiết về **Bộ nhớ** từ Storage team (Tùy chọn)
- Tạo bản ghi host (A) và bản ghi PTR trong **Máy chủ DNS** với Địa chỉ IP cố định và FQDN
- Sẵn sàng với trình duyệt web được hỗ trợ (Chrome, Firefox, MS Edge) để truy cập **vSphere Client**

## 2.2 Quy trình Cài đặt vCenter

- Mount **ISO** trên một hệ thống
- Cài đặt vCenter Server là một quá trình gồm **hai giai đoạn**.
**Giai đoạn 1**- Triển khai vCenter Server
- Triển khai tệp **OVA** dưới dạng Công cụ máy chủ vCenter
- Giai đoạn đầu tiên liên quan đến việc triển khai một máy chủ vCenter mới cho **host ESXi mục tiêu**.
- Xác định tên Công cụ máy chủ vCenter và mật khẩu root.
- Chọn **size** triển khai (Mem / CPU) và kích thước storage.
- Chọn vị trí kho dữ liệu - datastore (**thin** disk).
- Định cấu hình mạng - **Cài đặt IP**
**Giai đoạn 2**- Thiết lập vCenter Server
- Đăng nhập vào Giao diện Quản lý Công cụ vCenter (**VAMI**) `https://<IP hoặc FQDN>:5480/`
- Định cấu hình đồng bộ hóa **thời gian** thiết bị và Đăng nhập một lần vCenter - vCenter Single Sign-On (**SSO**)
- Giai đoạn thứ hai hoàn thành việc thiết lập vCenter đã triển khai

# 3. Các Bước Cài đặt sau vCenter

- Đăng nhập vào Trang vCenter Server Getting Started: `https://<IP hoặc FQDN>:443` **hoặc** `https://<IP hoặc FQDN>`

- Đăng nhập vào máy chủ vCenter bằng cách sử dụng vSphere Client > Khởi chạy vSphere Client (**HTML5**)

- Bắt đầu tạo và tổ chức các Đối tượng khoảng không quảng cáo vCenter Server (vCenter Server inventory Objects)
- Chuyển nhượng Giấy phép VCSA (Assign VCSA **License**)
- Enable VCSA Shell, **SSH**
- Enable NTP, Cổng-123: Đồng bộ hóa thời gian, **SNMP**, **SMTP**
- Áp dụng **các bản vá** VCSA (Tùy chọn)
- Tạo (các) Trung tâm dữ liệu (**Datacenter**) trong Máy chủ vCenter
- **Thêm** các host ESXi vào vCenter Server 
- Configure ESXi host **Networking** - Switch / DvSwitch (Tùy chọn)
- Định cấu hình **Storage** host ESXi - Cục bộ, NAS, ISCSI và SAN (Tùy chọn)
- Tạo Máy ảo, Mẫu, Sao chép & Snapshots (Tùy chọn)
- Tạo một **cụm** và kích hoạt các tính năng của cụm (Tùy chọn
- Cấu hình **Syslog** Server (Tùy chọn)
- Tạo một máy ảo thử nghiệm và kiểm tra hình ảnh Backup & **Backup** VCSA (Tùy chọn)
- Mở các cổng **Tường lửa** cần thiết (Tùy chọn) 
- Xuất **Gói hỗ trợ** máy chủ vCenter để khắc phục sự cố (Tùy chọn)
- Cài đặt Plug-in Xác thực Nâng cao VMware - VMware Enhanced Authentication(Tùy chọn)
- **Đặt lại** máy chủ vCenter cho một máy chủ vCenter khác trong một Domain khác (Tùy chọn)
- Xác thực **Tình trạng Health** VCSA cho tất cả các nguồn thông qua **VAMI**
- Bắt đầu **quản lý** môi trường vSphere
- **Kết thúc** triển khai VCSA

# 4. vCenter Server Deploy - Yêu cầu tài nguyên

Tài nguyên cần thiết cho các quy mô triển khai khác nhau

Kích thước triển khai| vCPUs (GB)| Memory (GB) | Storage (GB)|Hosts (tối đa)|Máy ảo (tối đa) |
| --- | --- | --- | --- | --- |---|
Tiny | 2 | 12 | 579 | 10 | 100 |
Small| 4 | 19 | 694 | 100 | 1000 |
Medium| 8 | 28 | 908 | 400 | 4000 |
Large| 16 | 37 | 1358 | 1000 | 100000 |
X-Large| 24 | 56 | 2283 | 2000 | 35000 |

# 5. vCenter Server Appliance - Log files

Export Gói `vCenter Server Support Bundle` để khắc phục sự cố

**Phương pháp GUI:**
- Đăng nhập vào host Windows mà chúng ta muốn tải xuống gói.
- Mở trình duyệt Web và nhập URL vào gói hỗ trợ được hiển thị trong DCUI.
- https://appliance-fully-qualified-domain-namex443/appliance/support-bundle
    - Nhập username và password của người dùng root.