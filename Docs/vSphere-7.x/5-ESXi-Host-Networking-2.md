<h1> ESXi Host Networking: Standard vSwitch</h1>

<h2>Summary</h2>



# Tóm tắt

- Khái niệm mạng ESXi

- Chuyển mạch tiêu chuẩn vSphere (VSS) hoặc vSwitch

- Nhóm cổng vSwitch

- Tối đa hóa mạng ESXi

- Các trường hợp sử dụng vSwitch

- Kiến trúc mạng ESXi

- Các loại công tắc ảo

- Mạng ESXi - Phòng thí nghiệm

# Khái niệm mạng ESXi

## Physical Switch
- Một physical network switch là một thiết bị phần cứng được sử dụng để kết nối các thiết bị và cho phép chúng giao tiếp qua mạng


P2
- Một physical ethernet switch quản lý lưu lượng mạng giữa các máy trong mạng vật lý.
- Một switch có nhiều cổng, mỗi cổng có thể được kết nối với một máy duy nhất hoặc một bộ chuyển mạch khác trong mạng.
- Mỗi cổng có thể được cấu hình để hoạt động theo những cách nhất định tùy thuộc vào nhu cầu của máy kết nối với nó.
- Switch là cốt lõi của một mạng vật lý. Nhiều thiết bị chuyển mạch có thể được kết nối với nhau để tạo thành mạng lớn hơn.

## Physical Network
- Là một mạng các máy vật lý được kết nối để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau. VMware ESXi chạy trên một máy vật lý.

## Virtual Network

- Một mạng các máy ảo chạy trên một máy vật lý được kết nối logic với nhau để chúng có thể gửi dữ liệu đến và nhận dữ liệu từ nhau.
- Máy ảo có thể được kết nối với mạng ảo mà chúng tôi tạo ra khi chúng tôi thêm 1 mạng

# vSphere Standard Switch (vSS) hoặc vSwitch

- Nó hoạt động giống như một physical switch.
- vSwitch tạo liên kết giữa NIC vật lý và NICS ảo
- Virtual switch cung cấp kết nối giữa các máy ảo trên cùng một host hoặc trên các host khác nhau.
- Mặc dù một switch tiêu chuẩn vSphere hoạt động giống như một switch vật lý, nó không có một số chức năng nâng cao của một switch vật lý.

Ví dụ
- Tạo VLAN.
- Một vSwitch không thể kết nối trực tiếp với một vSwitch khác

# nhóm Cổng vSwitch

1. VM Port Group:
- Quản lý mạng máy ảo.

2. VM Kernel Port Group:
- Điều này chủ yếu dành cho lưu trữ IP, vSphere vMotion, Fault Tolerance (FT), VSAN, Cấp phép, v.v.
- Đối với mạng quản lý ESXi


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

# Mạng ESXi - Phòng thí nghiệm:

1. Tạo vSwitch

2. Tạo nhóm Cổng VM

3. Tạo nhóm Cổng VMkernel

4. Thêm NIC hoặc Uplinks vào vSwitch để dự phòng

5. Tuân thủ Chính sách kết nối vSwitch

