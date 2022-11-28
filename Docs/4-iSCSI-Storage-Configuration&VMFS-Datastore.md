<h1>Session 3: iSCSI Storage Configuration & VMFS Datastore</h1>

# VMFS Datastore - Overview

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
# iSCSI Storage Architecture - Components
<a href="https://imgur.com/YEtQmJl"><img src="https://i.imgur.com/YEtQmJl.png" title="source: imgur.com" /></a>

- An iSCSI SAN consists of an iSCSI storage system, which contains one or more LUNs and one or more storage processors (SPs). Communication between the host and the storage array occurs over a TCP/IP network.

- The ESXi host is configured with an iSCSI initiator. An initiator can be hardware-based, in which case the initiator is an iSCSI host bus adapter (HBA).

- The initiator can also be software-based; this is known as the iSCSI software initiator.

- An initiator transmits SCSI commands over the IP network. A target receives SCSI commands from the IP network. You can have multiple initiators and targets in your ISCSI network. ISCSI Is SAN oriented because:
  - The initiator finds one or more targets
  - A target presents LUNs to the initiator
  - The initiator sends SCSI commands to a target

- An initiator resides in the ESXi host. Targets reside in the storage arrays that are supported by the ESXi host.
- iSCSI arrays can use various mechanisms, including IP address, subnets, and authentication requirements, to restrict access to targets from hosts.

# iSCSI Storage Architecture - Addressing

- Other than the standard IP addresses, iSCSI targets are identified by names as well
- The iSCSI Qualified Name (IQN) format takes the form iqn.yyyy-mm.naming-authority:unique name

- The main addressable, discoverable entity is an iSCSI node. An iSCSI node can be an initiator or a target. An iSCSI node requires a name so that storage can be managed regardless of address.

- The iSCSI name can use one of the following formats:
  - The iSCSI qualified name (IQN) or the extended unique identifier (EUI).

- The IQN can be up to 255 characters long. The naming convention
  - The prefix "ign"
  - A date code specifying the year and month in which the organization registered the domain or subdomain name used as the naming authority string
  - The organizational naming authority string, which consists of a valid, reversed domain or subdomain name
  - (Optional) A colon (:), followed by a string of the assigning organization's choosing, which must make each assigned ISCSI name unique

- The EUI naming convention
  - The prefix "eul,"
  - followed by a 16-character name.
  - The name includes 24 bits for a company name that is assigned by the IEEE and 40 bits for a unique ID, such as a serial number.

# VMFS Datastore - Features and Functionalities
# iSCSI Storage Architecture
## iSCSI Components
## iSCSI Addressing
## iSCSI Initiators
- We must set up software or hardware iSCSI adapters before an ESXi host can work with iSCSI Storage.
- To access iSCSI targets, Our ESXi hosts uses iSCSI initiators

<a href="https://imgur.com/CVrjSO6"><img src="https://i.imgur.com/CVrjSO6.png" title="source: imgur.com" /></a>


## ISCSI Storage Architecture - iSCSI Initiators

- The iSCSI initiators transport SCSI requests and responses, encapsulated into the iSCSI protocol, between the host and the iSCSI target.
- ESXi supports two types of initiators: software iSCSI and hardware iSCSI.
- A software iSCSI initiator is VMware code built in to the VMkernel. The initiator enables our host to connect to the iSCSI storage device through standard network adapters. The software iSCSI initiator handles iSCSI processing while communicating with the network adapter. With the software iSCSI initiator, we can use iSCSI technology without purchasing specialized hardware.

- A hardware iSCSI initiator is a specialized third-party adapter capable of accessing iSCSI storage over TCP/IP.
- Hardware iSCSI initiators are divided into two categories: dependent hardware iSCSI and independent hardware iSCSI.
- A dependent hardware iSCSI initiator, or adapter, depends on VMware networking and on iSCSI configuration and management interfaces that are provided by VMware. This type of adapter presents a standard network adapter and iSCSI offload function for the same port.
- An independent hardware ISCSI adapter handles all iSCSI and network processing and management for your ESXi host
- The final decision on the storage adapter to purchase can be driven by many factors cost, failover capabilities, CPU overhead, and whether booting from SAN is required

# iSCSI Storage Configuration and Create a VMFS Datastore - Lab

iSCSI Storage Configuration and Create a VMFS Datastore

|iSCSI Storage > Pre-Configuration Steps|
|---|
|Setup iSCSI Storage Environment|
|Install and configure any iSCSI adapters that our storage requires|
|Create a VMKernel Portgroup|
|Get the ISCSI Storage Addressing or IP Address & LUN details|
|ISCSI SAN-required Credentials (CHAP)|
|Verify that storage devices we are planning to use for our datastores are available.|

|iSCSI SAN> Configuration Procedure|
|---|
|Add iSCSI Target Server role on Windows Server 2022|
Create a folder or disk and provide iSCSI Storage permissions (Optional)
Update the Dynamic Discovery Target details
To discover newly added storage devices, perform a rescan.
In the vSphere Client object navigator, browse to a host, a cluster, or a data center 
From the right-click menu, select Storage > New Datastore
Select VMFS as the datastore type
Enter the Datastore Name and specify the datastore version.
If we are creating a datastore at the data center or cluster level, select hosts that mount the datastore.(Optional)
Review the configuration options and click Finish.

|iSCSI SAN> Post-Installation Steps|
|---|
Validate the new VMFS Datastore on the iSCSI-based storage device
Make sure that new VMFS datastore is available to all hosts that have access to the iSCSI Target device.
Create a VM and verify the VM files on VMFS Datastore.