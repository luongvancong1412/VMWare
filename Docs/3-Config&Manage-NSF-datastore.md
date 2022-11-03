<h1> Cấu hình và quản lý NSF Datastore</h1>

<h2>Mục lục</h2>

- [Kiến trúc vật lý vs Virtual Architecture](#kiến-trúc-vật-lý-vs-virtual-architecture)
- [vSphere Storage - Datastores](#vsphere-storage---datastores)
- [vSphere Storage - Overview](#vsphere-storage---overview)
- [vSphere Storage Technologies](#vsphere-storage-technologies)
- [vSphere Storage with Conceptual Diagram](#vsphere-storage-with-conceptual-diagram)
- [Comparing Types of Storage](#comparing-types-of-storage)
- [vSphere Features supported by Storage](#vsphere-features-supported-by-storage)
- [vSphere on NFS/NAS Storage Architecture](#vsphere-on-nfsnas-storage-architecture)
- [NFS Storage Architecture & Components](#nfs-storage-architecture--components)
- [NFS Storage Architecture - Addressing and Access Control with NFS](#nfs-storage-architecture---addressing-and-access-control-with-nfs)
- [NFS Datastore - Configuration](#nfs-datastore---configuration)
- [NFS Datastore Configuration & Management - Home lab](#nfs-datastore-configuration--management---home-lab)

# Kiến trúc vật lý vs Virtual Architecture
- Các tùy chọn lưu trữ giúp chúng ta linh hoạt trong việc thiết lập bộ nhớ dựa trên các yêu cầu về chi phí, hiệu suất và khả năng quản lý.
- vSphere VMFS cung cấp một kiến ​​trúc lưu trữ phân tán (distributed storage architecture), nơi nhiều máy chủ ESXi có thể read/write đồng thời vào bộ nhớ dùng chung.
- Bộ nhớ dùng chung (**Shared storage**) hữu ích cho Phục hồi sau thảm họa (**Disaster Recovery - DR**), Tính khả dụng cao (**High Availability - HA**) và di chuyển các máy ảo giữa các máy chủ (**VMotion**).
# vSphere Storage - Datastores
- A datastore is a logical storage unit that can use disk space on one physical device or span several physical devices.
- Datastores are used to hold virtual machine(VM) files, Templates, and ISO images.
- A VM is stored as a set of files in its own directory or as a group of objects in a datastore.
- vSphere supports the following types of datastores:

1. VM File System (VMFS)
2. Network File System (NFS)
3. Virtual SAN (VSAN)
4. Virtual Volumes (vVols)

# vSphere Storage - Overview
- ESXi hosts should be configured with shared access to datastores
# vSphere Storage Technologies
- In the vSphere environment, ESXi hosts, vCenter support several storage technologies.
- **Direct Attached Storage (DAS):**
  - Internal or external storage disks or arrays (Just a Bunch of Disks -JBOD) attached to host through a direct connection instead of a network connection.
- **Fibre Channel (FC):**
  - A high-speed transport protocol used for SANS. Fibre Channel encapsulates SCSI commands, which are transmitted between Fibre Channel nodes.
  - In General, a Fibre Channel node is a Server, a storage system, or a tape drive.
  - A FC Switch interconnects multiple nodes, forming the fabric in a Fibre Channel network.
- **FCOE:**
  - The Fibre Channel traffic is encapsulated into Fibre Channel over Ethernet (FCoE) frames.
  - These FCOE frames are converged with other types of traffic on the Ethernet network.
- **iSCSI:**
  - A SCSI transport protocol, providing access to storage devices and cabling over standard TCP/IP networks.
  - iSCSI maps SCSI block-oriented storage over TCP/IP, Initiators, such as an iSCSI host bus adapter (HBA) in an ESXi host, send SCSI commands to targets, located in iSCSI storage systems.
- **Network Attached Storage (NAS):**
  - Storage shared over Standard TCP/IP networks at the file system level.
  - NAS storage is used to hold NFS datastores.
  - The NFS protocol does not support SCSI commands.
- FCOE, ISCSI and NAS can run high-speed networks providing increased storage performance levels and ensuring sufficient bandwidth.
- With sufficient bandwidth, multiple types of high-bandwidth protocol traffic can coexist on the same network.
# vSphere Storage with Conceptual Diagram
- VMs are accessing different types of storage
# Comparing Types of Storage
- Each different protocol has its own set of supported features
Technology Protocols Interface

Fibre Channel (FC)  FC/SCSI Block access of data/LUN FC HBA
Fibre Channel over Ethernet (FCOE) FCOE/SCSI Block access of data/LUN Converged Network Adapter (hardware FCOE)
iSCSI IP/SCSI Block access of data/LUN iSCSI HBA or iSCSI-enabled NIC (hardware iSCSI) Network adapter (software iSCSI)
NAS IP/NFS File (no direct LUN access) Network adapter
Virtual SAN VSAN Block access of data Network adapter
Wolsv  FC, iSCSI VMFS & NFS NIC & HBA

# vSphere Features supported by Storage

Storage Type|Boot VM|ESXI Boot from SAN|Datastore|RDM|VM Cluster|vMotion| VMware HA | VMware DRS| Storage APIs-Data Protection|
|---|---|---|---|---|---|---|---|---|---|---|
Local Storage|yes| No|VMFS 6|No|Yes*|Yes*|No|No|Yes|
Fibre Channel|Yes|Yes|VMFS 6|Yes|Yes|Yes|Yes|Yes|Yes|
iSCSI|Yes|Yes|VMFS 6|Yes|Yes|Yes|Yes|Yes|Yes|
NAS over NFS|Yes|No|NFS3 & NFS 4.1|No|No
- Local storage supports a cluster of virtual machines on a single host (also known as a cluster in a box).
- A shared virtual disk is required.
- DAS supports vSphere vMotion when combined with vSphere Storage vMotion.

# vSphere on NFS/NAS Storage Architecture
- NFS is a file-sharing protocol that ESXi hosts use to communicate with a network attached storage (NAS) device.
- NFS supports NFS version 3 and 4.1 over TCP/IP.
- To clarity, both NFS and NAS refer to the same type of storage protocol and the terms will be used interchangeably.
# NFS Storage Architecture & Components
- An NFS file system is located on a NAS device that is called the NFS server.
- The NFS server contains one or more directories that are shared with the ESXI host over a TCP/IP network.
- An ESXi host accesses the NFS server through a VMkernel port that is defined on a virtual switch.
+ NAS device or a Server with storage
+ Directory to share with the ESXi host over the network
+ ESXi host with NIC mapped to virtual switch
+ VMkernel port defined on virtual switch

# NFS Storage Architecture - Addressing and Access Control with NFS
- The ESXi host accesses the NFS server through the NFS server's IP address or host name.
- The VMkernel port is configured with an IP address, and it is connected to a network that has access to the NFS server.
- NFS version 4.1 and NFS version 3 are available with vSphere 7.x
- Directory to share with the ESXi host over the network
- Different features are supported with different versions of the protocol
  - NFS 4.1 supports multipathing unlike NFS 3
  - NFS 3 supports all vSphere features.
  - NFS 4.1 does not support Storage DRS, VMware vSphere Storage I/O Control, VMware vCenter Site Recovery Manager, and Virtual Volumes

# NFS Datastore - Configuration

Create a VMkernel port:
- For better performance and security, separate our NFS network from the iSCSI network.
Provide the following information:
- NFS version: v3 or v4.1
- Datastore name
- NFS server names or IP addresses
- Folder on the NFS server.
  - for example: /templates and /nfs_share
- Select hosts that will mount the datastore
- Whether to mount the NFS file system read-only/RW
- Authentication parameters
# NFS Datastore Configuration & Management - Home lab

NAS Server Build Procedure and Create a NFS Datastore
|NFS Pre-Configuration Steps|
|---|
|Setup NFS Storage Environment|
|If we plan to use Kerberos authentication with the NFS 4.1 datastore, make sure to configure the ESXi hosts for Kerberos authentication (Optional)|
Create a VMkernel Port group|
|Get the NFS Server IP Address, Share Folder Name|
|Choose the NFS Version 3 or 4.1|
|NFS Server Login Credentials|

NFS Configuration Procedure|
|---|
Add NFS Server role on Windows Server 2022|
Create a folder and provide NFS Share permission, Allow root access|
In the vSphere Client object navigator, browse to a host, a cluster, or a data center|
From the right-click menu, select Storage > New Datastore|
Select NFS as the datastore type and specify an NFS version 3 or 4.1|
If multiple hosts access the same datastore, we must use the same protocol on all hosts. (Optional)|
Enter Datastore Name, Share folder name & NFS Server name or IP Address|
If we are creating a datastore at the data center or cluster level, select hosts that mount the datastore.|
Review the configuration options and click Finish.|

NFS Post-Installation Steps|
|---|
Validate the new NFS Datastore|
Create a VM and verify the VM files on NFS Datastore|