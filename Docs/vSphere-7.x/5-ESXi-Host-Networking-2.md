<h1> ESXi Host Networking: Standard vSwitch</h1>

<h2>Summary</h2>

- [1. Khái niệm mạng ESXi](#1-khái-niệm-mạng-esxi)
  - [1.1 Physical Switch](#11-physical-switch)
  - [1.2 Physical Network](#12-physical-network)
  - [1.3 Virtual Network](#13-virtual-network)
- [2. vSphere Standard Switch (vSS) hoặc vSwitch](#2-vsphere-standard-switch-vss-hoặc-vswitch)
- [3. Group Port](#3-group-port)
- [4. Host ESXi - Tối đa hóa mạng](#4-host-esxi---tối-đa-hóa-mạng)
- [Kiến trúc mạng ESXi](#kiến-trúc-mạng-esxi)
- [Các loại vSwitch](#các-loại-vswitch)
- [Mạng ESXi - lab](#mạng-esxi---lab)

# 1. Khái niệm mạng ESXi

## 1.1 Physical Switch
<a href="https://imgur.com/U84vH3u"><img src="https://i.imgur.com/U84vH3u.png" title="source: imgur.com" width=45% align=right /></a>

Một physical network switch là một **thiết bị phần cứng** được sử dụng để **kết nối các thiết bị** và cho phép chúng **giao tiếp** qua mạng

  - *Giả sử trong mạng văn phòng ta có `50 máy tính`, để `giao tiếp` giữa tất cả 50 máy tính, chúng tôi cần một `switch vật lý`*
  - *Nếu không có `switch vật lý` nào (như sơ dồ bên phải ta có `4 hệ thống` và mỗi hệ thống đều có `1 interface mạng` hay còn gọi là `NIC`, `mặc định` chỉ có một cổng.):*
      - *Vì chỉ có 1 cổng nên ta có thể kết nối với một hệ thống khác hoặc có thể kết nối hệ thông một hoặc đến hệ thống 2 hoặc 3,..*
      - *Nếu muốn truy cập từ hệ thống 1 cùng lúc tất cả nhiều thiết bị trong mạng, không có cách trực tiếp nào nếu sử dụng 1 cáp duy nhất*
  - Vì vậy nếu không có sw, rất khó để truy cập vào tất cả hệ thống mạng của chúng ta


- Một physical ethernet switch quản lý lưu lượng mạng giữa các máy trong mạng vật lý.
<a href="https://imgur.com/0hrJ5EM"><img src="https://i.imgur.com/0hrJ5EM.png" title="source: imgur.com" width=55% align=right /></a>

- Một switch có nhiều cổng, mỗi cổng có thể được kết nối với một máy duy nhất **hoặc một switch khác trong mạng**.
- **Mỗi cổng có thể được cấu hình** để hoạt động **theo những cách nhất định** tùy thuộc vào **nhu cầu** của máy kết nối với nó.
- Switch là cốt lõi của một mạng vật lý. **Nhiều thiết bị** switch có thể được kết nối với nhau để tạo thành **mạng lớn hơn**.

## 1.2 Physical Network
<a href="https://imgur.com/EfajAEk"><img src="https://i.imgur.com/EfajAEk.png" title="source: imgur.com" width=55% align=right /></a>

- Là một mạng **các máy vật lý** được kết nối để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau. **VMware ESXi** chạy trên một máy vật lý.
    - Ngay cả VMware ESXi cũng vậy, nó cũng cần một thiết bị switch vật lý để kết nối tất cả các máy chủ esx
    - Nó đang chạy giữa mạng vật lý và mạng ảo (Virtual Network)

## 1.3 Virtual Network
<a href="https://imgur.com/WOxUrjS"><img src="https://i.imgur.com/WOxUrjS.png" title="source: imgur.com" width=60% align=right /></a>

- Một mạng **các máy ảo** chạy trên một máy vật lý được kết nối logic với nhau để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau.
- Máy ảo có thể được kết nối với mạng ảo mà chúng ta tạo ra khi chúng ta thêm 1 mạng
    - Trong khi tạo máy ảo, Chúng ta quan sát thấy mỗi máy ảo đều có các thành phần ảo: vcpu, vmemory, vdisk và v-interface
    - Tương tự như hệ thống mạng vật lý, muốn giao tiếp giữa các máy ảo, chúng ta cần một vSwitch ảo.
    - Mặc định máy chủ ESX sẽ tạo ra một switch ảo (switch logic)
- Trong hình, biểu tượng màu xám này được hiểu là một vSwitch, nó được kết nối với card NIC vật lý (Trong esx, quy ước đặt tên adapter vật lý được đặt thành vmnic0 )
- Thành phần chính của máy chủ ESXi là VM kernel - hệ điều hành lõi ESXi, vì vậy để quản lý máy chủ ESXi chúng ta cần một nhóm cổng VM kernel để quản lý các máy ảo
# 2. vSphere Standard Switch (vSS) hoặc vSwitch
<a href="https://imgur.com/WOxUrjS"><img src="https://i.imgur.com/WOxUrjS.png" title="source: imgur.com" width=60% align=right /></a>

- Nó hoạt động giống như một **physical switch**.
- vSwitch tạo liên kết giữa NIC vật lý và NICS ảo
- Virtual switch cung cấp kết nối giữa **các máy ảo** trên cùng một host **hoặc** trên **các host khác nhau** (thông quan Physical Adapters).
- Mặc dù một switch tiêu chuẩn vSphere hoạt động giống như một switch vật lý, nó **không có một số chức năng nâng cao** của một switch vật lý.

Ví dụ
- Một vSwitch không thể kết nối trực tiếp với một vSwitch khác trong hộp ESXi mà nó sẽ kết nối từ vswitch kết nối đến physical adapter rồi nó mới kết nối đến vswitch khác.

**Uplink Port**
- Chính là card mạng vật lý trên mỗi host ESXi
- Để các máy ảo ở các host ESXi liên lạc với nhau và liên lạc với bên ngoài

<a href="https://imgur.com/KmfesN5"><img src="https://i.imgur.com/KmfesN5.png" title="source: imgur.com" /></a>

# 3. Group Port
<a href="https://imgur.com/3Pq1ClZ"><img src="https://i.imgur.com/3Pq1ClZ.png" title="source: imgur.com" width=45% align=right /></a>

- Dùng để nhóm các port trong vswitch
- 2 nhóm cổng được tạo tự động khi cài đặt ESXi
  - một nhóm dành riêng cho mạng máy ảo
  - một nhóm cổng khác dành riêng cho mạng quản lý 

1. **VM Port Group**:
- Quản lý mạng máy ảo.

2. **VM Kernel Port Group**:
- Cung cấp các kết nối IP storage, vSphere vMotion, Fault Tolerance (FT), VSAN, Cấp phép, v.v. (Đề cập ở phần vCenter)

Đoạn 22:50
<a href="https://imgur.com/3iQgOpX"><img src="https://i.imgur.com/3iQgOpX.png" title="source: imgur.com" /></a>

# 4. Host ESXi - Tối đa hóa mạng

Mạng ESXi
- Tổng số cổng Switch Mạng ảo trên **mỗi host /host ESXi**: 4096
- Tổng Nhóm cổng trên mỗi vSphere standard switch **(vSS)**: 512
- Tổng **NICs** vật lý 10 Gbps /20 Gbps /25 Gbps trên mỗi host: 16

# Kiến trúc mạng ESXi

<a href="https://imgur.com/Bg4gQlM"><img src="https://i.imgur.com/Bg4gQlM.png" title="source: imgur.com" /></a>

- Về mặt vật lý, các VLAN có thể được kết nối với các cổng mà host ESXi đã chỉ định.
- Do đó, tất cả các mạng có thể được hiển thị cho máy ảo khi thích hợp, nhưng vẫn duy trì tính bảo mật cần thiết trong doanh nghiệp

# Các loại vSwitch

Mạng ảo hỗ trợ các loại thiết bị vSwitch sau:

- **Standard switches (VSS)**: Quản lý network các máy ảo ở mức độ host.
  - Có sẵn trên ESXi, vSphere
    - Cấu hình switch ảo cho một host duy nhất.

- **Distributed switches(DVS)**: Quản lý network các VM ở mức độ Datacenter, dùng để quản lý tập trung, không có sẵn trong vSphere.
  - Switch ảo được cấu hình cho toàn bộ data Center.
  - Có thể gắn tới 2.000 host trên cùng một Distributed switch.
  - Cấu hình nhất quán trên tất cả các host được đính kèm.
  - Các host phải có giấy phép **Enterprise Plus** hoặc thuộc cụm vSAN.

Cả hai loại switch đều có tính elastic-đàn hồi (Flexible-Linh hoạt): các cổng được tạo và loại bỏ tự động.

# Mạng ESXi - lab

1. Tạo vSwitch

2. Tạo nhóm Cổng VM

3. Tạo nhóm Cổng VMkernel

4. Thêm NIC hoặc Uplinks vào vSwitch để dự phòng

5. Tuân thủ Chính sách kết nối vSwitch

> [Xem bài lab](../../Lab/4-ESXi-host-networking.md)