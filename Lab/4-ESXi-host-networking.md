<h1>Virtual switch </h1>


<h2>Summary</h2>

- [Tạo Vswitch](#tạo-vswitch)
- [Tạo nhóm Cổng VM](#tạo-nhóm-cổng-vm)
- [Tạo nhóm Cổng VMkernel](#tạo-nhóm-cổng-vmkernel)
- [Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng](#thêm-nic-hoặc-liên-kết-lên-để-chuyển-đổi-dự-phòng)
- [Tuân thủ Chính sách kết nối vSwitch](#tuân-thủ-chính-sách-kết-nối-vswitch)
- [Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.](#gán-các-nhóm-cổng-cụ-thể-cho-vm-sản-xuất--thử-nghiệm)
- [Loại bỏ vSwitch, nhóm cổng, liên kết lên](#loại-bỏ-vswitch-nhóm-cổng-liên-kết-lên)
- [Thực hành các lệnh](#thực-hành-các-lệnh)

# Tạo Vswitch

Mặc định khi cài đặt ESXi, nó tự tạo ra switch đầu tiên là vSwitch0

<a href="https://imgur.com/x5zoL3l"><img src="https://i.imgur.com/x5zoL3l.png" title="source: imgur.com" /></a>

Để tạo thêm vSwitch ảo chọn: `Add standard virtual switch`
<a href="https://imgur.com/ydNVqar"><img src="https://i.imgur.com/ydNVqar.png" title="source: imgur.com" /></a>

Nhập tên cho vSwitch, các option khác có thể để theo mặc định:

<a href="https://imgur.com/3NDx9YR"><img src="https://i.imgur.com/3NDx9YR.png" title="source: imgur.com" /></a>

Ta có thể tạo nhiều vSwitch trong ESXi:

<a href="https://imgur.com/96OzJwf"><img src="https://i.imgur.com/96OzJwf.png" title="source: imgur.com" /></a>

Một số giới hạn:
<a href="https://imgur.com/ZoVH1Dd"><img src="https://i.imgur.com/ZoVH1Dd.png" title="source: imgur.com" /></a>

Số vSwitch tối đa
<a href="https://imgur.com/vf7knuJ"><img src="https://i.imgur.com/vf7knuJ.png" title="source: imgur.com" /></a>

# Tạo nhóm Cổng VM

<a href="https://imgur.com/WIy9o35"><img src="https://i.imgur.com/WIy9o35.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/rQd3qJc"><img src="https://i.imgur.com/rQd3qJc.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/igFU8jp"><img src="https://i.imgur.com/igFU8jp.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/5YH0uTy"><img src="https://i.imgur.com/5YH0uTy.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/rAvmAjB"><img src="https://i.imgur.com/rAvmAjB.png" title="source: imgur.com" /></a>

# Tạo nhóm Cổng VMkernel

<a href="https://imgur.com/CAFLlTv"><img src="https://i.imgur.com/CAFLlTv.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/uZblAfD"><img src="https://i.imgur.com/uZblAfD.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/IUT4e1i"><img src="https://i.imgur.com/IUT4e1i.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/Qs8rfWn"><img src="https://i.imgur.com/Qs8rfWn.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/hjJ39Ip"><img src="https://i.imgur.com/hjJ39Ip.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/nJI1S9j"><img src="https://i.imgur.com/nJI1S9j.png" title="source: imgur.com" /></a>

# Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng

<a href="https://imgur.com/OtR6pn1"><img src="https://i.imgur.com/OtR6pn1.png" title="source: imgur.com" /></a>


<a href="https://imgur.com/8z1Z1Uu"><img src="https://i.imgur.com/8z1Z1Uu.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/WFOBJSR"><img src="https://i.imgur.com/WFOBJSR.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/9faoDuZ"><img src="https://i.imgur.com/9faoDuZ.png" title="source: imgur.com" /></a>

1:31:27


# Tuân thủ Chính sách kết nối vSwitch

<a href="https://imgur.com/9AhOrNj"><img src="https://i.imgur.com/9AhOrNj.png" title="source: imgur.com" /></a>

<a href="https://imgur.com/hYTm1Va"><img src="https://i.imgur.com/hYTm1Va.png" title="source: imgur.com" /></a>

# Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.


# Loại bỏ vSwitch, nhóm cổng, liên kết lên

# Thực hành các lệnh

<h3>Lấy các card Mạng có sẵn trên máy chủ ESXi </h3>

```
esxcfg-nics -l
``` 

<h3>Hiển thị default gateway</h3>

```
esxcfg-route
```

<h3>Hiển thị các nhóm cổng vmkernel có sẵn trên máy chủ ESXi</h3>

```
esxcfg-vmknic -l
```
<h3>Nhận thông tin về switch ảo có sẵn trên máy chủ ESXi </h3>

```
esxcfg-vswitch -l
```

<h3>Liệt kê các kết nối đã thiết lập trên máy chủ(Netstat)</h3>

```
esxcli network ip connection list
```

<h3>Liệt kê cấu hình địa chỉ IP cho các cổng VMkernel</h3>

```
esxcli network ip interface ipv4 get
```

<h3>Liệt kê các giao diện vmkernel và cấu hình của chúng</h3>

```
esxcli network ip interface list`
```

<h3>Liệt kê thông tin máy chủ hàng xóm hoặc bảng ARP trên máy chủ ESXi</h3>

```
esxcli network ip neighbor list
```

<h3>Liệt kê bảng định tuyến của máy chủ lưu trữ</h3>

```
esxcli network ip route ipv4 list
```

<h3>Xem Cấu hình NIC Vật lý </h3>

```
esxcli network nic
```

<h3>Tắt mạng vmnic</h3>

```
esxcli network nic down-n=vmnic_name
```

<h3>Liệt kê tất cả NICS có trong danh sách nic mạng Esxi host</h3>

```
esxcli network nic list
```

<h3>Kiểm tra các thuộc tính của một số liệu thống kê mạng vmknic</h3>

```
esxcli network nic stats get-n vmnico
```

<h3>Kết nối lại mạng vmnic</h3>

```
esxcli network nic up-navmnic_name
```

<h3>Liệt kê cấu hình vswitch hiện tại</h3>

```
esxcli network vSwitch standard list
```

<h3>Kiểm tra kết nối trên cổng</h3>

```
nc-z dest-ip dest-port
```

<h3>Kiểm tra kết nối với máy chủ ESXi từ xa bằng các tiện ích ping và vmkping</h3>

```
vmkping <IP>
```