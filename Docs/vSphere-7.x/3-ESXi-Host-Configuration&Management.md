<h1> Cấu hình và quản lý host ESXi</h1>

<h2>Summary</h2>

- [Thành phần ESXI](#thành-phần-esxi)
- [Tệp nhật ký ESXi](#tệp-nhật-ký-esxi)
- [Lab](#lab)

---
<h3> Nội dung chính</h3>

- Thành phần host ESXI & tệp log
- Giao diện quản lý host ESXi
- Cấu hình và quản lý host ESXI
- ESXi Host - Lab
- vSphere Documentation

# Thành phần ESXI

- Kiến trúc ESXi bao gồm hệ điều hành cơ bản, được gọi là VMkernel và các quy trình chạy trên nó
- VMkernel cung cấp một phương tiện để chạy tất cả các quy trình trên hệ thống, bao gồm các ứng dụng quản lý và tác nhân cũng như các máy ảo
- Nó có quyền kiểm soát tất cả các thiết bị phần cứng trên máy chủ và quản lý tài nguyên cho các ứng dụng

- Các quy trình chính chạy trên VMkernel là
  - Giao diện người dùng bảng điều khiển trực tiếp (Direct Console User Interface - DCUI)
  - Màn hình máy ảo (Virtual Machine Monitor - VMM)
  - Agents VMware (hostd, vpxa)
  - Hệ thống Mô hình Thông tin Chung (Common Information Model (CIM) System - CIM)

- Giao diện người dùng bảng điều khiển trực tiếp (DCUI)
  - Giao diện quản lý và cấu hình mức thấp, có thể truy cập thông qua giao diện điều khiển của máy chủ, được sử dụng chủ yếu cho cấu hình cơ bản ban đầu
- Màn hình máy ảo (VMM)
  - Quy trình cung cấp môi trường thực thi cho máy ảo, cũng như quy trình trợ giúp được gọi là VMX. Mỗi máy ảo đang chạy có quy trình VMM và VMX riêng
- Đại lý VMware (hostd và vpxa)
  - Được sử dụng để cho phép quản lý Cơ sở hạ tầng VMware cấp cao từ các ứng dụng từ xa
- Hệ thống Mô hình Thông tin Chung (CMM)
  - Giao diện cho phép quản lý cấp phần cứng từ các ứng dụng từ xa thông qua một tập hợp các API tiêu chuẩn

- VMkernel
  - Hệ điều hành giống như Giao diện Hệ điều hành Di động (POSIX) được phát triển bởi VMware, cung cấp một số chức năng tương tự như trong các hệ điều hành khác, chẳng hạn như tạo và kiểm soát quy trình, tín hiệu, hệ thống tệp và quy trình xử lý.

  - Được thiết kế đặc biệt để hỗ trợ chạy nhiều máy ảo và cung cấp chức năng cốt lõi như
    - Lập kế hoạch tài nguyên
    - Ngăn xếp I / O
    - Trình điều khiển thiết bị

- Hệ thống tập tin
  - VMkernel sử dụng một hệ thống tệp trong bộ nhớ đơn giản để chứa các tệp cấu hình Máy chủ ESXi, tệp nhật ký và các bản vá theo giai đoạn
  - Hệ thống tệp này độc lập với hệ thống tệp Vmware vSphere VMFS được sử dụng để lưu trữ các máy ảo
  - ESXi có thể định cấu hình máy chủ nhật ký hệ thống từ xa và máy chủ kết xuất từ ​​xa, cho phép bạn lưu tất cả thông tin nhật ký trên hệ thống bên ngoài

# Tệp nhật ký ESXi

|S.No|Tên Log|Mô tả|
|:---:|---|---|
1 | /var/log/auth.log | ESXi Shell xác thực thành công và thất bại
2 | /var/log/esxupdate.log | Bản vá lỗi ESXi và cập nhật nhật ký cài đặt
3 | /var/log/hostd.log | Nhật ký dịch vụ quản lý máy chủ lưu trữ, bao gồm máy ảo và máy chủ lưu trữ Tác vụ và sự kiện, giao tiếp với tác nhân vpxa vSphere Client và vCenter Server cũng như các kết nối SDK
4 | /var/log/syslog.log | Khởi tạo dịch vụ quản lý, cơ quan giám sát, tác vụ đã lên lịch và sử dụng DCUI
5 | /var/log/vmkernel.log | Core VMkernel nhật ký, bao gồm các sự kiện trình điều khiển và thiết bị phát hiện, lưu trữ và mạng, cũng như khởi động máy ảo
6 | /var/log/vmkwarning.log | Bản tóm tắt thông báo Nhật ký Cảnh báo và Cảnh báo được trích từ nhật ký VMkernel
7 | /var/log/vmksummary.log | Tóm tắt về khởi động và tắt máy chủ ESXi, nhịp tim hàng giờ với thời gian hoạt động, số lượng máy ảo đang chạy và mức tiêu thụ tài nguyên dịch vụ
8 | /var/log/vpxa.log | vCenter Máy chủ vpxa nhật ký tác nhân, bao gồm giao tiếp với vCenter Server và đại lý hostd quản lý máy chủ
9 | /var/log/fdm.log | vSphere Lô sẵn sàng cao, được sản xuất bởi dịch vụ FDM

# Lab
- ESXi host Management Interfaces
- ESXi Host Post-Implementation Steps
- ESXi host Navigation

VMware vSphere Documentation
https://docs.vmware.com/en/VMware-vSphere/index.htm