<h1> ESXi Host Networking: Standard vSwitch</h1>

<h2>Summary</h2>

- [Khái niệm mạng ESXi](#khái-niệm-mạng-esxi)
  - [Physical Switch](#physical-switch)
  - [Physical Network](#physical-network)
  - [Virtual Network](#virtual-network)
- [vSphere Standard Switch (vSS) hoặc vSwitch](#vsphere-standard-switch-vss-hoặc-vswitch)
- [Các Group Port vSwitch](#các-group-port-vswitch)
- [Tối đa hóa mạng máy chủ ESXi](#tối-đa-hóa-mạng-máy-chủ-esxi)
- [Kiến trúc mạng ESXi](#kiến-trúc-mạng-esxi)
- [Các loại công tắc ảo](#các-loại-công-tắc-ảo)
- [Mạng ESXi - lab](#mạng-esxi---lab)

# Khái niệm mạng ESXi

## Physical Switch
<a href="https://imgur.com/U84vH3u"><img src="https://i.imgur.com/U84vH3u.png" title="source: imgur.com" width=45% align=right /></a>

- Một physical network switch là một thiết bị phần cứng được sử dụng để kết nối các thiết bị và cho phép chúng giao tiếp qua mạng


- *Giả sử trong mạng văn phòng,ta có 50 máy tính, để giao tiếp giữa tất cả 50 máy tính, chúng tôi cần một switch vật lý*
- *Nếu không có switch vật lý nào, như sơ dồ bên phải, ta có 4 hệ thống và mỗi hệ thống đều có 1 interface mạng hay còn gọi là NIC, mặc định chỉ có một cổng.*
    - *Từ việc chỉ có một cổng, ta có thể kết nối với một hệ thống khác, hoặc có thể kết nối hệ thông một đến hệ thống 2 hoặc 3,..*
    - *Nếu muốn truy cập từ hệ thống 1 cùng lúc tất cả nhiều thiết bị trong mạng, không có tuỳ chọn trục tiếp nào bằng cách sử dụng 1 cáp duy nhất, vì vậy nếu k có sw, rất khó để truy cập vào tất cả hệ thống mạng của chúng ta*

<a href="https://imgur.com/AxNwTfI"><img src="https://i.imgur.com/AxNwTfI.png" title="source: imgur.com"  width=55%  /></a>

- Một physical ethernet switch quản lý lưu lượng mạng giữa các máy trong mạng vật lý.
<a href="https://imgur.com/0hrJ5EM"><img src="https://i.imgur.com/0hrJ5EM.png" title="source: imgur.com" width=55% align=right /></a>

- Một switch có nhiều cổng, mỗi cổng có thể được kết nối với một máy duy nhất **hoặc một switch khác trong mạng**.
- Mỗi cổng có thể được cấu hình để hoạt động theo những cách nhất định tùy thuộc vào nhu cầu của máy kết nối với nó.
- Switch là cốt lõi của một mạng vật lý. Nhiều thiết bị chuyển mạch có thể được kết nối với nhau để tạo thành mạng lớn hơn.

## Physical Network
<a href="https://imgur.com/EfajAEk"><img src="https://i.imgur.com/EfajAEk.png" title="source: imgur.com" width=55% align=right /></a>

- Là một mạng các máy vật lý được kết nối để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau. VMware ESXi chạy trên một máy vật lý.
    - Ngay cả VMware ESXi cũng vậy, nó cũng cần một thiết bị switch vật lý để kết nối tất cả các máy chủ esx
    - Nó đang chạy giữa mạng vật lý và mạng ảo (Virtual Network)

## Virtual Network
<a href="https://imgur.com/WOxUrjS"><img src="https://i.imgur.com/WOxUrjS.png" title="source: imgur.com" width=60% align=right /></a>

- Một mạng các máy ảo chạy trên một máy vật lý được kết nối logic với nhau để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau.
- Máy ảo có thể được kết nối với mạng ảo mà chúng ta tạo ra khi chúng ta thêm 1 mạng
    - Trong khi tạo máy ảo, Chúng ta quan sát thấy mỗi máy ảo đều có các thành phần ảo: vcpu, vmemory, vdisk và v-interface
    - Tương tự như hệ thống mạng vật lý, muốn giao tiếp giữa các máy ảo, chúng ta cần một vSwitch ảo.
    - Mặc định máy chủ ESX sẽ tạo ra một switch ảo (switch logic)
- Trong hình, biểu tượng màu xám này được hiểu là một vSwitch, nó được kết nối với card NIC vật lý (Trong esx, quy ước đặt tên adapter vật lý được đặt thành vmnic0 )
- Thành phần chính của máy chủ ESXi là VM kernel - hệ điều hành lõi ESXi, vì vậy để quản lý máy chủ ESXi chúng ta cần một nhóm cổng VM kernel để quản lý các máy ảo
# vSphere Standard Switch (vSS) hoặc vSwitch
<a href="https://imgur.com/WOxUrjS"><img src="https://i.imgur.com/WOxUrjS.png" title="source: imgur.com" width=60% align=right /></a>

- Nó hoạt động giống như một **physical switch**.
- vSwitch tạo liên kết giữa NIC vật lý và NICS ảo
- Virtual switch cung cấp kết nối giữa **các máy ảo** trên cùng một host **hoặc** trên **các host khác nhau** (thông quan Physical Adapters).
- Mặc dù một switch tiêu chuẩn vSphere hoạt động giống như một switch vật lý, nó không có một số chức năng nâng cao của một switch vật lý.

Ví dụ
- Một vSwitch không thể kết nối trực tiếp với một vSwitch khác trong hộp ESXi mà nó sẽ kết nối từ vswitch kết nối đến physical adapter rồi nó mới kết nối đến vswitch khác.

# Các Group Port vSwitch
<a href="https://imgur.com/3Pq1ClZ"><img src="https://i.imgur.com/3Pq1ClZ.png" title="source: imgur.com" width=45% align=right /></a>

- 2 nhóm cổng này được tạo tự động khi cài đặt ESXi, một nhóm dành riêng cho mạng máy ảo, một nhóm cổng khác dành riêng cho mạng quản lý 
1. VM Port Group:
- Quản lý mạng máy ảo.

2. VM Kernel Port Group:
- Điều này chủ yếu dành cho lưu trữ IP, vSphere vMotion, Fault Tolerance (FT), VSAN, Cấp phép, v.v. (Đề cập ở phần vCenter)
- Đối với mạng quản lý ESXi

Đoạn 22:50
<a href="https://imgur.com/3iQgOpX"><img src="https://i.imgur.com/3iQgOpX.png" title="source: imgur.com" /></a>

# Tối đa hóa mạng máy chủ ESXi

Mạng ESXi
Tối đa cấu hình

Các cổng tạo chuyển mạch Mạng ảo trên mỗi Switch tiêu chuẩn: 4088
Tổng số cổng Switch Mạng ảo trên mỗi máy chủ / máy chủ ESXi: 4096
Nhóm cổng trên mỗi công tắc tiêu chuẩn vSphere (VSS): 512
NICS vật lý 10 Gbps / 20 Gbps / 25 Gbps trên mỗi máy chủ: 16

# Kiến trúc mạng ESXi

- Về mặt vật lý, các VLAN có thể được kết nối với các cổng mà máy chủ ESXi đã chỉ định.
- Do đó, tất cả các mạng có thể được hiển thị cho máy ảo khi thích hợp, nhưng vẫn duy trì tính bảo mật cần thiết trong doanh nghiệp

# Các loại công tắc ảo

Mạng ảo hỗ trợ các loại thiết bị chuyển mạch ảo sau:

- Công tắc tiêu chuẩn - Standard switches (VSS):
  - Cấu hình chuyển mạch ảo cho một máy chủ duy nhất.

- Công tắc phân tán  - Distributed switches(DVS):
  - Công tắc ảo được cấu hình cho toàn bộ trung tâm dữ liệu.
  - Có thể gắn tới 2.000 máy chủ trên cùng một công tắc phân tán.
  - Cấu hình nhất quán trên tất cả các máy chủ được đính kèm.
  - Máy chủ lưu trữ phải có giấy phép Enterprise Plus hoặc thuộc cụm vSAN.

Cả hai loại công tắc đều có tính đàn hồi (Linh hoạt): các cổng được tạo và loại bỏ tự động.

# Mạng ESXi - lab

1. Tạo vSwitch

2. Tạo nhóm Cổng VM

3. Tạo nhóm Cổng VMkernel

4. Thêm NIC hoặc Uplinks vào vSwitch để dự phòng

5. Tuân thủ Chính sách kết nối vSwitch

