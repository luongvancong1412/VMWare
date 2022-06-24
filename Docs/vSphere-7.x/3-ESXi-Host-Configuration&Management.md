<h1> Cấu hình và quản lý host ESXi</h1>

<h2>Summary</h2>

- [1. Thành phần ESXI](#1-thành-phần-esxi)
- [Tệp nhật ký ESXi](#tệp-nhật-ký-esxi)
- [Cách quản lý ESXi](#cách-quản-lý-esxi)
- [Lab](#lab)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)

---
<h3> Nội dung chính</h3>

- Thành phần host ESXI & tệp log
- Giao diện quản lý host ESXi
- Cấu hình và quản lý host ESXI
- ESXi Host - Lab
- vSphere Documentation

# 1. Thành phần ESXI

- **Kiến trúc ESXi** bao gồm hệ điều hành cơ bản, được gọi là VMkernel và các quy trình chạy trên nó
- VMkernel ,cũng **giống như hệ điều hành bình thường**, cung cấp một phương tiện để chạy tất cả các quy trình trên hệ thống, bao gồm các ứng dụng quản lý và Agent ESXi cụ thể cũng như các máy ảo
- Nó có quyền kiểm soát tất cả các thiết bị phần cứng trên server và quản lý tài nguyên cho các ứng dụng

- Các quy trình chính chạy trên VMkernel là
  - Giao diện người dùng bảng điều khiển trực tiếp (Direct Console User Interface - DCUI)
  - Màn hình máy ảo (Virtual Machine Monitor - VMM)
  - Agents VMware (hostd, vpxa)
  - Hệ thống Mô hình Thông tin Chung (Common Information Model (CIM) System - CIM)

<h3>Giao diện người dùng bảng điều khiển trực tiếp (DCUI)</h3>

- Giao diện quản lý và cấu hình mức thấp, có thể truy cập thông qua giao diện điều khiển của máy chủ, được sử dụng chủ yếu cho cấu hình cơ bản ban đầu

!![Imgur](https://i.imgur.com/Tfqj6dS.png)

- DCUI hiển thị những thông tin cơ bản:
  - Thông tin ESXi 7.0.3, Công ty VMware
  - Số lượng CPU, Memory gán cho máy chủ này

Để tuỳ chỉnh và xem nhật ký hệ thống nhấn F2:
- Nhập mật khẩu bảo mật:
![Imgur](https://i.imgur.com/K4JZpCG.png)
- Các tính năng chính:
![Imgur](https://i.imgur.com/7u39A07.png)

<h4> Configure Password</h4>

- Thay đổi mật khẩu bảo user root
![Imgur](https://i.imgur.com/09H8z7F.png)
<h4> Configure management Network</h4>

- Cấu hình quản lý mạng:
![Imgur](https://i.imgur.com/A7BUbnj.png)

- Xem card mạng: Network Adapters
![Imgur](https://i.imgur.com/ULnJOVs.png)

- VLAN:
![Imgur](https://i.imgur.com/jC0RBYo.png)
- IPv4 Configuration: Có 3 tuỳ chọn:
  - Tắt IPv4
  - Cấu hình IPv4 động nếu có DHCP server
  - Cấu hình tĩnh
  - Trong hình đang sử dụng cấu hình IP tĩnh
![Imgur](https://i.imgur.com/xgVrDPf.png)

- IPv6 Configuration
- DNS Configuration
![Imgur](https://i.imgur.com/B6X9pzc.png)
- Custom DNS Suffixes
![Imgur](https://i.imgur.com/98B8Tvz.png)
<h4> Restart Management Network</h4>

- Khởi động lại Managemet Network, sẽ dẫn đến mất mạng trong thời gian ngắn, ngắt kết nối đến phần mềm quản lý từ xa và việc chạy các máy ảo
- Nhấn F11 để khởi động lại
![Imgur](https://i.imgur.com/t1fvSU5.png)
<h4> Test Management Network</h4>

- Kiểm tra mạng bằng cách thực hiện ping tới các địa chỉ được setting:
![Imgur](https://i.imgur.com/lodoTnC.png)

<h4> Network Restore Option</h4>

- Sử dụng nếu host ESXi bị treo hoặc bi khởi động lại đột ngột hoặc có một cấu hình sai
<h4> Configure Keyboard </h4>

- Sử dụng để thay đổi ngôn ngữ bàn phím

![Imgur](https://i.imgur.com/DODZHgV.png)

<h4> Troubleshooting Options</h4>

- Option Khắc phục sự cố như:
  - Enable truy cập shell
  - Enable SSH
  - Cấu hình thời gian chờ (Khi không tác động trong 1 khoảng thời gian phiên DCUI sẽ bị khoá)
  - Khởi động lại Management Agent
    - Cách khác: có thể sử dụng lệnh khi đã bật shell
    ```
    /etc/init.d/hostd restart
    ```
![Imgur](https://i.imgur.com/kua0DFw.png)


<h4> View System Logs</h4>

- Xem nhật ký hệ thống

![Imgur](https://i.imgur.com/MXX4VZk.png)

<h4> View Support Information</h4>

- Xem thông tin đầy dủ của system (Serial number, License,...)
![Imgur](https://i.imgur.com/IF2ZmpG.png)

<h4> Reset System Configuration </h4>

- Khôi phục lại cài đặt ban đầu

<h3>Tắt và khởi động lại nhấn F12</h3>

- Shut down: F2
- Restart: F11
![Imgur](https://i.imgur.com/mMuBgLw.png)


- Màn hình máy ảo (VMM)- Chưa hiểu
  - Quy trình cung cấp môi trường thực thi cho máy ảo, cũng như quy trình trợ giúp được gọi là VMX. Mỗi máy ảo đang chạy có quy trình VMM và VMX riêng
- Đại lý VMware (hostd và vpxa) - Chưa hiểu
  - Được sử dụng để cho phép quản lý Cơ sở hạ tầng VMware cấp cao từ các ứng dụng từ xa
- Hệ thống Mô hình Thông tin Chung (CMM)
  - Giao diện cho phép quản lý cấp phần cứng từ các ứng dụng từ xa thông qua một tập hợp các API tiêu chuẩn

- **VMkernel**
  - Hệ điều hành giống như Giao diện Hệ điều hành Di động ( Portable Operating System Interface - POSIX) được phát triển bởi VMware, cung cấp một số chức năng tương tự như trong các hệ điều hành khác, chẳng hạn như tạo và kiểm soát quy trình, signals, hệ thống tệp và quy trình xử lý.

  - Được thiết kế đặc biệt để hỗ trợ chạy nhiều máy ảo và cung cấp chức năng **core** như:
    - Resource scheduling - Lâp lịch tài nguyên (CPU, Memory, Disk,...)
    - I/O stacks - Ngăn xếp đầu ra đầu vào
    - Device drivers - Trình điều khiển thiết bị (Các công cụ máy ảo)

- **Hệ thống tập tin**
  - VMkernel sử dụng một hệ thống tệp trong bộ nhớ đơn giản để chứa các tệp cấu hình Máy chủ ESXi, tệp nhật ký và các bản vá theo giai đoạn (có nghĩa là các bản vá đã được áp dụng)
  - Hệ thống tệp này độc lập với hệ thống tệp Vmware vSphere VMFS được sử dụng để lưu trữ các máy ảo
  - ESXi có thể định cấu hình máy chủ nhật ký hệ thống từ xa và máy chủ kết xuất từ ​​xa, cho phép bạn lưu tất cả thông tin nhật ký trên hệ thống bên ngoài (Ví dụ trên ESXi có thể lưu trữ dữ liệu của 1 tháng sau đó đẩy ra lưu trữ bên ngoài)

# Tệp nhật ký ESXi

|S.No|Tên Log|Mô tả|
|:---:|---|---|
1 | /var/log/auth.log | Thông tin ESXi Shell xác thực thành công và thất bại<br>Ví dụ nếu sử dung ID root đăng nhập không thành công nó sẽ lưu trữ trong auth.log
2 | /var/log/esxupdate.log | Thông tin Bản vá lỗi ESXi và cập nhật nhật ký cài đặt
3 | /var/log/hostd.log | Nhật ký dịch vụ quản lý máy chủ lưu trữ, bao gồm máy ảo và máy chủ lưu trữ Tác vụ và sự kiện, giao tiếp với tác nhân vpxa vSphere Client và vCenter Server cũng như các kết nối SDK<br>Hầu hết khắc phục sự cố sử dụng file này.
4 | /var/log/syslog.log | Khởi tạo dịch vụ quản lý, cơ quan giám sát, tác vụ đã lên lịch và sử dụng DCUI
5 | /var/log/vmkernel.log | Core VMkernel nhật ký, bao gồm các sự kiện trình điều khiển và thiết bị phát hiện, lưu trữ và mạng, cũng như khởi động máy ảo
6 | /var/log/vmkwarning.log | Bản tóm tắt thông báo Nhật ký Cảnh báo và Cảnh báo được trích từ nhật ký VMkernel
7 | /var/log/vmksummary.log | Tóm tắt về khởi động và tắt máy chủ ESXi, heartbeat hàng giờ với thời gian hoạt động, số lượng máy ảo đang chạy và mức tiêu thụ tài nguyên dịch vụ
8 | /var/log/vpxa.log | vCenter Máy chủ vpxa nhật ký Agent, bao gồm giao tiếp với vCenter Server và đại lý hostd quản lý máy chủ
9 | /var/log/fdm.log | vSphere Log sẵn sàng cao, được sản xuất bởi dịch vụ FDM

# Cách quản lý ESXi
Có 2 cách:
- Sử dụng giao diện đồ hoạ:
  - VMware host Client
  - vSphere Client (Chưa rõ)
- Sử dụng dòng lệnh:
  - ESX Cli thông qua ssh
  - VMware Power CLi (Là một công cụ co ssawn từ trang web vmware)

![Imgur](https://i.imgur.com/suCXC7d.png)

# Lab
- ESXi host Management Interfaces
- ESXi Host Post-Implementation Steps
- ESXi host Navigation
> Lab: [Cầu hình và quản trị host ESXi](../../Lab/3-Config&Management-host-ESXi.md)


# Tài liệu tham khảo
VMware vSphere Documentation
https://docs.vmware.com/en/VMware-vSphere/index.htm