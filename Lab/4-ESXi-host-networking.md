<h1>Virtual switch </h1>


<h2>Summary</h2>

- [Tạo Vswitch](#tạo-vswitch)
- [Tạo nhóm Cổng VM](#tạo-nhóm-cổng-vm)
- [Tạo nhóm Cổng VMkernel](#tạo-nhóm-cổng-vmkernel)
- [Thêm NIC hoặc Liên kết lên để chuyển đổi dự phòng](#thêm-nic-hoặc-liên-kết-lên-để-chuyển-đổi-dự-phòng)
- [Tuân thủ Chính sách kết nối vSwitch](#tuân-thủ-chính-sách-kết-nối-vswitch)
- [Gán các nhóm Cổng cụ thể cho VM Sản xuất & Thử nghiệm.](#gán-các-nhóm-cổng-cụ-thể-cho-vm-sản-xuất--thử-nghiệm)
- [Loại bỏ vSwitch, nhóm cổng, liên kết lên](#loại-bỏ-vswitch-nhóm-cổng-liên-kết-lên)

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