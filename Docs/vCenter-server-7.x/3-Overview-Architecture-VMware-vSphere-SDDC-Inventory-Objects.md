<h1> Tổng quan Kiến trúc VMware vSphere, SDDC, Inventory Objects </h1>

<h2> Summary </h2>

- [1. Tổng quan về Kiến trúc cấp cao (High-Level) VMware vSphere](#1-tổng-quan-về-kiến-trúc-cấp-cao-high-level-vmware-vsphere)
- [2. Software-Defined Data Center (SDDC) - Tổng quan](#2-software-defined-data-center-sddc---tổng-quan)
- [3. vCenter Inventory Objects, Features & Integrations](#3-vcenter-inventory-objects-features--integrations)

# 1. Tổng quan về Kiến trúc cấp cao (High-Level) VMware vSphere  

<a href="https://imgur.com/hWoUVnI"><img src="https://i.imgur.com/hWoUVnI.png" title="source: imgur.com" /></a>

Bắt đầu tìm hiểu từ dưới lên:
<h3>Phần đầu tiên là tài nguyên vật lý</h3>

- Trong mô hình này chúng ta có 3 máy chủ
- Để có thể kết nối với phần cứng, ta cần một số **thiết bị mạng** (ở đây ký hiệu là **NW**)
- Và để lưu trữ tất cả dữ liệu máy ảo, chúng ta cần **storage**
- Tất cả gọi chung là **Computer network and storage**
<h3> Tầng 2 là Các dịch vụ cơ sở hạ tầng </h3>

- Bao gồm hệ điều hành ESX (ESXi1,...)
- Và trong các dịch vụ cơ sở hạ tầng có 2 khái niệm chính là Khái niệm **Network** và **Storage**
- Trong khái niệm Network, chúng ta đã nói về
  - **Standard vSwitch**, cách tạo một Standard vSwitch có sẵn trong hộp ESX, khi cài đặt nó đi kèm với một vSwitch mặc định và tuỳ theo yêu cầu ta có thể tạo nhiều vSwitch
  - **Distributed vSwitch** (vSwitch phân tán): Ví dụ ta có 3 host ESXi, thay vì cấu hình vswitch 3 lần, chúng ta có thể thực hiện tất cả **cấu hình của mình một lần** tại Distributed vSwitch.
  - **VMware NSX-T**: NSX có nghĩa là một ảo hoá mạng
    - **NSX-V** có nghĩa là nó chỉ được hỗ trợ cho sản phẩm vsphere
    - Nhưng **NSX-T** có nghĩa là nó **không giới hạn** ở vSphere mà mà có thể sử dụng NSX-T cho **bất kỳ môi trường nào** (vSphere, Private cloud,...) (Sẽ nói về NSX-T trong các bài sau)
    - **VMware vSphere và Network I/O Control**: Kiểm soát đầu vào và đầu ra
- Về **Storage**:
  - Trong môi trường vSphere, Có **2 loại** hệ thống tệp được hỗ trợ (VMFS và NFS)
    - **VMFS** có nghĩa là một số hệ thống tệp máy
    - **NFS** có nghĩa là hệ thống tệp mạng
  - Một số khái niệm lưu trữ bổ sung:
    - **VMwarre Virtual Volumes**: Được coi là ổ ảo
    - Một bộ nhớ ảo khác là **VMware vSAN** có nghĩa là mạng khu vực lưu trữ ảo (Tương tự như NSX-T của Network)
    - Thin & Thick Provisioning: 
      - Thin: Khi tạo 1 máy ảo với 100GB, giả sử hệ điều hành tiêu tốn 10GB, còn lại 90GB nó vẫn hiển thị không gian chưa được phân bổ
      - Thick: Khi gán một đĩa 100GB thì toàn bộ 100GB đã chiếm từ cấp dữ liệu của chúng ta
    - vSphere Storage I/O Control
    - 3 thành phần quan trọng là vSphere, VMware vSAN và NSX-T 
- Một khái niệm khác: Cluster
  - Là một nhóm nhiều nút (Nút ở đây là hộp ESXi). Vì vậy khi nhóm nhiều nút ESXi lại thành một hộp được gọi là cluster
  - Trong cụm bao gồm: máy chủ, Memory, CPU, Nic,.. sẽ biến nó thành một nhóm tài nguyên
  - Ở trên cùng của cụm có thể cung cấp nhiều máy ảo, trong máy ảo cài đặt Guest OS, trên Guest OS chúng ta có thể cài các ứng dụng cần sử dụng. (Ví dụ Office trên Guest OS là window,...)

<h3> Tầng Application Services</h3>

- Tất cả các máy ảo đều có thể quản lý từ Bảng điều khiển máy chủ vCenter, khi đăng nhập vào vCenter và thêm host, chúng ta sẽ nhận được tất cả các tính năng sẵn cõ và các tính năng mở rộng (trong hình chỉ nói một số tính năng chính)
- Availability:
  - Ví dụ: tính năng VMware vSphere vMotion. Giả sử máy ảo đang chạy trên esxi1, chúng ta muốn chuyển từ esxi1 sang esxi2, chúng ta sử dụng vMotion. Nó giống như một tính năng di chuyển trực tiếp, chúng ta không cần phải tắt VM (không bị tác động gì), chúng ta có thể di chuyển VM từ ESxi1 sang bất kỳ host esxi nào khác.
  - Một tính năng khác là Storage vMotion, nó ở cấp độ lưu trữ dữ liệu ngay cả khi máy ảo của chúng tôi đang chạy trên một kho dữ liệu bằng cách sử dụng tính năng lưu trữ vMotion, chúng ta có thể di chuyển VM từ một kho dữ liệu này sang kho dữ liệu khác
  - Một ví dụ nhanh cho vMotion:
    - Khi muốn khởi động lại ESXi1, nó sẽ tác động đến tất cả các máy ảo trên ESXi1. 
      - Vì vậy, khi có ý định thực hiện bất kỳ khởi động lại nào ở cấp độ máy chủ ESX, khuyến nghị duy nhất là di chuyển tất cả các máy ảo sang host ESXi khác, sau đó đặt máy chủ sang chế độ bảo trì sau đó tiến hành khởi động lại
      - Do đó, trong các cửa sổ bảo trì hosts, chúng ta có thể lên kế hoạch sử dụng tính năng vMotion
    - Giả sử khi kho dữ liệu đầy, ta có thể di chuyển VMS từ một kho dữ liệu, giúp giảm dung lượng lưu trữ dữ liệu và cũng giúp tách biệt VMS (Ví dụ muốn di chuyển tất cả các VMS lab trên một kho dữ liệu lab )

  - VMware vSphere High Availability: 
    - Mục đích: Bất cứ khi nào host ESX không có kế hoạch bảo trì đột ngột ESXi1 bị lỗi, chúng ta không cần bận tâm về máy ảo nếu chúng tôi bật tính năng sẵn sàng cao, nó sẽ xử lý việc di chuyển tất cả các máy ảo đến host khác một cách tự động
  - VMware vSphere FT: Khả năng chịu lỗi mặc định là một trong những tính năng nâng cao
    - Nó sẽ cung cấp thời gian chết bằng 0, vì vậy nếu bạn muốn kích hoạt khả năng chịu lỗi, chúng ta phải có giấy phép cộng với doanh nghiệp đẻ kích hoạt tính năng chịu lỗi

  - VMware Data Recovery:
    - Đây cũng là một trong những tính năng vmware mặc định trong công cụ được phát triển
    - Nó hữu ích cho việc sao lưu và phục hồi
- Tính năng: Khả năng mở rộng: Hữu ích cho việc mở rộng và giảm quy mô
  - DRS: có nghĩa là bộ lập lịch tài nguyên phân phối. Đây cũng là một trong những kỹ thuật cân bằng tải. Bât cứ host esx nào bị quá tải hoàn toàn như ử dụng hơn 80%, để cân bằng tải trên host esx trong số tất cả các host được liên kết. Khi bật DRSn nó sẽ xử lý tất cả cân bằng tải máy ảo.
    - Giả sử ta có 10 máy ảo, ta muốn phân phối tất cả tải máy ảo trong số 3 host esxi này. Chúng ta không cần bận tâm về quy trình thủ công khi bật DRS, nó sẽ tự động xử lý.
  - DPM: có nghĩa là quản lý điện năng phân tán, đây cũng là một trong những tính năng hữu ích để kiểm soát việc quản lý ESX của bạn (Giải thích trong các bài sau)
  - Hot Add: Tính năng bổ sung nóng tài nguyên, các thiết bị đều có thể cắm nóng có nghĩa là khi máy ảo được cấp nguồn và trạng thái chúng ta không cần bật nguồn chúng ta chỉ cần thêm tất cả các thiết bị phần cứng
  - Over Commitment: là một trong những tuỳ chọn ngay cả khi bạn không có đủ tài nguyên trong mức lưu trữ vật lý hoặc tài nguyên bộ nhớ cpu cấp máy chủ ESX thì chúng ta vẫn có thể khắc phục được. VMware cho phép thực hiện over commitment
  - Content Library: Thư viện nội dung duy trì tất cả các tệp ISO mẫu máy ảo và bất kỳ thông tin phần mềm bổ sung nào mà chúng tôi tập trung duy trì tất cả các tệp Iso và kết xuất trong thư viện nội dung từ thư viện nội dung mà chúng ta phân phối bên trong một cụm không chỉ một cụm, chúng ta có thể chia sẻ nó cho các cụm khác được.
    - Đó là tầm quan trọng của thư viện nội dung

--- Tìm hiểu đến đây: 22:17 ---
# 2. Software-Defined Data Center (SDDC) - Tổng quan

- Trong software-defined data center (SDDC), tất cả cơ sở hạ tầng đều được ảo hóa và việc kiểm soát data center được tự động hóa bằng phần mềm. vSphere là nền tảng của SDDC.




- Service Management and Automation : Quản lý dịch vụ và tự động hoá
    - vRealize Operations
    - vRealize Automation
    - vRealize Orchestrator
- Cloud Management Layer: Lớp quản lý đám mây
  - Service Catalog : Danh mục dịch vụ
  - Self-Service Portal: Cổng tự phục vụ
  - Orchestration
- Virtual Infrastructure Layer: Lớp cơ sở hạ tầng ảo
  - VMware vSphere
  - VMware vSAN
  - VMware NSX
- Physical Layer
  - Compute
  - Storage
  - Network
- Business Continuity: Kinh doanh liên tụu
    - Site Recovery Manager
    - vSphere Replication
- Security
    - AppDefense
    - NSX Microsegmentation
    - Carbon Black



# 3. vCenter Inventory Objects, Features & Integrations

|#|vCenter Inventory Objects|Detail
|---|---|---|
1|VAMI
2|Datacentres
3|Hosts & Clusters
4|VMs & Templates
5|Storage VMFS, NFS
6|Networking
7|Content Libraries| Thư viện nội dung
8|Global Inventory Lists|
9|Task Console
10|Event Console
12|VM Storage Policies
13|Host Profiles
14|Life Cycle Manager (LCM)
15|Licensing Management

|#|Tính năng vCenter|Detail
|---|---|---|
16|Hot-Add, Hot-Pluggable Devices
17|Folders
18|VMs
19|Snapshot
20|Clone
21|Templates
22|Resource Pools| Hồ chứa, kho tài nguyên|
23|vApps
24|Schedule Tasks|Công việc theo lịch
25|Developer Center| Trung tâm nhà phát triển|
26|Distributed vSwitches (Dvs)| vswitch phân tán|
27|Distributed Port groups|
28|Cold Migration
29|VMotion
30|Storage VMotion
31|vSphere High Availability (HA)| Tính sẵn sàng cao
32|vSphere Distributed Resource Schedule (DRS)| Lịch tài nguyên phân tán
33|Storage DRS
34|vSphere Fault Tolerance (FT)
35|Enhanced VMotion Compatibility (EVC)
36| Distributed Power Management (DPM)| Quản lý nguồn điện phân tán
37|vCenter Storage Monitoring|
38|vCenter Hardware Monitoring|
39|vSphere Service Status & Alarms|
40|Thin Provision Virtual Disks| Cung cấp Disk dạng Thin|
41|Thick Provision Lazy Zeroed Virtual Disks
42|Thick Provision Eager Zeroed Virtual Disks
43|Certificate Management
44|Tags & Custom Attributes|Các thẻ & Thuộc tính tuỳ chỉnh|
45|Roles & Permissions|Vai trò và quyền

|#|vCenter Các tính năng & Tích hợp|Detail|
|---|---|---|
46|Auto Deploy| Triển khai tự động
47|vCenter Server High Availability (VCHA)
48|VSAN (SDS) & Virtual Volumes|VSAN(SDS) & dung lượng ảo
49|vRealize Automation (VRA)
50|vRealize Orchestrator (vRO)
51|vRealize Log Insight (vRLI)
52|vRealize Network Insight (vRNI)
53|VMware Horizon
54|VMware SRM
55|Hybrid Cloud Services
56|NSX-T Data Center (SDN)
57|vRealize Operations Manager (vROps)
58|VMware Converter (P2V, V2V)| Công cụ chuyển đổi VMware|
59|Workload Management (Tanzu)| Quản lý khối lượng công việc|
60|Cloud Provider Migration| Di chuyển nhà cung cấp cloud|
