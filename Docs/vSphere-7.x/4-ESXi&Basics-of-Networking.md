<h1> ESXi Networking</h1>

<h2>Summary</h2>

- [I. Khái niệm cơ bản về mạng](#i-khái-niệm-cơ-bản-về-mạng)
  - [1. Khái niệm Mạng Cơ bản](#1-khái-niệm-mạng-cơ-bản)
  - [2. Loại Network](#2-loại-network)
  - [3. Yêu cầu cơ bản để hình thành Mạng](#3-yêu-cầu-cơ-bản-để-hình-thành-mạng)
  - [Lab - Demo](#lab---demo)
- [II. IP Addressing](#ii-ip-addressing)
  - [1. Địa chỉ IP cơ bản](#1-địa-chỉ-ip-cơ-bản)
  - [2.Địa chỉ Internet Protocol (IP)](#2địa-chỉ-internet-protocol-ip)
  - [3.Loại địa chỉ IP](#3loại-địa-chỉ-ip)
- [III. Phân loại địa chỉ IP & Resered IPs](#iii-phân-loại-địa-chỉ-ip--resered-ips)
  - [1. Phân loại địa chỉ IP - Tổng quan](#1-phân-loại-địa-chỉ-ip---tổng-quan)
  - [2. Phân loại địa chỉ IP -Khái niệm Bit ưu tiên](#2-phân-loại-địa-chỉ-ip--khái-niệm-bit-ưu-tiên)
  - [3. Địa chỉ IP Network, Valid & Broadcast](#3-địa-chỉ-ip-network-valid--broadcast)
  - [4. Địa chỉ IP Private](#4-địa-chỉ-ip-private)
  - [5. Địa chỉ IP Public](#5-địa-chỉ-ip-public)
  - [6. Địa chỉ IP Private vs IP Public](#6-địa-chỉ-ip-private-vs-ip-public)
  - [7. Địa chỉ IP Loopback](#7-địa-chỉ-ip-loopback)
  - [8. IP static so với IP dynamic](#8-ip-static-so-với-ip-dynamic)
  - [9. Automatic Private IP Addressing - IP (APIPA):](#9-automatic-private-ip-addressing---ip-apipa)
  - [10. Subnet Mask](#10-subnet-mask)
  - [11. Default Gateway](#11-default-gateway)
  - [12. Các tình huống thực tế của mạng:](#12-các-tình-huống-thực-tế-của-mạng)
  - [13. Các lệnh Networking Cơ bản:](#13-các-lệnh-networking-cơ-bản)
  - [14. IPv6](#14-ipv6)
  - [15. Khái niệm vSphere Network](#15-khái-niệm-vsphere-network)
  - [16. Switch tiêu chuẩn vSphere - vSphere Standard Switch](#16-switch-tiêu-chuẩn-vsphere---vsphere-standard-switch)

---
- Các khái niệm cơ bản về mạng
- Các kịch bản thời gian thực kết nối mạng
- Mạng host ESXi
- Kiến trúc Standard Switch vSphere
- Mạng vật lý cơ bản - Lab
- Mạng host ESXi (Mạng ảo - Virtual Networking) - Lab
# I. Khái niệm cơ bản về mạng
## 1. Khái niệm Mạng Cơ bản
- Network: Kết nối giữa hai hoặc nhiều thiết bị được gọi là network.
- Kết nối mạng - Networking: Giao tiếp giữa hai hoặc nhiều thiết bị được kết nối với nhau được gọi là Networking.
- Có thể thiết lập kết nối giữa các thiết bị với sự trợ giúp của Switch hoặc Điểm truy cập không dây để truyền dữ liệu.
  - Ví dụ.:
    - Máy trạm: Laptop, desktop, Server.
    - Thiết bị mạng: Switch, router, Wireless Access Point(WAP)Mobile, Tab, Printers, Scanners, v.v.,

- Các thiết bị mạng: Home, office
![Imgur](https://i.imgur.com/h6yJpJ9.png)
## 2. Loại Network
Mạng được sử dụng phổ biến:
- LAN: Mạng cục bộ - Local Area Network
  - Mạng cục bộ được sử dụng để kết nối kết nối giữa các hệ thống và các thiết bị Mạng khác rất gần nhau trong một khu vực hạn chế như tầng của một tòa nhà, tòa tháp văn phòng hoặc trong khuôn viên:
- WAN: Mạng diện rộng - Wide Area Network
  - Mạng diện rộng kết nối hai hoặc nhiều LANS có mặt tại các vị trí địa lý (Địa lý) khác nhau

## 3. Yêu cầu cơ bản để hình thành Mạng
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


## Lab - Demo
- Mạng vật lý cơ bản
- Mạng máy chủ ESXi
- vSwitch Creation
- Tạo nhóm cổng mạng VM
- Tạo nhóm cổng hạt nhân VM
- Điều hướng mạng máy chủ ESXi

# II. IP Addressing

- Tầm quan trong của NIC: Cho phép bạn kết nối từ hệ thống này sang hệ thống khác
- Mỗi NIC  luôn có một địa chỉ MAC duy nhất
- NIC > Network Adapters > Phiên bản mới nhất hiện tại là VMXNET3
- Để sửa: Virtual Machines> Chọn VM> Edit settings > Network Adapter 1
## 1. Địa chỉ IP cơ bản
- Tất cả các máy tính hoạt động bằng hệ nhị phân (Binary system) .
- Hệ nhị phân (cơ số 2) chỉ sử dụng các chữ số 0 và 1
- Hệ thập phân (cơ số 10) sử dụng các chữ số từ 0 đến 9.
- IPv4 bao gồm các số nhị phân 32 bit được chia thành 4 bộ 8 bit, được gọi là Octants.
- Phạm vi: từ 00000000.00000000.00000000.00000000 đến 11111111.11111111.11111111.111111111
- Bit = 1 chữ số là: Một (1) hoặc Không (0)
- Byte = 8 bit
- Octant = 1 Byte hoặc 8 Bit


## 2.Địa chỉ Internet Protocol (IP)
- Địa chỉ IP là địa chỉ lôgic hoặc địa chỉ định danh duy nhất.
- Bất kỳ hai thiết bị nào trên internet không bao giờ có thể có cùng một địa chỉ tại cùng một thời điểm.
- Địa chỉ IP là một địa chỉ phân cấp và bao gồm hai phần:
  - 1) Phần địa chỉ mạng (Network ID)
  - 2) Thành phần địa chỉ máy chủ (Host ID)

<a href="https://imgur.com/qgxukKf"><img src="https://i.imgur.com/qgxukKf.png" title="source: imgur.com" /></a>

## 3.Loại địa chỉ IP
- Có hai phiên bản địa chỉ IP
1. IP phiên bản 4 (IPv4): Đây là một địa chỉ 32 bit
2. IP phiên bản 6 (IPv6): Đây là một Địa chỉ 128-bit
- IPv4 đã được sử dụng kể từ khi có Internet và được triển khai rộng rãi trên Internet, mạng gia đình và mạng văn phòng
- IPv4 có 32 bit được chia thành 4 Octants và thường được hiển thị ở dạng Dotted Decimal Notation (DDN). Ví dụ: 192.168.10.71
- Khi hết địa chỉ IPv4, địa chỉ IPv6 sẽ thay thế IPv4. IPv6 cung cấp 128 bit địa chỉ.


# III. Phân loại địa chỉ IP & Resered IPs

- Phân loại địa chỉ IP - Tổng quan
- Khái niệm Bit ưu tiên & Định dạng Octet
- Dải địa chỉ IP đặc biệt
- Mặt nạ mạng con, Cổng mặc định
- Các kịch bản thời gian thực kết nối mạng
- Các lệnh mạng cơ bản
- Câu đố - Chỉ để kiểm tra kiến ​​thức của chúng tôi
## 1. Phân loại địa chỉ IP - Tổng quan

- Địa chỉ IP mạng - Network IP Addresses
- Địa chỉ IP hợp lệ -  Valid IP Address
- Phát địa chỉ IP -  Broadcast IP Addresses
- Địa chỉ IP riêng -  Private IP Addresses
- Địa chỉ IP công cộng -  Public IP Addresses
- Địa chỉ IP lặp lại -  Loopback IP Address
-  Địa chỉ IP tĩnh -  Static IP Address
- Địa chỉ IP động -  Dynamic IP Address
- Địa chỉ IP APIPA -  APIPA IP Address
- Địa chỉ IP miễn phí Free IP Address

## 2. Phân loại địa chỉ IP -Khái niệm Bit ưu tiên

Bit ưu tiên - Priority Bit:
- Bit ưu tiên được sử dụng để phân loại địa chỉ IP.
- Hầu hết (các) bit Quan trọng hoặc bit Thứ tự cao từ octet đầu tiên được chọn cho (các) Bit Ưu tiên

Phạm vi Class A-Octet đầu tiên

Phạm vi Class B-Octet đầu tiên

Dải Class C-Octet đầu tiên

## 3. Địa chỉ IP Network, Valid & Broadcast

Địa chỉ IP mạng - Network IP Address:
- Địa chỉ IP với tất cả các bit là ZERO trong phần host.

Địa chỉ IP Truyền rộng - Broad Cast IP Address:
- Địa chỉ IP với tất cả các bit là ONES trong phần host.
Địa chỉ IP hợp lệ - Valid IP Addresses:
- Giữa địa chỉ mạng và địa chỉ truyền rộng.
- Chỉ Địa chỉ IP hợp lệ mới được chỉ định cho máy chủ và máy khách.

## 4. Địa chỉ IP Private
- Có một số dải địa chỉ IP nhất định trong mỗi lớp địa chỉ IP được dành riêng cho private network.
- Các địa chỉ IP này được gọi là Địa chỉ IP Private. Những địa chỉ này không thể định tuyến hoặc hợp lệ trên Internet.
- Khi một mạng sử dụng địa chỉ private kết nối internet, cần phải dịch địa chỉ IP Riêng thành Địa chỉ IP Public. Quá trình dịch này được gọi là Network Address Translation (NAT).
- Một router thường là thiết bị mạng thực hiện NAT.

## 5. Địa chỉ IP Public

- Địa chỉ IP Public là Địa chỉ IP có thể được truy cập trực tiếp qua internet và được Nhà cung cấp dịch vụ Internet (Internet Service Provider - ISP) hoặc Cơ quan cấp số được chỉ định Internet (Internet Assigned Numbers Authority - IANA) chỉ định cho bộ định tuyến mạng.
- (Các) thiết bị cá nhân  cũng có một IP private bị ẩn khi chúng ta kết nối với internet thông qua IP public của router. Mỗi khách hàng sử dụng (các) IP Public cần phải trả phí cho ISP hoặc IANA.
- Các Host Internet yêu cầu Địa chỉ IP Public, duy nhất nhưng các host private có thể có bất kỳ Địa chỉ IP private hợp lệ nào duy nhất trong mạng riêng.

## 6. Địa chỉ IP Private vs IP Public 

STT | IP Private| IP Public
|---|---|---|
1 | Được sử dụng trong Tổ chức (tức là Mạng riêng - Network Private hoặc LAN) | Được sử dụng trên Internet (tức là Mạng công cộng - Network Public hoặc WAN)
2 | Không được công nhận qua Internet | Được công nhận qua Internet
3 | Được chỉ định bởi Kỹ sư mạng (Network Engineer) hoặc Quản trị viên | Do ISP hoặc IANA chỉ định
4 | Nó phải là duy nhất trong mạng LAN hoặc Tổ chức hoặc Home N/W. | Nó phải là duy nhất trên Internet hoặc Toàn cầu.
5 | Tìm thấy qua cài đặt nội bộ thiết bị của bạn - ipconfig, ifconfig | Tìm thấy bởi Google: "what is my IP address?"
6 | Miễn phí | Cần mua từ Nhà cung cấp dịch vụ Internet (ISP)
7 | Dải IP Private <br> 10.0.0.0-10.255.255.255 <br> 172.16.0.0-172.31.255.255 <br> 192.168.0.0-192.168.255.255 <br> <br> Ví dụ: 192.168.10.71, 192.168.10.72 | Bất kỳ số nào không có trong dải địa chỉ IP Private đều được coi là Ip Public <br> <br> Ví dụ: 8.8.8.8, 12.73.94.56

## 7. Địa chỉ IP Loopback

- Địa chỉ loopback là một địa chỉ IP dành riêng có thể được sử dụng để kiểm tra, chẩn đoán thiết bị.
- Dải IP Loopback bắt đầu từ 127.0.0.0 kết thúc tại 127.255.255.255
- Địa chỉ loopback 127.0.0.1 thường được gọi là `localhost` và nó được `sử dụng để kiểm tra thẻ NIC` để xác minh rằng `nó đang gửi và nhận tín hiệu`.
- Để `kiểm tra một card mạng` bằng địa chỉ loopback, chúng ta có thể sử dụng tiện ích `TCP/IP Ping`.
- `ping 127.0.0.1`> Nếu lệnh thành công, Nhận Reply từ 127.0.0.1
  - Điều này cho thấy rằng card mạng và drivers đang hoạt động bình thường.
- Nếu tiện ích Ping không thể return card mạng, điều này có thể cho thấy sự cố driver hoặc sự cố vật lý với card.

## 8. IP static so với IP dynamic

IP static:
- Là IP được gán theo cách thủ công.
- Servers và các thiết bị mạng khác được cấu hình bằng IP tĩnh
- Nó luôn là Địa chỉ IP cố định và cần được sửa đổi Khi có bất kỳ thay đổi nào về mạng.

IP dynamic:
- Nó có nghĩa là IP được gán tự động.
- IP động là giải pháp tốt nhất khi chúng ta có nhiều máy Client.
- DHCP Server sẽ tự động gia hạn Địa chỉ IP theo lease period (Thời gian thuê). Ví dụ: 8 ngày, 10 ngày.

## 9. Automatic Private IP Addressing - IP (APIPA):

- Khi client hoặc máy trạm (workstations) không thể truy cập Máy chủ DHCP và nó sẽ nhận được một Địa chỉ IP tạm thời thay thế được gọi là IP APIPA.
- Hệ thống tự chọn địa chỉ IP trong dải từ 169.254.1.0 đến 169.254.254.255.
- Theo mặc định, giao thức APIPA được bật.
- Cách tìm Trạng thái IP APIPA
  - Start > Run > ncpa.cpl
  - Chọn Specific Network Properties
  - Chọn TCP/IPv4 > Nhấp vào Properties
  - Đi tới Tab > Alternate Configuration > APIPA

- Commands: ipconfig/release, ipconfig/renew

## 10. Subnet Mask

- Subnet Mask tách biệt phần Network (N) và Host (H) của Địa chỉ IP.
- Được đại diện với tất cả các số 1 trong phần Network và với tất cả các chữ O trong phần Host.

## 11. Default Gateway

- Default Gateway là thiết bị chuyển tiếp dữ liệu từ mạng này sang mạng khác.
- Hầu hết thường là một router.
- Các cổng mạng mặc định cũng có thể được cấu hình bằng máy tính thay vì router.

## 12. Các tình huống thực tế của mạng:

Kịch bản 1:
- Một trong các Tổ chức có 75 Máy trạm và 5 Máy chủ.
- Loại Địa chỉ IP nào được ưu tiên cho Mạng?
- Nó có 5 phòng ban (Ví dụ: Nhân sự, Bán hàng, Sản xuất, QA & Dev, hỗ trợ CNTT và các bộ phận khác)

Kịch bản -2
- Một trong các Tổ chức có 120 Máy trạm và 10 Máy chủ.
- Loại Địa chỉ IP nào được ưu tiên cho Mạng?
- Nó có 6 đội. Nhưng giao tiếp giữa các đội nên không thể thực hiện được?

## 13. Các lệnh Networking Cơ bản:

**Ipconfig / Ifconfig:**

- Lệnh này được sử dụng để hiển thị thông tin về cấu hình mạng và refresh DHCP và DNS Settings.
- Theo mặc định, lệnh ipconfig hiển thị Địa chỉ IP, Subnet Mask và Default gateway.
- Để hiển thị info chi tiết: sử dụng ipconfig/all; Ifconfig

**Ping: Packet Internet Groper..**
- Ping là một tiện ích quản trị mạng máy tính được sử dụng để kiểm tra khả năng truy cập của một host trên Mạng IP. 
- Lệnh: `ping <Địa chỉ IP>`

**Traceroute:**
- Traceroute là một tiện ích chẩn đoán mạng máy tính được sử dụng để xem đường đi (path) của các gói tin qua mạng IP.
- Lệnh:
  - Đối với Hệ thống Windows: `tracert <Địa chỉ IP>`
  - Đối với Hệ thống Linux: `traceroute <Địa chỉ IP>`

**Netstat: Network Statistics** - *Thống kê mạng*
- Cho phép Hiển thị số liệu thống kê giao thức số cổng đã sử dụng, địa chỉ local và địa chỉ foreign và các kết nối mạng TCP/IP hiện tại.
- Lệnh: `netstat -a`

**Nslookup: Name Server Lookup** - *Tra cứu Máy chủ Định danh*
- Đây là một lệnh hữu ích để lấy thông tin từ máy chủ DNS.
- Nó là một công cụ quản trị mạng để truy vấn Hệ thống tên miền (Domain Name System - DNS) để lấy tên miền hoặc ánh xạ (mapping) địa chỉ IP hoặc bất kỳ bản ghi DNS cụ thể nào khác. 
- Nó cũng được sử dụng để khắc phục sự cố liên quan đến DNS.
- Lệnh: `Nslookup <tên máy chủ hoặc địa chỉ IP> '

**Telnet: Teletype Network**
- Nó sử dụng giao thức TCP/IP để thiết lập kết nối với máy tính từ xa.
- Một trong những công dụng chính của lệnh telnet là kiểm tra xem một cổng cụ thể có đang lắng nghe trên máy chủ hay không.
- Lệnh: `telnet [hostname / ipaddress] [port number]`

## 14. IPv6
- IPv6 là địa chỉ 128 bit và nó được chia thành các ranh giới 16 bit, và mỗi khối 16 bit được chuyển đổi thành số thập lục phân 4 chữ số và được phân tách bằng dấu hai chấm.
- Đó là ký hiệu Colon-Hex.

##  15. Khái niệm vSphere Network

**Physical Network:**
- Một mạng các máy vật lý được kết nối để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau. VMware ESXi chạy trên một máy vật lý.

**Virtual Network:**
- Một mạng các máy ảo chạy trên một máy vật lý được kết nối logic với nhau để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau. Máy ảo có thể được kết nối với mạng ảo mà bạn tạo khi thêm một mạng

Physical Switch:
- Một bộ chuyển mạch ethernet vật lý quản lý lưu lượng mạng giữa các máy trong mạng vật lý.
- Một switch có nhiều cổng, mỗi cổng có thể được kết nối với một máy duy nhất hoặc một switch khác trong mạng.
- Mỗi cổng có thể được cấu hình để hoạt động theo những cách nhất định tùy thuộc vào nhu cầu của máy kết nối với nó.
- Switch là cốt lõi của một mạng vật lý. Nhiều thiết bị switch có thể được kết nối với nhau để tạo thành mạng lớn hơn.

## 16. Switch tiêu chuẩn vSphere - vSphere Standard Switch
- Nó hoạt động giống như một switch Ethernet vật lý.
- Nó phát hiện máy ảo nào được kết nối hợp lý với mỗi cổng ảo của nó và sử dụng thông tin đó để chuyển tiếp lưu lượng đến đúng máy ảo.
- Một switch tiêu chuẩn vSphere có thể được kết nối với switch vật lý bằng cách sử dụng Adapter Ethernet vật lý, còn được gọi là **uplink**
- Kiểu kết nối này tương tự như kết nối các switch vật lý với nhau để tạo ra một mạng lớn hơn.
- Mặc dù một vSphere Standard Switch hoạt động giống như một switch vật lý,nhưng nó không có một số chức năng nâng cao của một switch vật lý.