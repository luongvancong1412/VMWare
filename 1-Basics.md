<h1> VMware Datacenter Virtualization Basics </h1>

<h2> Mục lục </h2>

- [Tổng quan](#tổng-quan)
  - [1. Virtual Machines](#1-virtual-machines)
  - [2. Lợi ích của việc sử dụng máy ảo](#2-lợi-ích-của-việc-sử-dụng-máy-ảo)
  - [3. Các loại ảo hóa](#3-các-loại-ảo-hóa)
    - [3.1. Desktop](#31-desktop)
    - [3.2. Application](#32-application)
    - [3.3. Server](#33-server)
  - [3.4. Storage](#34-storage)
  - [3.5. Network](#35-network)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

# Tổng quan
## 1. Virtual Machines
Máy ảo (VM) là một phần mềm đại diện của một máy tính vật lý và các thành phần của nó.
Phần mềm ảo hóa ( virtualization software) chuyển đổi máy vật lý và các thành phần của nó thành các tệp.

<h3>Các thành phần Virtual Machine</h3>

- Guest operating system
- VMware Tools
- Tài nguyên ảo:
    - CPU và memory
    - Network adapters
    - Disks và controllers
    - Parallel và serial ports

## 2. Lợi ích của việc sử dụng máy ảo
<h3>Máy vật lý:</h3>

- Khó di chuyển hoặc sao chép
- Liên kết với một tập hợp các thành phần phần cứng cụ thể
- Thường có vòng đời ngắn
- Cần tác động trực tiếp để nâng cấp phần cứng

<h3>Máy ảo:</h3>

- Dễ dàng di chuyển hoặc sao chép
- Độc lập với phần cứng vật lý vì máy ảo được đóng gói thành tệp
- Cách ly với các máy ảo khác chạy trên cùng một phần cứng vật lý
- Không bị ảnh hưởng bởi những thay đổi phần cứng vật lý

## 3. Các loại ảo hóa

### 3.1. Desktop
Cho phép nhiều máy ảo chạy Desktop cloud trên cùng một máy chủ vật lý hoặc ảo
- Cho phép mọi người truy cập nhiều ứng dụng và hệ điều hành trên một máy tính (Vì các ứng dụng và hdh được cài đặt trên các máy ảo chạy trên một máy chủ trong data center)
- Máy ảo (VM) là một máy tính vật lý nhưng ở dạng phần mềm. Máy ảo được tổ chức bằng cách sử dụng hypervisors, giúp máy tính vật lý và máy ảo chạy như ý muốn.
- Có 2 phương pháp:
  - Local
    - Có nhiều hạn chế, trong đó có việc không thể sử dụng thiết bị di động để truy cập tài nguyên mạng
  - Remote
    - Phổ biến
    - Người dùng chạy OS và ứng dụng được truy cập từ máy chủ đặt bên trong data center an toàn.

Đối với doanh nghiệp, ảo hoá Desktop cho phép nhân viên đăng nhập từ xa trong trường hợp thiên tai hoặc vấn đề về sức khoẻ khiến họ không thể đến văn phòng để làm việc

Ứng dụng:
- Khắc phục thảm hoạ tự nhiên (Covid 2019)
- ứng phó với bất kỳ sự kiện bất ngờ nào khiến nhân viên không thể đến văn phòng
### 3.2. Application
Tạo một phiên bản ảo của các ứng dụng cần thiết.
- Thông qua ảo hoá ứng dụng, người dùng có thể truy cập phiên bản từ xa của một ứng dụng chưa được cài đặt trên máy tính cá nhân
- Là 1 phần quan trọng trong việc cho phép làm việc từ xa trên quy mô lớn cùng với ảo hoá máy tính để bàn.
- Khi được ảo hoá, các ứng dụng hoạt động trong cái được gọi là **sandbox**, một môi trường chạy riêng biệt với hệ điều hành
- Khi hoạt động trong **sandbox** này, mọi thay đổi sẽ xuất hiện trong hệ điều hành, mặc dù ứng đụng đang lấy openration power từ **sandbox**.
- Có 2 phương pháp ảo hoá aplication:
  - Remote
    - Chạy trên 1 máy chủ tương tự màn hình của người dùng và người dùng được uỷ quyền có thể truy cập mọi lúc, mọi nơi
  - Streaming
    - Chỉ chạy 1 phiên bản trên máy chủ, cung cấp quền truy cập cục bộ vào ứng dụng
- Remote app streaming là cách tiếp cận phổ biến hơn nhờ phạm vi tiếp cận mở rộng mà nó mang lại
- Lợi ích:
  - Quản lý ứng dụng và sử lỗi chỉ với 1 phiên bản của ứng dụng: tiết kiệm thời gian và công sức hơn so với việc cài đặt ứng dụng trên máy tính của mỗi người dùng.
  - Mọi bản vá hoặc cập nhật chỉ phải thực hiện 1 lần thay vì hàng trăm hoặc hàng nghìn lần.
  - Tiết kiệm chi phí (Nhân viên có thể truy cập các ứng dụng ảo hoá thông qua máy tính cá nhân)

### 3.3. Server
Tạo một máy chủ ảo thay cho máy chủ vật lý, cho phép quản lý máy chủ thông qua đám mây
- Cho phép phân chi tài nguyên tốt hơn
  - vì cho phép quản trị viên chia một máy chủ vật lý thành nhiều máy chủ ảo.
  - Các máy chủ ảo này có thể được sử dụng để chạy một hệ điều hành riêng biệt và bất kỳ ứng dụng cần thiết nào.
  - Từ đó giảm chi phí hoạt động trong khi tận hưởng thời gian triển khai nhanh hơn, hiệu suất ứng dụng tốt hơn
- Máy chủ ảo chia sẻ CPU, Memory, storage và mạng được lấy từ **hypervisor** của máy chủ vật lý mà máy chủ ảo được xây dựng trên đó.
- Trong các loại ảo hoá, **Server Virtualization** có tỷ lệ sử dụng cao nhất thay cho máy chủ vật lý. Máy chủ ảo này thường bao gồm một máy ảo được trang bị CPU, RAM và phần cứng ảo để bắt trước một máy chủ truyền thống trên cloud

- Cho phép người quản trị hệ thống nhanh chóng thêm nhiều máy ảo hơn, loại bỏ thời gian và chi phí là mua một máy tính vật lý mới.
## 3.4. Storage
Lưu trữ dữ liệu của doanh nghiệp trong một cloud an toàn, loại bỏ nhu cầu lưu trữ dữ liệu vật lý  và có khả năng giảm chi phí liên quan đến không gian trong trung tâm dữ liệu

- Có 2 loại Storage Virtualization
  - Internal (nội bộ)
  - External (bên ngoài)

## 3.5. Network
Sử dụng các thành phần vật lý và ảo để tạo ra một mạng lai (hybrid network), cho phép quản trị mạng thông qua các switch phần mềm

- Là sự kết hợp giữa mạng vật lý và mạng ảo, sử dụng thành phần của cả 2 để tạo ra một môi trường dễ quản lý hơn nhiều so với một môi trường vật lý nghiêm ngặt
- Giúp thử nghiệm các ứng dụng mới được phát trển trên mạng ảo trước khi phát hành để phát hiện các sai sót và lỗi tiềm ẩn, tối ưu hoá hiệu suất của ứng dụng dựa trên cách nó hoạt động trên môi trường ảo



Giới thiệu về Software-Defined Data Center (Trung tâm dữ liệu do phần mềm xác định)
Trong Software-Defined Data Center (SDDC), tất cả cơ sở hạ tầng đều được ảo hóa và việc kiểm soát trung tâm dữ liệu được tự động hóa bằng phần mềm. vSphere là người sáng lập của SDDC

Giới thiệu vSphere

vSphere và Điện toán đám mây
Điện toán đám mây khai thác sự hiệu quả của cơ sở hạ tầng ảo theo yêu cầu, tự quản lý




II. vSphere – Ảo hóa tài nguyên
Virtual Machine: Guest và Consumer of ESXi Host
Mọi ứng dụng trong bất kỳ hệ điều hành được hỗ trợ nào đều có thể chạy trong máy ảo (Guest) và sử dụng CPU, bộ nhớ, đĩa và mạng từ các tài nguyên dựa trên máy chủ



Physical và Virtual Architecture
Công nghệ ảo hóa trừu tượng hóa các thành phần vật lý thành các thành phần phần mềm và là giải pháp cho nhiều vấn đề CNTT



 

Physical Resource Sharing
Nhiều máy ảo, chạy trên một máy chủ vật lý, chia sẻ tài nguyên tính toán, bộ nhớ, mạng và lưu trữ của máy chủ lưu trữ



 

CPU Virtualization
Trong môi trường physical, hệ điều hành được quyền sở hữu của tất cả các CPU vật lý trong hệ thống.

CPU virtualization nhấn mạnh vào hiệu suất và chạy trực tiếp trên các CPU có sẵn

Giới thiệu vSphere

Physical và Virtualized Host Memory Usage
Trong môi trường physical, hệ điều hành được quyền sở hữu của tất cả bộ nhớ vật lý trong hệ thống.

Memory virtualization nhấn mạnh vào hiệu suất và chạy trực tiếp trên các RAM có sẵn

Giới thiệu vSphere

 

Physical và Virtual Networking
Virtual Ethernet adapters and virtual switches là các thành phần mạng ảo chính

Giới thiệu vSphere

Physical File Systems và Datastores
vSphere VMFS cung cấp một kiến trúc lưu trữ phân tán, trong đó nhiều máy chủ ESXi có thể đọc hoặc ghi đồng thời vào bộ lưu trữ dùng chung.

Giới thiệu vSphere

GPU Virtualization
GPU graphics tối ưu hóa các hoạt động đồ họa phức tạp. Các hoạt động này có thể chạy ở hiệu suất cao mà không làm CPU quá tải.

GPU ảo có thể được thêm vào máy ảo cho các trường hợp sử dụng sau:

• Rich 2D and 3D graphics
• VMware Horizon virtual desktops
• Graphics-intensive applications, chẳng hạn như những kiến trúc sư và kỹ sư sử dụng
• Server applications cho các tác vụ song song hàng loạt, chẳng hạn như các ứng dụng tính toán khoa học

Bạn có thể định cấu hình máy ảo với tối đa bốn thiết bị vGPU để đáp ứng các trường hợp sử dụng yêu cầu nhiều GPU.

VMware hỗ trợ card đồ họa AMD và NVIDIA.


III. vSphere – Giao diện người dùng
Bạn có thể sử dụng vSphere Client, PowerCLI, VMware Host Client và ESXCLI để tương tác với môi trường vSphere.

Để biết thông tin về các cổng và giao thức, hãy xem http://ports.vmware.com.

Giới thiệu vSphere

Giới thiệu về VMware Host Client
VMware Host Client là giao diện người dùng dựa trên HTML5 mà bạn có thể sử dụng để quản lý trực tiếp các máy chủ ESXi riêng lẻ khi máy chủ vCenter không khả dụng.

VMware Host Client từ ESXi và bạn truy cập nó từ  trình duyệt tại https://ESXi_FQDN_or_IP_Address/ui

 



 

Giới thiệu vSphere Client
vSphere Client là ứng dụng khách dựa trên HTML5. Bạn quản lý môi trường vSphere với vSphere Client bằng cách kết nối với vCenter Server Appliance.

Bạn truy cập vSphere Client từ  trình duyệt tại https://vCenter_Server_Appliance_FQDN_or_IP_Address /ui



 

Giới thiệu về PowerCLI và ESXCLI
PowerCLI là một công cụ dòng lệnh và tập lệnh được xây dựng trên Windows PowerShell:
• Cung cấp giao diện PowerShell cho vSphere API
• Cung cấp hơn 700 cmdlet để quản lý và tự động hóa vSphere

Công cụ ESXCLI cho phép quản lý từ xa các máy chủ ESXi bằng cách sử dụng bộ lệnh ESXCLI:
• Có thể tải xuống ESXCLI từ trang VMware {code} tại https://code.vmware.com/web/tool/7.0/esxcli
• Các lệnh ESXCLI có thể được chạy trên hệ thống vCenter Server và nhắm mục tiêu đến bất kỳ hệ thống ESXi nào.


IV. Tổng quan ESXi
Về ESXi
ESXi là một hypervisor mà bạn có thể mua với vSphere hoặc tải xuống phiên bản miễn phí. ESXi có các tính năng sau:

• Bảo mật cao:
— Host-based firewall
— Memory hardening
— Kernel module integrity
— Trusted Platform Module (TPM 2.0)
— UEFI secure boot
— Encrypted core dumps
• Sử dụng dung lượng disk nhỏ
• Khởi động nhanh để vá và nâng cấp nhanh hơn
• Có thể cài đặt trên đĩa cứng, SAN LUN, SSD, thiết bị USB, thẻ SD, SATADOM và máy chủ không ổ đĩa

Cấu hình ESXi host
DCUI là giao diện người dùng dựa trên văn bản với tương tác chỉ dùng bàn phím

Giới thiệu vSphere

Root Access
Quản trị viên sử dụng DCUI để cấu hình cài đặt quyền truy cập root:
• Đặt mật khẩu root (chỉ những mật khẩu phức tạp).
• Bật hoặc tắt chế độ khóa:
– Giới hạn quản lý ESXi host với chỉ sử dụng vCenter
– Chỉ có thể được định cấu hình cho hosts được quản lý bởi vCenter



Management Network
Sử dụng DCUI, bạn có thể sửa đổi cài đặt mạng:

• Hostname
• IP configuration (IP address, subnet mask, default gateway)
• DNS servers

Giới thiệu vSphere

Các thiết lập khác
Sử dụng DCUI, bạn có thể định cấu hình bố cục bàn phím, bật dịch vụ khắc phục sự cố, xem thông tin hỗ trợ và xem nhật ký hệ thống

Giới thiệu vSphere

 

Kiểm soát quyền truy cập từ xa vào máy chủ ESXi
Bạn có thể sử dụng vSphere Client để tùy chỉnh các cài đặt bảo mật thiết yếu giúp kiểm soát quyền truy cập từ xa vào máy chủ ESXi:
• Tường lửa ESXi được bật theo mặc định:
– Tường lửa chặn lưu lượng đến và đi, ngoại trừ lưu lượng được bật trong cài đặt tường lửa của máy chủ.
• Các dịch vụ, chẳng hạn như NTP client và SSH client, có thể được quản lý bởi quản trị viên.
• Chế độ Lockdown ngăn người dùng từ xa đăng nhập trực tiếp vào máy chủ. Máy chủ chỉ có thể truy cập thông qua DCUI hoặc vCenter Server.

Giới thiệu vSphere

 

Quản lý tài khoản người dùng: Best Practices
Khi chỉ định tài khoản người dùng để truy cập máy chủ ESXi hoặc hệ thống máy chủ vCenter, hãy đảm bảo rằng bạn tuân theo các nguyên tắc bảo mật sau:

• Kiểm soát chặt chẽ các đặc quyền root đối với các máy chủ ESXi.
• Tạo mật khẩu tài khoản root mạnh, có ít nhất tám ký tự. Sử dụng các ký tự đặc biệt, thay đổi chữ hoa chữ thường và số. Thay đổi mật khẩu định kỳ.
• Quản lý các máy chủ ESXi một cách tập trung thông qua vCenter bằng cách sử dụng vSphere Client
• Giảm thiểu việc sử dụng local user trên các máy chủ ESXi:
– Thêm máy chủ ESXi vào Active Directory và thêm người dùng quản trị viên có liên quan vào ESX Admins domain group Theo mặc định, người dùng trong ESX Admins domain group quyền root trên máy chủ ESXi.
– Nếu local users được tạo, hãy quản lý họ một cách tập trung bằng lệnh esxcli trong vSphere CLI.

NTP Client cho ESXi Host
Máy chủ ESXi có thể được cấu hình như một NTP Client. Nó có thể đồng bộ thời gian với máy chủ NTP trên Internet hoặc máy chủ NTP của công ty bạn.



Vậy là chúng ta đã hoàn thành xong bài giới thiệu vSphere, các thành phần bên trong, và Software Defined Data Center

 Bài 1: Giới thiệu khóa học – Tự học VMware vSphere 7: Install, Configure, Manage
Bài 3: Máy ảo (Virtual Machine) – Tự học Vmware vSphere 7 
Leave a Reply 
Your email address will not be published. Required fields are marked *

Comment

Name *

Email *

Website

 Save my name, email, and website in this browser for the next time I comment.

Bài viết mới nhất
Hướng dẫn mở case lấy bản mềm chứng chỉ Cisco
Hướng dẫn đổi tên chứng chỉ Cisco
Các khái niệm về bảo mật mạng LAN
Ebook RedHat Linux Networking and System Administration
Ebook Programming and Automating Cisco Networks

 info@itexamviet.com
Những series, chủ đề hay
Tự học AWS
Tự học VMware vSphere 7
Tự học CCNA v7 200-301
Tự học Linux
Lý do chọn ITexamViet
Hướng dẫn thi thử trên ITexamViet
Hướng dẫn mua dump trên ITexamViet 
Hướng dẫn thi chứng chỉ online trên PEARSON VUE
Chiến thuật luyện thi
© 2022 ITexamViet

Liên hệ Về chúng tôi Privacy Policy

# Tài liệu tham khảo 

1. https://www.globalknowledge.com/us-en/resources/resource-library/articles/virtualization-for-newbies-five-types-of-virtualization/#gref
2. 