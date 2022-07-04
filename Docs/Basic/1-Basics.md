<h1> VMware Datacenter Virtualization Basics </h1>

<h2> Summary </h2>

- [Tổng quan](#tổng-quan)
  - [1.Ảo hoá là gì](#1ảo-hoá-là-gì)
  - [1. Virtual Machines](#1-virtual-machines)
  - [2. Lợi ích của việc sử dụng máy ảo](#2-lợi-ích-của-việc-sử-dụng-máy-ảo)
  - [3. Những thách thức](#3-những-thách-thức)
  - [4. Các loại ảo hóa](#4-các-loại-ảo-hóa)
    - [3.1. Desktop](#31-desktop)
    - [3.2. Application](#32-application)
    - [3.3. Server](#33-server)
    - [3.4. Storage](#34-storage)
    - [3.5. Network](#35-network)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

# Tổng quan
## 1.Ảo hoá là gì

## 1. Virtual Machines
- Là một môi trường ảo mô phỏng 1 máy vật lý
- Có các thành phần ảo tương tự như máy tính thật
  - CPU, Memory, Network Interface và Storage
- Nhiều máy ảo có thể cùng tồn tại trong một máy vật lý duy nhất.
<h3>Các thành phần Virtual Machine VMware</h3>

- Guest operating system
  - Windows, Linux
- VMware Tools
- Tài nguyên ảo:
    - CPU và memory
    - Network adapters
    - Disks và controllers
        - Controllers : VMware Workstation
## 2. Lợi ích của việc sử dụng máy ảo
<h4>For Better Hardware utilization - Sử dụng phần cứng tốt hơn</h4>
- Giảm chi phí phần cứng
  - Giả sử cần tạo 500 máy ảo, cấu hình 10 vms trên 1 máy chủ thì ta cần 50 máy chủ thay vì 500 máy chủ vật lý
>Giới hạn về dung lượng cho mỗi máy chủ lưu trữ
https://configmax.esp.vmware.com/guest?vmwareproduct=vSphere&release=vSphere%207.0&categories=1-0,2-0
<h4>Financial Benefit - Giảm chi phí</h4>

<h4>Datacentre space -  Không gian trung tâm dữ liệu</h4>

![Imgur](https://i.imgur.com/VdMMSrf.png)

- Ex: Vấn đề mua đất để duy trì nhiều server 
  - Với việc sử dụng máy ảo, khi số lượng máy chủ giảm từ 500 xuống 50, điều đó có nghĩa là giảm 450 máy chủ, không gian trung tâm dữ liệu cũng giảm. 
- Tiết kiệm không gian so server với ảo hoá.
<h4>AMC- Anual Maintenance Cost -  Chi phí bảo trì định kỳ</h4>

- Giả sử hoá đơn tiền điện trước đó cho 500 máy chủ, nếu máy chủ giảm xuống 50 thì hoá đơn tiền điện được tiết kiệm, này gọi chung là chi phí bảo trì hằng năm
- Chi phí: bảo trì điện + con người + vị trí + hệ thống
=> Cloud chỉ mất chi phí hàng tháng
<h4>UPS - Uninterruptible Power Supply - Cung cấp điện liên tục</h4>
  - Có một nguồn điện riêng biệt, ổn định, có tính dự phòng

<h4>Network equipment</h4>

- Thiết bị mạng
  - Khi số lượng máy chủ giảm từ 500 xuống 50 thì số lượng thiết bị mạng cũng sẽ giảm xuống.
<h4>Storage</h4>

- Truyền thống: không sử dụng hết không gian
- Máy ảo: sử dụng tốt hơn

<h3>➟ Chỉ cần nắm công nghệ, chi phí cơ sở hạ tầng giảm</h3>

## 3. Những thách thức

<h4>Chi phí cao cho những thiết bị chuyên dụng</h4>
- Khi mua Laptop sẽ có các mẫu bộ vi xử lý i3 i5 i7, cấu hình nào tốt nhất , thương hiệu nào tốt hơn,...
- Khi bắt đầu 1 dự án, trong giai đoạn ban đầu họ sẽ xác định cần bao nhiêu máy chủ cho dự án mới này,... Nếu không có ảo hoá, cần đầu tư chi phí cao cho toàn bộ cơ sở hạ tầng vật lý, data center,...
- Nếu sử dụng ảo hoá, không cần đầu tư nhiều dung lượng cao, sau này có thể nâng cấp thêm
<h4>Single point of failure - Một điểm lỗi duy nhất</h4>

- Ví dụ: Giả sử có 200 máy chủ trong tổ chức, nếu 1 máy chủ gặp sự cố chắc chắn sẽ ảnh hưởng đến hoạt động tổ chức. Datacenter cũng được coi là **Single point of failure**.
- VMware cung cấp toàn bộ đều là máy ảo, máy sẽ hoạt động liên tục. Về kỹ thuật được gọi là tính khả dụng, tính sẵn sàng cao
<h4>Long wait time for hardware purchases - Thời gian chờ đợi dài để mua phần cứng</h4>

- Khi mua Laptop ta có thể đến cửa hàng mua, nhưng khi nói đến máy chủ, nếu muốn mua 100 máy chủ phải đặt hàng trước, mất một thời gian để cung cấp 100 máy chủ
- Giả sử nếu có 1 hộp Exsa cấu hình cao, ta có thể tạo nhiều máy ảo trên đó và có thể tạo máy ảo một cách nhanh chóng, cài hệ điều hành tương tự như máy thật, không phải chờ đợi lâu cho **Long wait time for hardware purchases** 
<h4>Performance bottlenecks</h4>

- Tất cả không gian trên máy ảo đều có giới hạn

## 4. Các loại ảo hóa

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
### 3.4. Storage
Lưu trữ dữ liệu của doanh nghiệp trong một cloud an toàn, loại bỏ nhu cầu lưu trữ dữ liệu vật lý  và có khả năng giảm chi phí liên quan đến không gian trong trung tâm dữ liệu

### 3.5. Network
Sử dụng các thành phần vật lý và ảo để tạo ra một mạng lai (hybrid network), cho phép quản trị mạng thông qua các switch phần mềm

- Là sự kết hợp giữa mạng vật lý và mạng ảo, sử dụng thành phần của cả 2 để tạo ra một môi trường dễ quản lý hơn nhiều so với một môi trường vật lý nghiêm ngặt
- Giúp thử nghiệm các ứng dụng mới được phát trển trên mạng ảo trước khi phát hành để phát hiện các sai sót và lỗi tiềm ẩn, tối ưu hoá hiệu suất của ứng dụng dựa trên cách nó hoạt động trên môi trường ảo

# Tài liệu tham khảo 

1. https://www.globalknowledge.com/us-en/resources/resource-library/articles/virtualization-for-newbies-five-types-of-virtualization/#gref
2. https://www.parallels.com/blogs/ras/virtual-machine/