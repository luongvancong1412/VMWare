


# Basic Storage Concepts

Storage:
- Hành động hoặc phương pháp lưu trữ thứ gì đó để sử dụng trong tương lai.
- Storage là nơi lưu trữ dữ liệu ở định dạng digital.
- Dữ liệu được lưu trữ trên thiết bị storage hoặc media có thể là bộ nhớ cục bộ (local storage) hoặc bộ nhớ ngoài (external storage)

Mục đích lưu trữ

- Lưu trữ tất cả các dữ liệu ứng dụng liên quan đến dự án.
- Các ứng dụng được tải từ Storage để chạy trong memory.
- Ứng dụng tạo ra kết quả đầu ra hoặc state. Ví dụ: MS Word, PPT, Excel,
- Bộ nhớ máy tính dễ bay hơi. Khi hệ thống tắt, nội dung sẽ biến mất.
- Để duy trì dữ liệu ứng dụng, lưu trữ liên tục (persistent storage) là điều cần thiết.

# Local Disk Storage - Protocols
- A protocol is the language that local disk storage uses to communicate with a device.
- Several commonly seen protocols are:
  - Small Computer System Interface (SCSI)
  - Serial Attached SCSI (SAS)
  - Serial Advanced Technology Attachment (SATA)
  - Universal Serial Bus (USB)
  - Fibre Channel (FC)

- Servers may need an adapter to communicate with local storage. This adapter is known as a Host Bus Adapter (HBA).

- Giao thức là ngôn ngữ mà bộ lưu trữ đĩa local sử dụng để giao tiếp với một thiết bị.
- Một số giao thức thường thấy là:
  - Small Computer System Interface (SCSI)
  - Serial Attached SCSI (SAS)
  - Serial Advanced Technology Attachment (SATA)
  - Universal Serial Bus (USB)
  - Fibre Channel (FC)

- Servers có thể cần một adapter để giao tiếp với local storage. Adapter này được gọi là **Host Bus Adapter (HBA)**.

# Các loại Storage - Apps cần một loại storage nhất định

- Block storage (Lưu trữ khối)
- File Storage (Lưu trữ tệp)
- Object Storage (Lưu trữ đối tượng)

STT|Details|Block Storage|File Storage|Object Storage|
|---|---|---|---|---|
Loại lưu trữ | Dữ liệu được lưu trữ trong các khối có kích thước cố định trong một sắp xếp cố định - lý tưởng cho Ứng dụng & Cơ sở dữ liệu doanh nghiệp. <br> Tích hợp hoàn toàn với Máy chủ. <br> Vị trí cụ thể trên Memory hoặc Disk | Dữ liệu được lưu trữ dưới dạng tệp trong các thư mục lồng nhau có phân cấp - lý tưởng cho các tài liệu làm việc đang hoạt động. <br> Network Attached Storage (NAS) được quản lý hoàn toàn <br> Thư mục cụ thể theo Thứ tự logic cố định | Dữ liệu được lưu trữ dưới dạng các đối tượng trong nhóm có thể mở rộng - lý tưởng cho dữ liệu lớn không có cấu trúc, phân tích và lưu trữ. <br> Đối với bất kỳ Ứng dụng lưu trữ bất kỳ loại và bất kỳ lượng dữ liệu nào trong bất kỳ khoảng thời gian nào và truy xuất nó thường xuyên nếu cần. <br> Kích thước vùng chứa linh hoạt, Không phụ thuộc vào nền tảng.
Ví dụ | Ổ bút, Đĩa cứng, <br> SSD, Ổ đĩa flash Amazon EC2 Instance Store <br> Amazon EBS | Tệp và thư mục dùng chung <br> Dữ liệu phi cấu trúc <br> Amazon EFS | Dropbox <br> Amazon S3 <br> Amazon Sông băng
Giao thức (Bộ nhớ được sử dụng thông qua giao thức) | FC, FCOE <br> SCSI, ISCSI <br> SATA | TCP / IP <br> Chia sẻ tệp mạng (NFS) <br> Khối thông báo máy chủ (SMB) <br> Hệ thống tệp Internet chung (CIFS) | TCP / IP <br> http, <br> Chuyển trạng thái biểu diễn (REST) ​​<br> Giao thức truy cập đối tượng đơn giản (SOAP) |
Giao diện | Hệ điều hành, <br> Bộ nhớ đính kèm trực tiếp (DAS) <br> Mạng vùng lưu trữ (SAN) | Người dùng | Chương trình (API)
Hiệu suất | Cao | Trung bình | Thấp |
Vị trí lưu trữ | Tại chỗ, Đám mây riêng | Tại chỗ, Đám mây riêng | Tại chỗ, Đám mây Riêng, Đám mây Công cộng & Kết hợp |

# Block, File & Object Storage - Use Cases
Details|Block Storage|File Storage|Object Storage|
|---|---|---|---|
Use Cases|low latency<br>Best for Structured data<br>Unstructured Data<br>Disks for VMs, VMFS Volumes<br>Share read-only data across VMs,<br>Storage for databases.<br>Frequently changing data|Good Performance<br>File sharing data<br>Media Processing<br>Application Migrations<br>Web Content Management<br>Unstructured data/File Backup

Easy Scaling with no Limits,
Accessible across LAN & WAN Streaming Videos
Images & Documents
Backups & Regulatory Archives
Websites & Configuration data
Disaster recovery (DR)
Relative static file data and as cloud storage


Proximity/Accessibility

Dedicated Network Fibre Channel/10 Gbps
LAN/10 G8
Internet

Type of Update|
Supports in-place updates
Supports in place updates

No in-place update support,
Updates create new Object versions


Scalability
(Capacity to be changed in size)

Low
High
High

Cost
Expensive
High
Low

Amount of Data
<500 Terabytes (TBS)
<100 TB or 100-500 TBs for scale out (expansion) NAS
>500 TBs and in many cases Petabytes of Data
# Storage Protection

The purpose of Block, File and Object storage are the same.
Storage Availability and data Protection

Data Protection:

Single storage devices like SSDs are subject to failure.
Data redundancy is a requirement

Protection Methodologies:

Disk Mirroring
RAID systems
Software Protections

Disk Mirroring:

To make an exact copy of data from one storage device drive to another storage device in real-time.
This serves to prevent data loss in the event of a hardware failure.
This is also known as RAID 1.

## Storage Protection Methodology

Redundant Array of Independent Disks (RAID):
Storage that is made up of multiple hard drives. The same data is stored across different disks.
The method by which this data is stored is classified by RAID levels.

RAID 0- Striping with no fault tolerance or redundancy. Designed for speed.
RAID 1- Mirroring with no striping. Designed for reliability.
There are other RAID formats that utilize both striping and mirroring.

Stripe:
To divide a piece of data into equally-sized units which are then spread across multiple storage devices; no copies of the data are made. This is often referred to as RAID 0.

# vSphere Storage - Overview
Datastores are logical containers that hide specifics of each storage device and provide a uniform model for storing virtual machine files.
Both local and/or shared storage are a core requirement for full utilization of ESXI features

Many kinds of storage can be used with vSphere
Local disks
Fiber Channel (FC) WITHOUT
ISCSI SANS
Virtual SAN (SAN)
Virtual Volumes (VVOLS)

They are generally formatted either:
A VMFS file system
The file system of the NFS Server

# Demo Lab-Setup