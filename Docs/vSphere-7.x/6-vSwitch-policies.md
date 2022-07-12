<h1> vSwitch policies </h1>

<h2> Summary</h2>

- [1. Các trường hợp sử dụng vSwitch](#1-các-trường-hợp-sử-dụng-vswitch)
- [2. Chính sách vSwitch](#2-chính-sách-vswitch)
- [3. Security Policies - Chính sách Bảo mật](#3-security-policies---chính-sách-bảo-mật)
- [4. Chính sách hợp tác NIC - NIC teaming Policies](#4-chính-sách-hợp-tác-nic---nic-teaming-policies)
- [5. NIC Teaming và Cân bằng tải - NIC Teaming and Load Balancing](#5-nic-teaming-và-cân-bằng-tải---nic-teaming-and-load-balancing)
- [6. Phát hiện chuyển đổi mạng dự phòng -Network Failover detection](#6-phát-hiện-chuyển-đổi-mạng-dự-phòng--network-failover-detection)
- [7. Chính sách Định hình Lưu lượng - Traffic-Shaping Policy](#7-chính-sách-định-hình-lưu-lượng---traffic-shaping-policy)
- [8. Lệnh](#8-lệnh)
- [ESXi Networking - lab:](#esxi-networking---lab)

Sesion 5: vSwitch policies
- Các trường hợp sử dụng vSwitch
- Mạng ESXi - Chính sách vSwitch
- Mạng ESXi - Lệnh
- Mạng ESXi - Lab

# 1. Các trường hợp sử dụng vSwitch
Trường hợp sử dụng-1

<a href="https://imgur.com/sKG49Ny"><img src="https://i.imgur.com/sKG49Ny.png" title="source: imgur.com" /></a>

Nhóm cổng **vSwitch**
1. Nhóm cổng **VM**: Dành cho Mạng máy ảo.
2. Nhóm cổng **VMkernel**: Dành cho ESXi Mgmt. & Services

<a href="https://imgur.com/DqgEji5"><img src="https://i.imgur.com/DqgEji5.png" title="source: imgur.com" /></a>

Trường hợp sử dụng-2

<a href="https://imgur.com/HtLQiKn"><img src="https://i.imgur.com/HtLQiKn.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/fF38FfN"><img src="https://i.imgur.com/fF38FfN.png" title="source: imgur.com" /></a>

# 2. Chính sách vSwitch

<a href="https://imgur.com/XkAP8TH"><img src="https://i.imgur.com/XkAP8TH.png" title="source: imgur.com" /></a>

- Các chính sách được đặt ở cấp độ chuyển mạch tiêu chuẩn (standard switch level), áp dụng cho tất cả các nhóm cổng trên **vSwitch theo mặc định**.
- **Các chính sách mạng** có sẵn:
1. Security (Bảo mật)
2. Traffic shaping (Định hình giao thông)
3. NIC teaming and failover (NIC hợp tác và chuyển đổi dự phòng)
- Các chính sách được xác định ở các cấp độ tiếp theo:
  - Mức **vSwitch**:
    - Các chính sách mặc định cho tất cả các cổng trên switch tiêu chuẩn (standard switch).
  - Cấp **nhóm cổng**:
    - Các chính sách hiệu quả: Các chính sách được xác định ở cấp độ này sẽ ghi đè các chính sách mặc định được đặt ở cấp độ chuyển đổi tiêu chuẩn.

<a href="https://imgur.com/XkAP8TH"><img src="https://i.imgur.com/XkAP8TH.png" title="source: imgur.com" /></a>

# 3. Security Policies - Chính sách Bảo mật

**vSphere Admin** có thể xác định các chính sách bảo mật ở cả standard switch level và port group level:
- **Chế độ Promiscuous**:
  - Cho phép một công tắc ảo (virtual switch) hoặc nhóm cổng chuyển tiếp **tất cả lưu lượng** truy cập bất kể điểm đến.
- **MAC address changes** - Thay đổi địa chỉ MAC:
  - Chấp nhận hoặc từ chối **lưu lượng đến** khi khách thay đổi địa chỉ MAC.
- Forged transmits:
  - Chấp nhận hoặc từ chối **lưu lượng gửi đi** khi khách thay đổi địa chỉ MAC.

<a href="https://imgur.com/XYiPje0"><img src="https://i.imgur.com/XYiPje0.png" title="source: imgur.com" /></a>

# 4. Chính sách hợp tác NIC - NIC teaming Policies
- **NIC Teaming** cho phép nhiều NICS được kết nối với một công tắc ảo duy nhất để tiếp tục truy cập vào mạng.
- Trong một số trường hợp, nó cũng có thể kích hoạt cân bằng tải nếu phần cứng bị lỗi.
- **Chính sách cân bằng tải**
  - Định tuyến dựa trên **Cổng ảo** gốc
  - Định tuyến dựa trên **Nguồn MAC Hash**
  - Định tuyến dựa trên **IP Hash**
  - Sử dụng **Lệnh chuyển đổi dự phòng** rõ ràng

<a href="https://imgur.com/SYMtANM"><img src="https://i.imgur.com/SYMtANM.png" title="source: imgur.com" /></a>

# 5. NIC Teaming và Cân bằng tải - NIC Teaming and Load Balancing

<a href="https://imgur.com/8Vi6MZ4"><img src="https://i.imgur.com/8Vi6MZ4.png" title="source: imgur.com" /></a>

Chúng ta có thể định cấu hình **các thuật toán cân bằng tải** khác nhau trên vSwitch để xác định cách phân phối lưu lượng mạng giữa các NIC vật lý trong một nhóm NIC.
1. Định tuyến dựa trên **cổng ảo** có nguồn gốc
- Công tắc ảo chọn các liên kết dựa trên ID cổng máy ảo trên Công tắc tiêu chuẩn vSphere
2. Định tuyến dựa trên **mã nguồn MAC Hash**
- Công tắc ảo chọn một đường lên cho một máy ảo dựa trên địa chỉ MAC của máy ảo. Để tính toán đường lên cho một máy ảo, công tắc ảo sử dụng địa chỉ MAC của máy ảo và số lượng liên kết lên trong nhóm NIC.

3. Định tuyến dựa trên **IP Hash**
- Switch ảo chọn các đường lên cho các máy ảo dựa trên địa chỉ IP nguồn và đích của mỗi gói tin.

4. Sử dụng **Lệnh chuyển đổi dự phòng** rõ ràng
- Không có cân bằng tải thực tế nào khả dụng với chính sách này. Công tắc ảo luôn sử dụng liên kết lên đứng đầu tiên trong danh sách Bộ điều hợp hoạt động từ thứ tự chuyển đổi dự phòng và vượt qua các tiêu chí phát hiện chuyển đổi dự phòng. Nếu không có liên kết lên trong danh sách Hoạt động, công tắc ảo sẽ sử dụng liên kết lên từ danh sách Dự phòng.

# 6. Phát hiện chuyển đổi mạng dự phòng -Network Failover detection

- **VMkernel** có thể sử dụng **trạng thái liên kết (link status)** hoặc **đèn hiệu (beaconing)** hoặc cả hai để phát hiện lỗi mạng.
- **Beacon Probing** là một trong hai cơ chế phát hiện lỗi NIC có sẵn
- VMkernel thông báo cho các bộ chuyển mạch vật lý về những thay đổi trong vị trí thực của địa chỉ MAC.
- **Chuyển đổi dự phòng (Failover)** được **VMkernel** thực hiện dựa trên các tham số có thể định cấu hình:
  - **Failback**: Cách bộ điều hợp vật lý trở lại hoạt động sau khi khôi phục từ lỗi.
  - **Tùy chọn cân bằng tải (Load-balancing option)**: Sử dụng **thứ tự chuyển đổi dự phòng rõ ràng (explicit failover order)**.
  - Luôn sử dụng liên kết lên vmnic ở đầu danh sách bộ điều hợp hoạt động.

<a href="https://imgur.com/DGORDvI"><img src="https://i.imgur.com/DGORDvI.png" title="source: imgur.com" /></a>

# 7. Chính sách Định hình Lưu lượng - Traffic-Shaping Policy
- Định hình lưu lượng mạng (Network traffic shaping) là một cơ chế để hạn chế việc tiêu thụ băng thông mạng có sẵn của một máy ảo.
- Tốc độ trung bình, tốc độ đỉnh và kích thước cụm có thể định cấu hình.
- Định hình lưu lượng chỉ kiểm soát lưu lượng đi, tức là lưu lượng đi từ máy ảo đến công tắc ảo và ra vào mạng vật lý.

<a href="https://imgur.com/Fi2AdYs"><img src="https://i.imgur.com/Fi2AdYs.png" title="source: imgur.com" /></a>

# 8. Lệnh

ESXI Networking Command - Chức năng|Command|
|---|---|
Để lấy các thẻ Mạng có sẵn trên máy chủ ESXi | esxcfg-nics-l
Để chỉ hiển thị cổng mặc định | esxcfg-route
Để tải các nhóm cổng vmkernel có sẵn trên máy chủ ESXi | esxcfg-vmknic-l
Để nhận thông tin về công tắc ảo có sẵn trên máy chủ ESXi | esxcfg-vswitch-1
Số tùy chọn có sẵn cho cài đặt mạng esxcli | mạng esxcli
Để liệt kê các kết nối đã thiết lập trên máy chủ của chúng tôi (Netstat) | danh sách kết nối ip mạng esxcli
Để liệt kê cấu hình địa chỉ IP cho các cổng VMkernel | giao diện ip mạng esxcli ipv4 get
Để liệt kê các giao diện vmkernel và cấu hình của chúng | danh sách giao diện ip mạng esxcli
Để liệt kê thông tin máy chủ hàng xóm hoặc bảng ARP trên máy chủ ESXi | esxcli mạng ip danh sách hàng xóm
Để liệt kê bảng định tuyến của máy chủ lưu trữ | esxcli network ip route ipv4 list
Để xem Cấu hình NIC Vật lý | mạng esxcli nic
Tắt mạng vmnic | esxcli nic down-n = vmnic_name
Để liệt kê tất cả NICS có trong danh sách nic mạng Esxi host | esxcli
Để kiểm tra các thuộc tính của một số liệu thống kê mạng vmknic | esxcli duy nhất get-n vmnico
Để kết nối lại mạng vmnic | esxcli, nic up-navmnic_name
Để liệt kê cấu hình vswitch hiện tại | danh sách tiêu chuẩn vSwitch mạng esxcli
Để kiểm tra kết nối trên cổng | nc-z dest-ip dest-port
Kiểm tra kết nối với máy chủ ESXi từ xa bằng các tiện ích ping và vmkping | `vmkping <IP>`

# ESXi Networking - lab:

1. Tạo vSwitch
2. Tạo nhóm Cổng VM
3. Tạo nhóm Cổng VMkernel
4. Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng
5. Tuân thủ Chính sách kết nối vSwitch
6. Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.
7. Loại bỏ vSwitch, nhóm cổng, liên kết lên