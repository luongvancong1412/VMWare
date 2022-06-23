<h1> ESXi & Khái niệm cơ bản về mạng</h1>

<h2>Summary</h2>

- [1. Khái niệm Mạng Cơ bản](#1-khái-niệm-mạng-cơ-bản)
- [2. Loại Network](#2-loại-network)
- [3. Yêu cầu cơ bản để hình thành Mạng](#3-yêu-cầu-cơ-bản-để-hình-thành-mạng)
- [Lab - Demo](#lab---demo)

---
- Các khái niệm cơ bản về mạng
- Các kịch bản thời gian thực kết nối mạng
- Mạng host ESXi
- Kiến trúc Standard Switch vSphere
- Mạng vật lý cơ bản - Lab
- Mạng host ESXi (Mạng ảo - Virtual Networking) - Lab
# 1. Khái niệm Mạng Cơ bản
- Network: Kết nối giữa hai hoặc nhiều thiết bị được gọi là network.
- Kết nối mạng - Networking: Giao tiếp giữa hai hoặc nhiều thiết bị được kết nối với nhau được gọi là Networking.
- Có thể thiết lập kết nối giữa các thiết bị với sự trợ giúp của Switch hoặc Điểm truy cập không dây để truyền dữ liệu.
  - Ví dụ.:
    - Máy trạm: Laptop, desktop, Server.
    - Thiết bị mạng: Switch, router, Wireless Access Point(WAP)Mobile, Tab, Printers, Scanners, v.v.,

- Các thiết bị mạng: Home, office
![Imgur](https://i.imgur.com/h6yJpJ9.png)
# 2. Loại Network
Mạng được sử dụng phổ biến:
- LAN: Mạng cục bộ - Local Area Network
  - Mạng cục bộ được sử dụng để kết nối kết nối giữa các hệ thống và các thiết bị Mạng khác rất gần nhau trong một khu vực hạn chế như tầng của một tòa nhà, tòa tháp văn phòng hoặc trong khuôn viên:
- WAN: Mạng diện rộng - Wide Area Network
  - Mạng diện rộng kết nối hai hoặc nhiều LANS có mặt tại các vị trí địa lý (Địa lý) khác nhau

# 3. Yêu cầu cơ bản để hình thành Mạng
Để tạo hình thành mạng cơ bản, cần yêu cầu tối thiểu là:
1. Network Adapter (LAN Card/NIC)
2. Phương tiện - Media (Giao tiếp giữa một hệ thống này với một hệ thống khác, có thể kết nối LAN bằng dây hoặc Không dây)
3. Thiết bị mạng (Switches, Router, WAP, Firewall, v.v.)
4. Giao thức (IP, TCP, UDP, http, ftp, ssh, SMS, v.v.)
   - Để giao tiếp giữa hệ thống khác, cần 1 ngôn ngữ để giao tiếp từ nguồn đến đích hoặc ngược lại
5. Địa chỉ IP (IPv4, IPv6)
    - Địa chỉ nhận dạng


<h3>Network Interface Card (NIC)</h3>

- NIC là giao diện giữa hệ thống và mạng.
<a href="https://imgur.com/IeE9icR"><img src="https://i.imgur.com/IeE9icR.png" title="source: imgur.com" /></a>
- Nó còn được gọi là Card LAN hoặc Card Ethernet hoặc Network adapter.
- NIC có một địa chỉ 48 bit duy nhất được gọi là địa chỉ Media Access Control (MAC) hoặc Địa chỉ vật lý - Physical Address hoặc Địa chỉ phần cứng - Hardware Address.
- Địa chỉ MAC 48 bit được biểu diễn dưới dạng 12 chữ số thập phân hexa
- Ví dụ: 00-FF-02-AF-82-BC
- NIC có các tốc độ khác nhau 100 Mbps, 1000 Mbps, 10 Gbps, do đó dựa trên yêu cầu có thể sử dụng tốc độ bộ nạp cụ thể của card mạng
- NIC có interface được gọi là đầu nối Registered Jack(RJ)-45

- Xem card mạng:

![Imgur](https://i.imgur.com/ehu33k8.png)

![Imgur](https://i.imgur.com/9djlSot.png)

hoặc
![Imgur](https://i.imgur.com/3xQsvnX.png)

![Imgur](https://i.imgur.com/baUX6Wr.png)

- Lưu thông tin kết nối vào một file, mở cmd gõ:
```
ipconfig > C:\temp\networkinfor.txt
```

Kết quả:
![Imgur](https://i.imgur.com/idUFzJo.png)


<h3> Phương tiện - Các loại cáp</h3>

- 2 loại cáp quan trọng:
S.No | Category | DTR | Purpose | Connector |
|:---:|:---:|:---:|:---:|:---:|
1 | CAT 5 | 100 Mb/giây | Fast Ethernet | RJ-45
2 | CAT 6 | 1 Gbps | Gigabit Ethernet | RJ-45


<h3>Thiết bị kết nối mạng</h3>

Switch:
- Nó là một thiết bị phần cứng tập trung giao tiếp giữa các thiết bị có dây được kết nối trong một mạng LAN.

Wireless Access Point (WAP):
- Nó là một thiết bị phần cứng tập trung giao tiếp giữa các thiết bị Không dây và có dây trong một mạng LAN.

Router:
- Nó là một thiết bị cho phép giao tiếp giữa hai hoặc nhiều mạng logic khác nhau

Firewall:
- Nó là một thiết bị bảo vệ mạng khỏi bị truy cập trái phép.
- Nó cho phép và từ chối lưu lượng mạng dựa trên chính sách được cấu hình.

<h3>Giao thức mạng</h3>

Các thiết bị sử dụng ngôn ngữ để nói chuyện với nhau hoặc Bộ quy tắc sử dụng để giao tiếp giữa nguồn và đích, ngược lại.

Protocol|Acronym|Description|Example
|---|---|---|---|
IP |Internet Protocol| Ngôn ngữ của Internet và mạng gia đình |Workstation
TCP |Transmission Control Protocol| Giống như ký xác nhận để gửi dữ liệu- Phân phối đảm bảo |Workstation
UDP |User Datagram Protocol| Không xác nhận khi nhận dữ liệu | Phương tiện truyền trực tuyến, Không dây
http (s) |Hypertext Transfer Protocol| Được sử dụng để thực hiện các yêu cầu trang web có thể hiển thị và tải xuống các trang web qua máy khách lưu trữ TCP / IP | vSphere
FTP / SFTP |(Secure)File Transfer Protocol| Được sử dụng để truyền tệp giữa các máy tính trên internet hoặc trong mạng qua TCP / IP | VMware FTP/SFTP Site
Tương tự Https, SFTP, SSH, SMS, SMTP, v.v.,


# Lab - Demo
- Mạng vật lý cơ bản
- Mạng máy chủ ESXi
- vSwitch Creation
- Tạo nhóm cổng mạng VM
- Tạo nhóm cổng hạt nhân VM
- Điều hướng mạng máy chủ ESXi