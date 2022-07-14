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
# Tạo nhóm Cổng VMkernel
# Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng
# Tuân thủ Chính sách kết nối vSwitch
# Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.
# Loại bỏ vSwitch, nhóm cổng, liên kết lên

# Thực hành các lệnh

<h3>Để lấy các card Mạng có sẵn trên máy chủ ESXi </h3>

```
esxcfg-nics -l
``` 

<h3>Để chỉ hiển thị default gateway</h3>
```
esxcfg-route
```

<h3>Để tải các nhóm cổng vmkernel có sẵn trên máy chủ ESXi</h3>
```
esxcfg-vmknic -l
```
<h3>Để nhận thông tin về công tắc ảo có sẵn trên máy chủ ESXi </h3>
```
esxcfg-vswitch -l
```

<h3>Số tùy chọn có sẵn cho cài đặt mạng esxcli</h3>
```
esxcli network
```
Để liệt kê các kết nối đã thiết lập trên máy chủ của chúng tôi (Netstat) | `esxcli network ip connection list`
Để liệt kê cấu hình địa chỉ IP cho các cổng VMkernel | `esxcli network ip interface ipv4 get`
Để liệt kê các giao diện vmkernel và cấu hình của chúng | `esxcli network ip interface list`
Để liệt kê thông tin máy chủ hàng xóm hoặc bảng ARP trên máy chủ ESXi | `esxcli network ip neighbor list`
Để liệt kê bảng định tuyến của máy chủ lưu trữ | `esxcli network ip route ipv4 list`
Để xem Cấu hình NIC Vật lý | `esxcli network nic`
Tắt mạng vmnic | `esxcli network nic down-n=vmnic_name`
Để liệt kê tất cả NICS có trong danh sách nic mạng Esxi host | `esxcli network nic list`
Để kiểm tra các thuộc tính của một số liệu thống kê mạng vmknic | `esxcli network nic stats get-n vmnico`
Để kết nối lại mạng vmnic | `esxcli network nic up-navmnic_name`
Để liệt kê cấu hình vswitch hiện tại | `esxcli network vSwitch standard list`
Để kiểm tra kết nối trên cổng | `nc-z dest-ip dest-port`
Kiểm tra kết nối với máy chủ ESXi từ xa bằng các tiện ích ping và vmkping | `vmkping <IP>`