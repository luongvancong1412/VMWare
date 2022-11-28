<h1>Session 3: iSCSI Storage Configuration & VMFS Datastore</h1>

<h2> Mục lục</h2>

- [VMFS Datastore - Tổng quan](#vmfs-datastore---tổng-quan)
- [So sánh VMFS5 và VMFS6](#so-sánh-vmfs5-và-vmfs6)
- [iSCSI Storage Architecture](#iscsi-storage-architecture)
  - [iSCSI Components](#iscsi-components)
  - [iSCSI Addressing](#iscsi-addressing)
  - [iSCSI Initiators](#iscsi-initiators)
- [iSCSI Storage Configuration and Create a VMFS Datastore - Lab](#iscsi-storage-configuration-and-create-a-vmfs-datastore---lab)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)


# VMFS Datastore - Tổng quan

- VMFS là một hệ thống file được nhóm thành cụm trong đó nhiều máy chủ ESXi có thể đọc và ghi đồng thời vào cùng một thiết bị lưu trữ.
- Hệ thống file cluster cung cấp các dịch vụ dựa trên ảo hoá:
  - VMotion: Di chuyển các máy ảo đang chạy từ máy chủ ESXi này sang máy chủ ESXi khác mà không cần dừng hoạt động.
  - HA: Tự động reset lại máy ảo trên máy chủ ESXi riêng biệt khi máy chủ ESXi bị lỗi
  - DRS: Cân bằng tải trên các máy chủ ESXi
- Hiện tại, ESXi hỗ trợ VMFS 5 và VMFS 6
- VMFS có thể triển khai trên 3 loại thiết bị lưu trữ dựa trên SCSI:
1. Lưu trữ trực tiếp (Direct Attached Storage - DAS)
2. Lưu trữ kênh sợi quang (Fibre Channel Storage - FC/FCOE SAN)
3. Lưu trữ iSCSI (iSCSI SAN)

# So sánh VMFS5 và VMFS6

|Tính năng và chức năng| VMFS 5| VMFS6
|---|---|---|
Quyền truy cập cho máy chủ ESXi phiên bản 6.5 trở lên|có|có
Quyền truy cập cho máy chủ ESXi phiên bản 6.0 trở về trước|Có|Có
Kho dữ liệu trên mỗi máy chủ|512|512
Thiết bị lưu trữ 512n<br>Kích cỡ vùng logic = 512<br>Kích thước vùng vật lý = 512 |Có|Có (mặc định)
Thiết bị lưu trữ 512e<br>Logical Siz Siz = 512<br>Physical Sector Size = 4096 |Có<br>Không được hỗ trợ trên thiết bị 512e cục bộ|Có (mặc định)
Thiết bị lưu trữ 4Kn<br>Khu vực logic Siz = 4096<br>Kích thước khu vực vật lý = 4096|Không|Có
Thu hồi không gian tự động|Không|Có
Khai hoang không gian thủ công thông qua lệnh esxcli|Có|Có
Khai hoang không gian từ hệ điều hành khách|Hạn chế|Có
Phân vùng thiết bị lưu trữ GPT|Có|Có
Phân vùng thiết bị lưu trữ MBR|Có|Có
Thiết bị lưu trữ lớn hơn 2 TB cho mỗi phạm vi VMFS|Có|Có
Hỗ trợ cho các máy ảo có ổ đĩa ảo dung lượng lớn hoặc ổ đĩa lớn hơn 2 TB|Có|Có
Hỗ trợ các tệp nhỏ 1 KB|Có|Có
Sử dụng mặc định cơ chế khóa chỉ dành cho ATS trên thiết bị lưu trữ hỗ trợ<br>ATS (Kiểm tra và đặt tự động)|Có|Có
Kích thước khối|1MB tiêu chuẩn|1MB tiêu chuẩn
vMotion|Có|Có
Lưu trữ vMotion trên các loại kho dữ liệu khác nhau|Có|Có
Tính sẵn sàng cao và khả năng chịu lỗi|Có|Có
DRS và Lưu trữ DRS|Có|Có
RDM|Có|Có
# iSCSI Storage Architecture
## iSCSI Components
<a href="https://imgur.com/YEtQmJl"><img src="https://i.imgur.com/YEtQmJl.png" title="source: imgur.com" /></a>

- Một iSCSI SAN bao gồm một hệ thống lưu trữ iSCSI, chứa một hoặc nhiều LUN và một hoặc nhiều bộ xử lý lưu trữ (SP - Storage Processors). Máy chủ và mảng lưu trữ giao tiếp qua mạng TCP/IP.

- Máy chủ ESXi được cấu hình với bộ khởi tạo iSCSI (iSCSI initiator). Initiator có thể dựa trên phần cứng, trong trường hợp đó Initiator là host bus adapter iSCSI (HBA).

- Initiator cũng có thể dựa trên phần mềm; đây được gọi là trình khởi tạo phần mềm iSCSI (iSCSI software initiator).

- Một Initiator truyền các lệnh SCSI qua mạng IP. Mục tiêu () nhận lệnh SCSI từ mạng IP. Có thể có nhiều initiator và mục tiêu (target) trong mạng ISCSI. ISCSI được định hướng theo SAN vì:
  - Intiator tìm thấy một hoặc nhiều mục tiêu (target)
  - Một Target LUN (Logical Unit Number) cho initiator
  - Initiator gửi lệnh SCSI đến mục tiêu

- Initiator nằm trong máy chủ ESXi. Các mục tiêu (target) nằm trong mảng lưu trữ được máy chủ ESXi hỗ trợ.
- Các mảng iSCSI có thể sử dụng nhiều cơ chế khác nhau, bao gồm địa chỉ IP, mạng con và các yêu cầu xác thực để hạn chế quyền truy cập vào các Target từ máy chủ.

## iSCSI Addressing
- Khác với các địa chỉ IP tiêu chuẩn, các Target iSCSI cũng được xác định bằng tên
- Định dạng iSCSI Qualified Name (IQN) có dạng: `iqn.yyyy-mm.naming-authority:unique name`

- Node iSCSI có thể là nút Initiator hoặc Target. Một nút iSCSI yêu cầu một tên để có thể quản lý bộ nhớ không cần địa chỉ.

- `Tên iSCSI` có thể sử dụng một trong các định dạng sau:
  - iSCSI qualified name (IQN) hoặc extended unique identifier (EUI).

- IQN có thể dài tối đa 255 ký tự. Quy ước đặt tên
  - Prefix: "ign"
  - Date: xác định năm và tháng mà tổ chức đã đăng ký tên miền hoặc tên miền phụ được sử dụng làm naming authority string
  - Organizational naming authority string: bao gồm một tên miền hoặc tên miền phụ hợp lệ, bị đảo ngược
  - (Tùy chọn) Dấu hai chấm (:), theo sau là một chuỗi của tổ chức định ra, mỗi tên ISCSI là duy nhất

- Quy ước đặt tên EUI:
  - Prefix: "eul,"
  - Theo sau là tên gồm 16 ký tự.
  - Tên bao gồm 24 bit (tên công ty) được gán bởi IEEE và 40 bit cho ID duy nhất, chẳng hạn như số serial.

## iSCSI Initiators
- Phải thiết lập Adapter iSCSI phần mềm hoặc phần cứng trước khi host ESXi có thể hoạt động với iSCSI Storage.
- Để truy cập các Target iSCSI, host ESXi sử dụng iSCSI initiator.

<a href="https://imgur.com/CVrjSO6"><img src="https://i.imgur.com/CVrjSO6.png" title="source: imgur.com" /></a>

- iSCSI initiator chuyển các yêu cầu và phản hồi SCSI giữa host và Tagert iSCSI được đóng gói trong giao thức iSCSI.
- ESXi hỗ trợ hai loại initiator: 
  - software iSCSI
  - hardware iSCSI
- Software iSCSI initiator là mã VMware được tích hợp sẵn trong VMkernel. Initiator cho phép host kết nối với thiết bị lưu trữ iSCSI thông qua `standard network adapters`. Phần mềm iSCSI Initiator xử lý quá trình iSCSI trong khi giao tiếp với network adapter. Với phần mềm iSCSI Initiator, chúng ta có thể sử dụng công nghệ iSCSI mà không cần mua phần cứng chuyên dụng.

- Hardware iSCSI initiator là adapter chuyên dụng của bên thứ ba có khả năng truy cập bộ lưu trữ iSCSI qua TCP/IP.
- Hardware iSCSI initiator được chia thành hai loại: dependent (phụ thuộc) hardware iSCSI và independent (độc lập) hardware iSCSI.
- Dependent hardware iSCSI initiator hoặc adapter phụ thuộc vào mạng VMware và cấu hình iSCSI và các giao diện quản lý do VMware cung cấp. Loại bộ điều hợp này trình bày một network adapter tiêu chuẩn và chức năng giảm tải iSCSI (iSCSI offload function) cho cùng một cổng.
-  Independent (độc lập) hardware ISCSI adapter xử lý tất cả iSCSI và network processing cũng như quản lý cho host ESXi

# iSCSI Storage Configuration and Create a VMFS Datastore - Lab

Cấu hình iSCSI Storage và tạo một VMFS Datastore

|iSCSI Storage > Pre-Configuration Steps|
|---|
|Thiết lập môi trường iSCSI Storage|
|Cài đặt và cấu hình iSCSI adapters|
|Tạo một VMKernel Portgroup|
|Nhận địa chỉ ISCSI Storage hoặc địa chỉ IP & các chi tiết LUN|
|Thông tin đăng nhập (CHAP) ISCSI SAN-required|
|Xác định rằng các thiết bị lưu trữ định sử dụng cho kho dữ liệu|

|iSCSI SAN > Configuration Procedure|
|---|
|Thêm role iSCSI Target Server trên Windows Server 2022|
|Tạo một thư mục hoặc disk và cung cấp quyền lưu trữ iSCSI (Tùy chọn)|
|Update chi tiết Dynamic Discovery Target|
|Để khám phá các thiết bị lưu trữ mới được thêm vào, cần thực hiện `rescan`.|
|Trong trình điều hướng đối tượng vSphere Client, duyệt đến 1 host, 1 cluster hoặc data center|
|Từ menu chuột phải, chọn Storage > New Datastore|
|Chọn VMFS làm datastore type|
|Nhập Datastore name và chỉ định phiên bản datastore.|
|Nếu đang tạo datastore ở cấp data center hoặc cluster, hãy chọn host gắn kho dữ liệu. (Tùy chọn)
|Xem lại các tùy chọn cấu hình và click vào `Finish`.|

|iSCSI SAN > Post-Installation Steps|
|---|
|Xác thực Datastore VMFS mới trên thiết bị lưu trữ dựa trên iSCSI|
|Đảm bảo rằng Datastore VMFS mới có sẵn cho tất cả các host có quyền truy cập vào thiết bị iSCSI Target.|
|Tạo một máy ảo và xác minh các tệp máy ảo trên VMFS Datastore.|

# Tài liệu tham khảo

1. https://www.youtube.com/watch?v=yRE3eD5mcUQ&list=PLjsBan7CwUQAFA9m2dYEL2FmeRdRiyWBD&index=18
2. 