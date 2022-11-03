<h1> Cấu hình và quản lý NSF Datastore</h1>

<h2>Mục lục</h2>

- [Kiến trúc vật lý vs Virtual Architecture](#kiến-trúc-vật-lý-vs-virtual-architecture)
- [vSphere Storage - Datastores](#vsphere-storage---datastores)
- [vSphere Storage - Tổng quan](#vsphere-storage---tổng-quan)
- [vSphere Storage Technologies](#vsphere-storage-technologies)
- [vSphere Storage - Sơ đồ khái niệm](#vsphere-storage---sơ-đồ-khái-niệm)
- [So sánh các loại lưu trữ](#so-sánh-các-loại-lưu-trữ)
- [vSphere Storage - Các tính năng hỗ trợ](#vsphere-storage---các-tính-năng-hỗ-trợ)
- [vSphere trên Kiến trúc NFS/NAS Storage](#vsphere-trên-kiến-trúc-nfsnas-storage)
- [NFS Storage - Cấu trúc và Thành phần](#nfs-storage---cấu-trúc-và-thành-phần)
- [NFS Storage Architecture - Định địa chỉ và Kiểm soát truy cập (Access Control) với NFS](#nfs-storage-architecture---định-địa-chỉ-và-kiểm-soát-truy-cập-access-control-với-nfs)
- [NFS Datastore - Cấu hình](#nfs-datastore---cấu-hình)
- [NFS Datastore Configuration & Management - Home lab](#nfs-datastore-configuration--management---home-lab)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

# Kiến trúc vật lý vs Virtual Architecture
- Các tùy chọn lưu trữ giúp chúng ta linh hoạt trong việc thiết lập bộ nhớ dựa trên các yêu cầu về chi phí, hiệu suất và khả năng quản lý.
- vSphere VMFS cung cấp một kiến ​​trúc lưu trữ phân tán (distributed storage architecture), nơi nhiều máy chủ ESXi có thể read/write đồng thời vào bộ nhớ dùng chung.
- Bộ nhớ dùng chung (**Shared storage**) hữu ích cho Phục hồi sau thảm họa (**Disaster Recovery - DR**), Tính khả dụng cao (**High Availability - HA**) và di chuyển các máy ảo giữa các máy chủ (**VMotion**).

<a href="https://imgur.com/rC9qbXQ"><img src="https://i.imgur.com/rC9qbXQ.png" title="source: imgur.com" /></a>

# vSphere Storage - Datastores
- Datastore là một đơn vị lưu trữ logic có thể sử dụng không gian đĩa trên một thiết bị vật lý hoặc trên một số thiết bị vật lý.
- Datastore được sử dụng để chứa các tệp máy ảo (VM), Mẫu (Templates) và ISO images.
- Một máy ảo được lưu trữ dưới dạng một tập hợp các tệp trong thư mục riêng của nó hoặc như một nhóm các đối tượng trong một datastore.

- vSphere hỗ trợ các loại Datastore sau:

1. VM File System (VMFS)
2. Network File System (NFS)
3. Virtual SAN (vSAN)
4. Virtual Volumes (vVols)

<a href="https://imgur.com/h5LPJHJ"><img src="https://i.imgur.com/h5LPJHJ.png" title="source: imgur.com" /></a>

# vSphere Storage - Tổng quan

<a href="https://imgur.com/2fztNFq"><img src="https://i.imgur.com/2fztNFq.png" title="source: imgur.com" /></a>

- ESXi hosts nên được cấu hình shared access tới datastores
# vSphere Storage Technologies

- Trong môi trường vSphere, các máy chủ ESXi, vCenter hỗ trợ một số công nghệ lưu trữ sau:

- **Direct Attached Storage (DAS):**
  - Các đĩa hoặc mảng lưu trữ bên trong hoặc bên ngoài (Just a Bunch of Disks -JBOD) được gắn vào máy chủ lưu trữ thông qua kết nối trực tiếp thay vì kết nối mạng.
- **Fibre Channel (FC):**
  - Một giao thức truyền tải tốc độ cao được sử dụng cho SANS. Fibre Channel đóng gói các lệnh SCSI, được truyền giữa các nút Fibre Channel.
  - nút (node) Fibre Channel là một **Máy chủ**, một hệ thống lưu trữ (**storage system**) hoặc một ổ đĩa băng (tape drive).
  - Một FC Switch kết nối nhiều nút với nhau, tạo thành kết cấu trong mạng Fibre Channel.
- **FCOE:**
  - Lưu lượng **Fibre Channel** được đóng gói thành các frame **Fibre Channel over Ethernet** (FCoE).
  - Các frame FCOE này được hội tụ với các loại traffic khác trên mạng Ethernet.
- **iSCSI:**
  - Một giao thức truyền tải SCSI, cung cấp quyền truy cập vào các thiết bị lưu trữ và đi cáp qua mạng TCP/IP tiêu chuẩn.
  - iSCSI ánh xạ lưu trữ theo hướng block SCSI qua TCP/IP, Trình khởi tạo (Initiators), ví dụ như **iSCSI host bus adapter** (HBA) trong máy chủ ESXi, gửi lệnh SCSI đến các mục tiêu, nằm trong hệ thống lưu trữ iSCSI.

- **Network Attached Storage (NAS)**
  - Storage được chia sẻ qua mạng Standard TCP/IP ở cấp hệ thống tệp.
  - Storage NAS được sử dụng để chứa các NFS datastore.
  - Giao thức NFS **không hỗ trợ** các lệnh SCSI.
- FCOE, ISCSI và NAS có thể chạy các mạng tốc độ cao (**high-speed network**), tăng mức hiệu suất lưu trữ và đảm bảo đủ băng thông.

- Với đủ băng thông, nhiều loại lưu lượng giao thức băng thông cao có thể cùng tồn tại trên cùng một mạng.

# vSphere Storage - Sơ đồ khái niệm
- Các VM đang truy cập các loai storage khác nhau.

<a href="https://imgur.com/ksLDsWi"><img src="https://i.imgur.com/ksLDsWi.png" title="source: imgur.com" /></a>

# So sánh các loại lưu trữ

- Mỗi giao thức khác nhau có tập hợp các tính năng được hỗ trợ riêng

Technology|Protocols|Transfers| Interface
|---|---|---|---|
Fibre Channel (FC)|FC/SCSI|Block access of data/LUN|FC HBA
Fibre Channel over Ethernet (FCOE)|FCOE/SCSI|Block access of data/LUN|Converged Network Adapter (hardware FCOE)
iSCSI| IP/SCSI| Block access of data/LUN |iSCSI HBA or iSCSI-enabled NIC (hardware iSCSI)<br>Network adapter (software iSCSI)
NAS| IP/NFS| File (no direct LUN access)| Network adapter
Virtual SAN| VSAN| Block access of data| Network adapter
vVols|FC, iSCSI|VMFS & NFS|NIC & HBA

# vSphere Storage - Các tính năng hỗ trợ

Storage Type|Boot VM|ESXI Boot from SAN|Datastore|RDM|VM Cluster|vMotion| VMware HA | VMware DRS| Storage APIs-Data Protection|
|---|---|---|---|---|---|---|---|---|---|
Local Storage|yes| No|VMFS 6|No|Yes*|Yes*|No|No|Yes|
Fibre Channel|Yes|Yes|VMFS 6|Yes|Yes|Yes|Yes|Yes|Yes|
iSCSI|Yes|Yes|VMFS 6|Yes|Yes|Yes|Yes|Yes|Yes|
NAS over NFS|Yes|No|NFS3 & NFS 4.1|No|No|Yes|Yes|Yes|Yes|
vSAN Storage|Yes|No|vSAN|No|Yes|Yes|Yes|Yes|Yes|
vSphere Virtual Volumes (vVols)|Yes|No|VMFS và NFS|No|Yes|Yes|Yes|Yes|Yes|

- Local storage hỗ trợ một cluster máy ảo trên một host duy nhất (còn được gọi là **a cluster in a box**).
- Cần một shared virtual disk.
- **DAS** hỗ trợ **vSphere vMotion** khi kết hợp với **vSphere Storage vMotion**.

# vSphere trên Kiến trúc NFS/NAS Storage

- NFS là một giao thức chia sẻ tệp (**file-sharing protocol**) mà các host ESXi sử dụng để giao tiếp với thiết bị lưu trữ gắn liền với mạng (network attached storage - NAS).
- NFS hỗ trợ NFS version 3 and 4.1 qua TCP/IP.
- Cả NFS and NAS đều đề cập đến cùng một type of storage protocol và các thuật ngữ (terms) sẽ được sử dụng thay thế cho nhau (interchangeably).

<a href="https://imgur.com/398IxHf"><img src="https://i.imgur.com/398IxHf.png" title="source: imgur.com" /></a>

# NFS Storage - Cấu trúc và Thành phần

- Hệ thống tệp **NFS** nằm trên thiết bị **NAS** được gọi là **NFS Server**.
- **Máy chủ NFS** chứa một hoặc nhiều thư mục được chia sẻ với máy chủ ESXI qua mạng TCP/IP.
- Máy chủ ESXi truy cập máy chủ NFS thông qua **cổng VMkernel** được xác định trên một **vSwitch**.

<a href="https://imgur.com/cZVGR0D"><img src="https://i.imgur.com/cZVGR0D.png" title="source: imgur.com" /></a>

# NFS Storage Architecture - Định địa chỉ và Kiểm soát truy cập (Access Control) với NFS

- Máy chủ ESXi truy cập máy chủ NFS thông qua địa chỉ IP hoặc host name của máy chủ NFS.
- Cổng VMkernel được cấu hình bằng địa chỉ IP và nó được kết nối với mạng có quyền truy cập vào máy chủ NFS.
- Phiên bản NFS 4.1 và NFS phiên bản 3 có sẵn với vSphere 7.x
- Thư mục được chia sẻ với máy chủ ESXi qua mạng.
- Các tính năng khác nhau được hỗ trợ với các phiên bản khác nhau của giao thức
  - NFS 4.1 hỗ trợ đa phân vùng (multipathing) không giống như NFS 3
  - NFS 3 hỗ trợ tất cả các tính năng vSphere.
  - NFS 4.1 không hỗ trợ Storage DRS, VMware vSphere Storage I/O Control, VMware vCenter Site Recovery Manager và Virtual Volumes

<a href="https://imgur.com/vxGuFV7"><img src="https://i.imgur.com/vxGuFV7.png" title="source: imgur.com" /></a>

# NFS Datastore - Cấu hình

**Tạo một VMkernel port:**
- Để hiệu suất và bảo mật tốt hơn, hãy tách mạng NFS khỏi mạng iSCSI.

Cung cấp các thông tin sau:

- NFS version: v3 or v4.1
- Tên Datastore
- Tên máy chủ NFS hoặc địa chỉ IP
- Thư mục trên NFS server.
  - ví dụ: /templates and /nfs_share
- Chọn hosts sẽ mount tới datastore
- Có mount hệ thống tệp NFS read-only/RW hay không
- Các thông số xác thực

<a href="https://imgur.com/ZIevI44"><img src="https://i.imgur.com/ZIevI44.png" title="source: imgur.com" /></a>

# NFS Datastore Configuration & Management - Home lab

Quy trình xây dựng máy chủ NAS và tạo 1 NFS Datastore
|Bước NFS Pre-Configuration|
|---|
|Thiết lập môi trường NFS Storage|
|Nếu sử dụng xác thực Kerberos với datastore NFS 4.1, đảm bảo cấu hình các máy chủ ESXi để xác thực Kerberos (Optional)|
Tạo một **VMkernel Port group**|
|Lấy địa chỉ IP máy chủ NFS, tên Share Folder|
|Chọn NFS Version 3 hoặc 4.1|
|Thông tin đăng nhập máy chủ NFS|

NFS Configuration Procedure|
|---|
Thêm vai trò máy chủ NFS (**NFS Server role**) trên Windows Server 2022 |
Tạo thư mục và cung cấp quyền Chia sẻ NFS, Cho phép truy cập root |
Trong vSphere Client object navigator, duyệt đến host, cluster hoặc data center |
Chuột phải vào **menu**, chọn **Storage> New Datastore** |
Chọn NFS làm loại datastore và chỉ định phiên bản NFS 3 hoặc 4.1 |
Nếu nhiều máy chủ truy cập vào cùng một kho dữ liệu (datastore), cần phải sử dụng cùng một giao thức trên tất cả các máy chủ. (Optional) |
Nhập **Datastore Name, Share folder name** & Tên máy chủ NFS hoặc **Địa chỉ IP** |
Nếu đang tạo một kho dữ liệu ở cấp độ data center hoặc cluster, hãy chọn các host cần mount với kho dữ liệu. |
Review các cấu hình đã chọn và click vào **Finish**. |

Bước NFS Post-Installation|
|---|
Xác thực NFS Datastore mới|
Tạo một VM và xác minh các file VM trên NFS Datastore|



# Tài liệu tham khảo
1. https://www.youtube.com/watch?v=sErpXMXCyfY&list=PLjsBan7CwUQAFA9m2dYEL2FmeRdRiyWBD&index=16