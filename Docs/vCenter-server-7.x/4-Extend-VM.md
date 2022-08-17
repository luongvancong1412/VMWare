<h1>Mở rộng disk cho vm Centos 7 đang sử dụng</h1>

- [Thủ công](#thủ-công)
  - [1. Thêm Disk trên vCenter](#1-thêm-disk-trên-vcenter)
  - [2. Mở rộng disk đang sử dụng](#2-mở-rộng-disk-đang-sử-dụng)
  - [3. Mở rộng dung lượng cho thư mục root (`/`)](#3-mở-rộng-dung-lượng-cho-thư-mục-root-)
- [Tự động](#tự-động)

# Thủ công

## 1. Thêm Disk trên vCenter
Chọn VM cần thêm Disk, thực hiện Edit Settings…

<a href="https://imgur.com/jtjEynF"><img src="https://i.imgur.com/jtjEynF.png" title="source: imgur.com" /></a>

Thực hiện thêm Disk

<a href="https://imgur.com/YB3FmLz"><img src="https://i.imgur.com/YB3FmLz.png" title="source: imgur.com" /></a>

Nhập dung lượng `disk > OK`

<a href="https://imgur.com/xFajVIt"><img src="https://i.imgur.com/xFajVIt.png" title="source: imgur.com" /></a>


## 2. Mở rộng disk đang sử dụng

Lệnh kiểm tra disk được thêm:
```
lsblk
```

<a href="https://imgur.com/Yize0H4"><img src="https://i.imgur.com/Yize0H4.png" title="source: imgur.com" /></a>

**Tạo phân vùng cho disk mới**
```
fdisk /dev/sdb
```

<a href="https://imgur.com/RzhZ02a"><img src="https://i.imgur.com/RzhZ02a.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/9wsOj6S"><img src="https://i.imgur.com/9wsOj6S.png" title="source: imgur.com" /></a>

**Tạo Physical Volume**

```
pvcreate /dev/sdb1
```

Physical volume đã được thêm thành công
```
[root@localhost ~]# pvcreate /dev/sdb1
Physical volume "/dev/sdb1" successfully created.
```

Lệnh kiểm tra Physical volume
```
pvs
```

Physical volume mới là /dev/sdb1, chưa được thêm vào VG nào
```
[root@localhost ~]# pvs
  PV         VG     Fmt  Attr PSize   PFree
  /dev/sda2  centos lvm2 a--  <15.00g      0
  /dev/sdb1         lvm2 ---  <10.00g <10.00g
```


**Mở rộng Volume Group**

Kiểm tra Volume Group
```
vgs
```

Kết quả: có 1 vg tên là centos
```
[root@localhost ~]# vgs
  VG     #PV #LV #SN Attr   VSize   VFree
  centos   1   2   0 wz--n- <15.00g    0
```

Ta thấy vg centos đã dùng hết không gian trống


Thêm không gian cho vg bằng cách gắn phân vùng sdb1 vào vg centos:
```
vgextend /dev/centos /dev/sdb1
```

Thêm thành công
```
[root@localhost ~]# vgextend /dev/centos /dev/sdb1
  Volume group "centos" successfully extended
```

Kiểm tra thấy dung lượng vg centos đã tăng
```
[root@localhost ~]# vgs
  VG     #PV #LV #SN Attr   VSize  VFree
  centos   2   2   0 wz--n- 24.99g <10.00g
```

## 3. Mở rộng dung lượng cho thư mục root (`/`)

Kiểm tra logical volume

```
[root@localhost ~]# lvs
  LV   VG     Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root centos -wi-ao---- 13.39g
  swap centos -wi-ao----  1.60g
```

Tiến hành mở rộng thêm cho lv root
```
lvextend -L +5G /dev/centos/root
xfs_growfs /dev/centos/root
```
Các lệnh để mở rộng hệ thống tệp khác nhau tùy thuộc vào loại hệ thống tệp.

- **[Hệ thống tệp XFS]** Sử dụng lệnh xfs_growfs và chỉ định điểm gắn kết của hệ thống tệp
- **[Hệ thống tệp Ext4]** Sử dụng lệnh resize2fs và chỉ định tên của hệ thống tệp

Kết quả:
```
[root@localhost ~]# lvextend -L +5G /dev/centos/root
  Size of logical volume centos/root changed from 13.39 GiB (3429 extents) to 18.39 GiB (4709 extents).
  Logical volume centos/root successfully resized.

[root@localhost ~]# xfs_growfs /dev/centos/root
meta-data=/dev/mapper/centos-root isize=512    agcount=4, agsize=877824 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0 spinodes=0
data     =                       bsize=4096   blocks=3511296, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal               bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
data blocks changed from 3511296 to 4822016

```

Ta kiểm tra kết quả:
```
[root@localhost ~]# lvs
  LV   VG     Attr       LSize  Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  root centos -wi-ao---- 18.39g
  swap centos -wi-ao----  1.60g
[root@localhost ~]# vgs
  VG     #PV #LV #SN Attr   VSize  VFree
  centos   2   2   0 wz--n- 24.99g <5.00g

[root@localhost ~]# df -hT
Filesystem              Type      Size  Used Avail Use% Mounted on
devtmpfs                devtmpfs  908M     0  908M   0% /dev
tmpfs                   tmpfs     920M     0  920M   0% /dev/shm
tmpfs                   tmpfs     920M  8.8M  911M   1% /run
tmpfs                   tmpfs     920M     0  920M   0% /sys/fs/cgroup
/dev/mapper/centos-root xfs        19G  1.3G   18G   7% /
/dev/sda1               xfs      1014M  150M  865M  15% /boot
tmpfs                   tmpfs     184M     0  184M   0% /run/user/0
```

# Tự động

