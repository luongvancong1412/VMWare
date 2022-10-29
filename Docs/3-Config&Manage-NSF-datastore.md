<h1> Cấu hình và quản lý NSF Datastore</h1>

<h2>Mục lục</h2>

- [Physical Architecture vs Virtual Architecture](#physical-architecture-vs-virtual-architecture)
- [vSphere Storage - Datastores](#vsphere-storage---datastores)
- [vSphere Storage - Overview](#vsphere-storage---overview)
- [vSphere Storage Technologies](#vsphere-storage-technologies)
- [vSphere Storage with Conceptual Diagram](#vsphere-storage-with-conceptual-diagram)
- [Comparing Types of Storage](#comparing-types-of-storage)
- [NFS Storage Architecture & Components](#nfs-storage-architecture--components)
- [NFS Datastore Configuration & Management - Home lab](#nfs-datastore-configuration--management---home-lab)

# Physical Architecture vs Virtual Architecture
- Storage options give us the flexibility to set up our storage based on our cost, performance, and manageability requirements.

- vSphere VMFS provides a distributed storage architecture, where multiple ESXi hosts can read & write to the shared storage concurrently

- Shared storage is useful for Disaster Recovery(DR), High Availability(HA), and moving virtual machines between hosts (VMotion).

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

# NFS Storage Architecture & Components

# NFS Datastore Configuration & Management - Home lab