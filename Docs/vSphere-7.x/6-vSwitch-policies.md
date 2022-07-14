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

---
Sesion 5: vSwitch policies
- Các trường hợp sử dụng vSwitch
- Mạng ESXi - Chính sách vSwitch
- Mạng ESXi - Lệnh
  - Các lệnh này sẽ hữu ích khi **gặp bất kỳ sự cố** nào trên interface đồ hoạ người dùng, khi không thể truy cập máy chủ ESX thông qua giao diện đồ hoạ người dùng
- Mạng ESXi - Lab

# 1. Các trường hợp sử dụng vSwitch
**Trường hợp 1:**
- Chỉ một vswitch
  - Theo cấu hình vmware vsphere, mỗi vswitch hỗ trợ tối đa 4088 port

<a href="https://imgur.com/sKG49Ny"><img src="https://i.imgur.com/sKG49Ny.png" title="source: imgur.com" /></a>

Nhóm cổng **vSwitch**
1. Nhóm cổng **VM**: Chỉ dành cho Mạng máy ảo. Yêu cầu tối thiểu để truy cập máy ảo từ bên trong máy chủ của bạn cần một nhóm cổng VM
2. Nhóm cổng **VMkernel**: Dành cho ESXi Mgmt. & Services (dùng để quản lý ESXi và các dịch vụ của nó:vmontion)


<a href="https://imgur.com/DqgEji5"><img src="https://i.imgur.com/DqgEji5.png" title="source: imgur.com" /></a>

- Mỗi switch ảo nên có tối thiểu 2 NIC với mục đích dự phòng và tối đa chúng ta có thể thêm 16 NIC
- 2 Nhóm cổng này sẽ được tạo mặc định
- Cần nhớ 1 điều: đối với mạng máy ảo chúng ta không cần cung cấp địa chỉ ip nào ở **cấp độ nhóm cổng** mà chúng ta chỉ có thể cung cấp địa chỉ ip trên máy ảo mà khách đang vận hành cấp hệ thống. Chỉ khi nói đến mạng quản lý, chúng ta cần cung cấp địa chỉ ip cho cấp nhóm cổg VMkernel

**Trường hợp 2**
- Nhiều vswitch
  - Trong hình dưới có 5 vswitch nhưng các cổng hoạt động được hỗ trợ tối đa cũng chỉ là 4096. Nó sẽ không hỗ trợ nhiều hơn
  - Trong trường hợp 2 sử dụng từng nhóm cổng thay vì cấu hình tất cả các nhóm cổng trên cùng một vswitch
  - Khi truy cập voà máy chủ ESXi > Network > Port groups, ta có thể tìm thấy tất cả các nhóm cổng
  - VLAN ID là tuỳ chọn, nếu mạng vật lý có số VLAN, chúng ta cần nhập các số VAN đó vào đây, ngược lại có thể để trống giá trị mặc định là 0
  - Và đây được coi là nhóm cổng vswith tiêu chuẩn
<a href="https://imgur.com/HtLQiKn"><img src="https://i.imgur.com/HtLQiKn.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/fF38FfN"><img src="https://i.imgur.com/fF38FfN.png" title="source: imgur.com" /></a>

# 2. Chính sách vSwitch
- Khi click vào option edit vswitch, chúng ta thấy rằng có 3 loại chính sách:
<a href="https://imgur.com/XkAP8TH"><img src="https://i.imgur.com/XkAP8TH.png" title="source: imgur.com" /></a>

- Các chính sách được đặt ở cấp độ chuyển mạch tiêu chuẩn (standard switch level), áp dụng cho tất cả các nhóm cổng trên **vSwitch theo mặc định**.
- **Các chính sách mạng** có sẵn:
1. Security (Bảo mật)
2. Traffic shaping (Định hình lưu lượng)
3. NIC teaming and failover (NIC hợp tác và chuyển đổi dự phòng)
- Các chính sách được xác định ở các cấp độ tiếp theo (subsequent levels):
  - Cấp **vSwitch**:
    - Các chính sách mặc định cho tất cả các cổng trên switch tiêu chuẩn (standard switch).
  - Cấp **nhóm cổng**:
    - Các chính sách hiệu quả: Các chính sách được xác định ở cấp độ này sẽ ghi đè các chính sách mặc định được đặt ở cấp độ vswitch standard.
    - Nên đôi khi ở cấp độ nhóm cổng, chúng ta không cần đặt bất kỳ chính sách nào khi bạn áp dụng chính sách trên vswitch, nó sẽ tự động ghi đè chính sách này sang cấp nhóm.

<a href="https://imgur.com/XkAP8TH"><img src="https://i.imgur.com/XkAP8TH.png" title="source: imgur.com" /></a>

- Trong thực tế, chúng ta không cần sửa đổi bất kỳ điều gì (để mặc định)
- Trong một số tình huống (trong mục đích kiểm toán hoặc muốn phân tích lưu lượng truy cập mạng ESX hoặc muốn xem thông tin điều khiển đầu vào và đầu ra của mạng, kiểm soát đầu vào và đầu ra) ta nên sửa đổi thông tin chính sách vswitch 

Tầm quan trong của các chính sách:
- Trong security, có 3 loại chính sách, một trong 3 loại đó là chế độ Promiscuous, nó hoạt động giống như một bộ phân tích gói có khi là khi gửi bất kỳ thông tin nào từ hệ thống này sang hệ thống khác, tất cả các gói này sẽ được phân tích, nó sẽ tạo một số thông tin nhật ký trên cấp độ kernel esxi host VM
  - Nó sẽ lưu trong nhật ký VMkernel và đôi khi sẽ lưu trong nhật ký hostd 
  - Nó hoạt động giống như một trình phân tích, bất cứ khi nào ta muốn phân tích bất kỳ gói nào giữa nguồn và đích, chúng ta nên bật chính sách bảo mật này đến khi không có yêu cầu nào
- Về chính sách MAC address changes: có nghĩa là nếu muốn giám sát bất kỳ người dùng nào đang cố thay đổi địa chỉ MAC ở cấp độ VM hoặc cấp hệ điều hành Guest, khi đó sẽ có thông báo về điều này
- NIC teaming là các chính sách về NIC, nếu 2 NIC trở nên ta có thể thực hiện cân bằng tải, chuyển đổi dự phòng nếu một NIC bị hỏng
- Về Traffic shaping nói về việc set một số băng thông cho máy chủ, mặc định ở trạng thái Disabled

# 3. Security Policies - Chính sách Bảo mật

**vSphere Admin** có thể xác định các chính sách bảo mật ở cả standard switch level và port group level:
- **Chế độ Promiscuous**:
  - Cho phép một switch ảo (virtual switch) hoặc nhóm cổng chuyển tiếp **tất cả lưu lượng** truy cập bất kể điểm đến.
- **MAC address changes** - Thay đổi địa chỉ MAC:
  - Chấp nhận hoặc từ chối **lưu lượng đến** khi khách thay đổi địa chỉ MAC.
  - Khi địa chỉ MAC bị thay đổi ta sẽ ngay lập tức nhận được cảnh báo
- Forged transmits:
  - Chấp nhận hoặc từ chối **lưu lượng gửi đi** khi khách thay đổi địa chỉ MAC.
    - Này cũng tương tự **MAC address changes**, nhưng thay vì lưu lượng vào thì đó là lưu lượng ra ngoài

<a href="https://imgur.com/XYiPje0"><img src="https://i.imgur.com/XYiPje0.png" title="source: imgur.com" /></a>

# 4. Chính sách hợp tác NIC - NIC teaming Policies
- **NIC Teaming** cho phép nhiều NICS được kết nối với một switch ảo duy nhất để tiếp tục truy cập vào mạng.
  - ví dụ:
    - 1 NIC: tốc độ mạng là 80
    - 2 NIC: tốc độ mạng được chia ra 40 40
- Trong một số trường hợp, nó cũng có thể kích hoạt cân bằng tải nếu phần cứng bị lỗi (quy trình tự động)
- Các tuỳ chọn **Chính sách cân bằng tải**
  - Định tuyến dựa trên **Cổng ảo** gốc
  - Định tuyến dựa trên **Nguồn MAC Hash**
  - Định tuyến dựa trên **IP Hash**
  - Sử dụng **Lệnh chuyển đổi dự phòng** rõ ràng

<a href="https://imgur.com/SYMtANM"><img src="https://i.imgur.com/SYMtANM.png" title="source: imgur.com" /></a>

# 5. NIC Teaming và Cân bằng tải - NIC Teaming and Load Balancing

<a href="https://imgur.com/8Vi6MZ4"><img src="https://i.imgur.com/8Vi6MZ4.png" title="source: imgur.com" /></a>

Chúng ta có thể định cấu hình **các thuật toán cân bằng tải** khác nhau trên vSwitch để xác định cách phân phối lưu lượng mạng giữa các NIC vật lý trong một nhóm NIC.
1. Định tuyến dựa trên **cổng ảo** có nguồn gốc
- Switch ảo chọn các đường uplink dựa trên ID cổng máy ảo trên Switch tiêu chuẩn vSphere
- Ta có 4088 cổng trong đó 1 cổng dành riêng cho 1 nhiệm vụ ảo, mỗi nhiệm vụ dành riêng cho 1 cổng
2. Định tuyến dựa trên **mã nguồn MAC Hash**
- Switch ảo chọn một đường uplink cho một máy ảo dựa trên địa chỉ MAC của máy ảo. Để tính toán đường uplink cho một máy ảo, switch ảo sử dụng địa chỉ MAC của máy ảo và số lượng đường uplink trong nhóm NIC.

3. Định tuyến dựa trên **IP Hash**
- Switch ảo chọn các đường uplink cho các máy ảo dựa trên địa chỉ IP nguồn và đích của mỗi gói tin.

4. Sử dụng **Failover Order** Explicit
- Không có cân bằng tải thực tế nào khả dụng với chính sách này. Switch ảo luôn sử dụng đường uplink lên đứng đầu tiên trong danh sách Adapters hoạt động từ failover order và vượt qua các tiêu chí phát hiện chuyển đổi dự phòng. Nếu không có đường uplink trong danh sách Hoạt động, switch ảo sẽ sử dụng đường uplink lên từ danh sách Dự phòng.

# 6. Phát hiện chuyển đổi mạng dự phòng -Network Failover detection

- **VMkernel** có thể sử dụng **trạng thái liên kết (link status)** hoặc **đèn hiệu (beaconing)** hoặc cả hai để phát hiện lỗi mạng.
- **Beacon Probing** là một trong hai cơ chế phát hiện lỗi NIC có sẵn. Vì vậy nếu có 2 Card trong đó một card bị lỗi, nó sẽ thông báo rằng một trong các NIC lỗi
  - Chúng ta cũng có thể sử dụng công cụ giám sát bên thứ 3 để thay thế
- VMkernel thông báo cho các bộ switch vật lý về những thay đổi trong vị trí thực của địa chỉ MAC.
- **Chuyển đổi dự phòng (Failover)** được **VMkernel** thực hiện dựa trên các tham số có thể định cấu hình:
  - **Failback**: Cách adapter vật lý trở lại hoạt động sau khi khôi phục từ lỗi.
  - **Tùy chọn cân bằng tải (Load-balancing option)**: Sử dụng **thứ tự chuyển đổi dự phòng rõ ràng (explicit failover order)**.
  - Luôn sử dụng đường uplink vmnic ở đầu danh sách bộ điều hợp hoạt động.

<a href="https://imgur.com/DGORDvI"><img src="https://i.imgur.com/DGORDvI.png" title="source: imgur.com" /></a>

# 7. Chính sách Định hình Lưu lượng - Traffic-Shaping Policy
- Định hình lưu lượng mạng (Network traffic shaping) là một cơ chế để hạn chế việc tiêu thụ băng thông mạng có sẵn của một máy ảo.
- Có thể định cấu hình: Tốc độ trung bình, tốc độ đỉnh và kích thước cụm .
  - Băng thông đỉnh nên duy trì 80% (20% làm bộ đệm)
  - Băng thông trung bình là 50%
  - Kích thước cụm là thời gian chúng ta cần gửi lưu lượng truy cập
  - Chính sách này có thể áp dụng cho từng VM levels, nó không áp dụng cho tất cả các vm
- Traffic shaping controls chỉ kiểm soát lưu lượng đi, tức là lưu lượng đi từ máy ảo đến switch ảo và ra vào mạng vật lý.

<a href="https://imgur.com/Z6tMf4b"><img src="https://i.imgur.com/Z6tMf4b.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/yuQ9lhX"><img src="https://i.imgur.com/yuQ9lhX.png" title="source: imgur.com" /></a>

# 8. Lệnh
Một số lệnh quan trọng
| Chức năng                                                                 | Command                                 |
| ------------------------------------------------------------------------- | --------------------------------------- |
| Để lấy các card Mạng có sẵn trên máy chủ ESXi                             | `esxcfg-nics -l`                        |
| Để chỉ hiển thị default gateway                                           | `esxcfg-route`                          |
| Để tải các nhóm cổng vmkernel có sẵn trên máy chủ ESXi                    | `esxcfg-vmknic -l`                      |
| Để nhận thông tin về switch ảo có sẵn trên máy chủ ESXi                   | `esxcfg-vswitch -l`                     |
| Số tùy chọn có sẵn cho cài đặt mạng esxcli                                | `esxcli network`                        |
| Để liệt kê các kết nối đã thiết lập trên máy chủ của chúng tôi (Netstat)  | `esxcli network ip connection list`     |
| Để liệt kê cấu hình địa chỉ IP cho các cổng VMkernel                      | `esxcli network ip interface ipv4 get`  |
| Để liệt kê các giao diện vmkernel và cấu hình của chúng                   | `esxcli network ip interface list`      |
| Để liệt kê thông tin máy chủ hàng xóm hoặc bảng ARP trên máy chủ ESXi     | `esxcli network ip neighbor list`       |
| Để liệt kê bảng định tuyến của máy chủ lưu trữ                            | `esxcli network ip route ipv4 list`     |
| Để xem Cấu hình NIC Vật lý                                                | `esxcli network nic`                    |
| Tắt mạng vmnic                                                            | `esxcli network nic down-n=vmnic_name`  |
| Để liệt kê tất cả NICS có trong danh sách nic mạng Esxi host              | `esxcli network nic list`               |
| Để kiểm tra các thuộc tính của một số liệu thống kê mạng vmknic           | `esxcli network nic stats get-n vmnico` |
| Để kết nối lại mạng vmnic                                                 | `esxcli network nic up-navmnic_name`    |
| Để liệt kê cấu hình vswitch hiện tại                                      | `esxcli network vSwitch standard list`  |
| Để kiểm tra kết nối trên cổng                                             | `nc-z dest-ip dest-port`                |
| Kiểm tra kết nối với máy chủ ESXi từ xa bằng các tiện ích ping và vmkping | `vmkping <IP>`                          |

# ESXi Networking - lab:
> Thực hiện lab trên 2 ESXi cho 2 [trường hợp sử dụng vswitch](#1-các-trường-hợp-sử-dụng-vswitch)

1. Tạo vSwitch
2. Tạo nhóm Cổng VM
3. Tạo nhóm Cổng VMkernel
4. Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng
5. Tuân thủ Chính sách kết nối vSwitch
6. Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.
7. Loại bỏ vSwitch, nhóm cổng, uplink

> Xem lab: [ESXi Networking](../../Lab/4-ESXi-host-networking.md) 

[Imgur](https://i.imgur.com/Z6tMf4b.png)