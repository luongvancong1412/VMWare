Các loại ảo hoá, đặc điểm, 5 chức năng, 4 mô hình triển khai, 5 tính năng
public cloud, private cloud
- Đọc kvm trước
============================================================================
Buổi 3

- Tổng quan về ảo hoá, lý do sử dụng ảo hoá máy chủ vmware
- Nguyên tắc cơ bản về máy chủ

Hôm nay:
# Nội dung bài chính:
- Architectural Differences
- Virtual Machine Concepts
- Benefits of Using Virtual Machine(s)
- Cteating a Virtual Machine(VM)
- Install a Guest OS in a VM
- Install VMware Tools on a VM

- Tạo thêm một máy ảo bổ xung, sẽ cài red hat linux và máy chủ esxi
- Định cấu hình thư mục hoạt động trên máy chủ windows 2022
- Tạo 1 người dùng và gán quyền quản trị miền


# Architectural Differences
- có 3 kiến trúc:
+ Kiến trúc vật ly - traditional or Physical architecture
+ Kiến trúc dựa trên máy chủ  - host based architecture
+ Kiến trúc kim loại trần - bare-metal architecture


## Kiến trúc vật lý
- Vì vậy trong kiến trúc traditional nếu bạn nhìn thấy sơ đồ, mọi kiến trúc phần cứng chúng tôi gọi gọi nó là x64 architecture
x có nghĩa là nó bất kỳ 64 bất kỳ 
- 64 architecture và nó bao gồm các thành phần phần cứng chính là bộ nhơ cpu của bộ xử lý và chúng ta có một card mạng NIC, một bộ nhớ lưu trữ(ssd, flash drive),
- Trên phần cứng x64 Architectural, chúng ta đang cài đặt hệ điều hành, trên hệ điều hành là Application (ms office, adobe,.. và bất kỳ ứng dụng bên thứ 3 nào khác)

## Kiến trúc dựa trên máy chủ
- Phần cứng là kiến trúc x64 phổ biến
- Trên phần cứng đang cài hệ điều hành
- Sau HĐH là một phần của aplication, chúng ta đang cài đặt 1 trong các phần mềm dựa trên máy chủ ảo hoá, tên phần mềm là máy trạm vmware

- Máy trạm vmware là một phần mềm ảo hoá cho phép bạn tạo nhiều máy ảo cho mục đích thử nghiệm, trong hình có 3 máy ảo vm1,vm2.vm3
- Máy ảo trông giống như 1 máy tính vật lý và chúng tôi cho phép cài dặt hệ điều hành kháchvaf ứng dụng giống như một máy chủ vật lý
- Máy ảo cũng có các thành phần ảo, đây được coi là nhu cầu ảo vcpu , v-memory,vdisk  và tương tự áp dụng cho các máy ảo cũng không chỉ 3 vms, dựa trên tài nguyên phần cứng, ta có thể tạo ra nhiều máy ảo trên 1 máy trạm vmware
- Kiến trúc dựa trên máy chủ chỉ đouwjc sử dụng cho các mục đích thử ghiệm, nó không phải cho mục đích sản xuất cua bạn.

## Kiến trúc kim loại trần
- Sự khác biệt ở đây là ta sẽ không cài hệ điều hành mà sẽ cài phầm mềm ESXi trực tiếp trên phần cứng khôgn có gì khácf ngoài kiến trúc kim loại trần
- Trong kiến trúc này esxi trực tiếp chạy phần cứng trên máy chủ esxi mà nó cho phép bạn tạo nhiều máy ảo, vì vậy để thử nghiệm tôi tạo sơ đồ này cho thấy 3 vms vm1 vm2 vm3.
Vì vậy đây là sự khác biệt giữa các kiến trúc trên máy chủ truyền thống và kim loại trần, vì vậy hầu hết môi trường sản xuất chúng tôi khuyên bạn nên sử dụng kim loại trần.



# Virtual Machine Concepts - Các khái niệm về máy ảo

- A virtual machine is a software computer that, like a physical computer, rún an operating system and applications.
- máy ảo là 1 máy tính phần mềm, giống như một máy tính vật lý, chạy hệ điều hành và các ứng dụng

## Virtual Machine Components - Các thành phần của máy ảo
- Operating system
- VMware Tools: mục đích chính là sau khi cài đặt, nó sẽ cung cấp tất cả các trình điều khiển thiết bị máy ảo bất kể các thành phần chúng tôi có trong máy ảo tất cả các trình điều khiển phần cứng sẽ được cung cấp bởi vmware
các công cụ và tài nguyên ảo chăng hạn như: bộ điều hợp mạng, cpu và bộ điều hợp bộ điều khiên đĩa các cổng song song
và nối tiếp
- Virtual resources such as:
+ CPU and memory
+ Network adapters
+ Disk controllers
+Parallel and serial ports

# About Virtual Machine Files
- A virtual machine includes a set of related files.
- Tôi đặt các tệp máy ảo bình thưuofng, bất cứ khi nào chúng tôi tạo máy ảo trong trong máy trạm vmware hoặc máy chủ thành công ở bất kỳ nơi nào bạn tạo máy ảo
, mặc định máy ảo được tạo trong một thư mục của máy ảo sau khi tạo máy ảo,
nó bao gồm chứa tất cả các tập hợp tệp này

- Tầm quan trọng của các tệp này: Giả sử nếu tên tệp thông tin của bạn là VM_name.vmax thì không có gì khác ngoài tệp cấu hình.
Tệp cấu hình bao gồm tất cả các chi tiết cấu hình máy ảo, có nghĩa là nếu máy ảo mà chúng tôi đã tạo với 2 cpu 4gb RAM và 40GB đĩa cứng thì tât cả đĩa thông tin cpu này
được lưu trữ trong tệp vmx và khi nó nói đến tệp hoán đỏi vswp là phím tắt cho tệp hoán đổi và tệp wav này cũng nó sẽ tạo khi chúng ta tạo máy ảo ổn và tệp thiên vị chúng ta cũng vậy, nó thường là một hệ thống đầu ra đầu vào cư bản bình thouowfng chúng ta có thể thấy bios trong máy tính xách tay của mình và máy chủ theo cách tưogn tụ như vậy ảo bios cũng có sẵn trong máy ảo, phần mở rộng tệp bios là nvram
ram không bay hơi và tệp nhật ký máy ảo nso sẽ tôi tạo nó trong tệp vmware.log, nó bao gồm bất kỳ thay đổi noà bạn đã thực hiện trên máy ảo,tất cả các thay đổi được lưu trữ trong tệp vmware.log và chúng tôi cũng có tệp cấu hình mẫu VM_ là chung cho mọi vm,
giả sử tên vm của chúng ta là vm1.
+ VM_vm1.vmtx là tệp cấu hình mẫu, mẫu là một trong những khái niệm quan trọng trong vmware vsphere, tôi sẽ giải thích trong các lớp sau nhé và
+tệp mỗ tả đĩa VM_name.vmdk có nghĩa là tệp đĩa đĩa máy ảo thông thường đây là tệp bộ mô tả
+ Dữ liệu thực tế đc luu trữ trên VM_name-flat.vmdk bao gồm thông tin dữ liệu thực tế
+ Raw device map file - chúng ta có thể sử dụng khi chúng ta muốn thêm bất kỳ kích thước lớn nào của tệp đĩa chia sẻ vào máy ảo, kịch bản đó sẽ tạo ra một chấm rdm rdm vmdk có nghĩa là ánh xạ thiét bị thô và các
đĩa snapshot chúng ta cũn có trong snapshot máy ảo, có nghĩa là trạng thái  pre-reservo của vm nếu bạn tạo bất kỳ snapshot máy ảo sẽ tạo mặc định bây giờ tất cả các tệp liên quan đến snapshot tệp đĩa snapdragonthoe mặc định tên vm_delta có ngãi là giá gị tậm thời 001 dot vmdk
nếu tạo một ảnh chụp nhanh thứ 2 nó sẽ tạo tên vm_002.vmdk
+ 001 002 được gọi là giá trị delta
+Snapshot data file là VM_name.vmsd nghĩa là chúng ta có bao nhiêu ảnh chụp nhanh mà thông tin đó được duy trì bởi tệp vmst và tệp trạng thái ảnh chụp nhanh mà phần
...

# Physical Resource Sharing - Chia sẻ tài nguyên vật lý
- Ở bất cứ nơi nào bạn tạo VM hoặc bạn có thể tạo trên máy trạm vmware hoặc
bạn có thể tạo trên máy chủ ESXi
- Ở bất cứ đâu bạn luôn tạo ra cách đĩa bộ nhớ CPU máy nảo ns sắp tới là tất cả điều này hoàn toàn được chia sẻ từ vật lý Hệ thống call
- Giả sử ở đây như bạn thấy trong sơ đồ này tàn nguyên vật lý là  cpu Memory, network card, storage... Tất cả các tài nguyên vật lý này bất kể kích thước bạn có, kích thước khả dụng chỉ chúng tôi có thể hiển thị là chia sẻ nó
với các máy ảo, giả sử hệ thống vật lý của tôi có 20 cups và bộ nhớ cũng 20gb và chúng tôi có nhu cầu vật lý và chúng tôi có kích thước đĩa là 100gb, đây là tài nguyên 
có sẵn nếu bạn muốn tạo máy ảo của mình dựa trên tài nguyên vật lý của bạn 
tôi chỉ có 20cm nghĩa là mỗi máy ảo của tôi tôi định cung cấp 2 cpu có nghĩa là tối đa chúng tôi có thể tạo tối đa 10 vms và bộ nhớ cũng như nhau, chúgn tôi có thể phân phối cho tất cẩ vms và tương tự với đĩa.
Cũng như vậy, chúng tôi có thể phân phối cho máy ao nếu bạn không có đủ bộ nhớ
cpu có nghĩa là chúng tôi phải sủ dụng một hộp vật lý khác để tạo 1 vms bổ sung, như vậy chúng tôi có thể tăng các hộp esxi.
Hãy nhớ rằng bất kể tài nguyên có sẵn trong máy tính vật lý, tất cả các tài nguyên này sẽ được chia sẽ cho các...

# Benefits of Using Virtual Machine

## Physical Machine
- Difficult to relocate:
+ Moves require downtime.
+ Specific to physical hardware.
- Difficult to manage:
+ Require physical maintenance.
+ Hardware failures cause downtime.
- Hardware has limitations:
+ Hardware changes limit applicaiton support.
+ One-to-one relationship between application and server.
## Virtual Machine
- Easy to relocate:
+ Encapsulated into files
+ Independent of physical hardware
- Easy to manage:
+ Isolated from other virtual machines
+ Isulated from hardware changes.

Provide the ability to support logacy applications.
Enable servers to be consolidated

# Lợi ích của việc sử dụng Máy ảo

## Máy vật lý
- Khó di dời:
+ Các chuyển động yêu cầu thời gian chết. (Khi muốn di chuyển trung tâm dữ liệu từ nơi này sang nơi khác nếu là máy chủ vật lý phải thựcc hineej ngừng hoạt động cho máy chủ đó và có kế hoạch di chuyển máy chủ từ vị trí trì hoãn sang vị trí hoạt động, điều đó có nghĩa là rất khó để di đời  )
+ Đặc trưng cho phần cứng vật lý. 
- Khó quản lý:
+ Yêu cầu bảo dưỡng vật lý.
+ Lỗi phần cứng gây ra thời gian chết máy.
- Phần cứng có những hạn chế:
+ Thay đổi phần cứng hạn chế hỗ trợ ứng dụng.
+ Mối quan hệ một-một giữa ứng dụng và máy chủ.
## Máy ảo
- Dễ dàng di chuyển:
+ Đóng gói thành tệp (máy ảo có nghĩa nó trông giống như một phần mềm, nó trông giống như một máy chủ vật lý nhưng nó là một phần mềm được tạo ra bởi một lưới, nó bao gồm danh sách các tệp bạn chỉ cần sao chép tất cả vi tập tin bị lật và bạn có thể di chuyển tới bất cứ nơi nào bạn muốn, bạn có thể dễ dang di chuyển)
+ Độc lập với phần cứng vật lý
- Dễ dàng quản lý:
+ Cách ly với các máy ảo khác
+ Cách ly với những thay đổi phần cứng.
Cung cấp khả năng hỗ trợ các ứng dụng logacy.
Cho phép các máy chủ được hợp nhất

----------------
Và cũng như việc chỉnh sửa dành riêng cho phần cứng vật lý bị rằng buộc với bất kỳ tích hợp nào với các máy chủ khác hoặc các thiết bị tích hợp khác nên điều đó cũng khó để di dời nhưng trong kịch bản máy ảo
nó khá đơn giản, bạn chỉ có thể di chuyển máy ảo từ vị trí này sang vị trí khác.

- Khó quản lý: Nếu bạn muốn duy trì vị trí của máy chủ vật lý nếu bạn muốn thực hiện bất kỳ sửa đổi nào trên đĩa nhớ cpu máy chủ vật lý hoặc NIC
chúng tôi yêu cầu thời gian chết, chúng tôi phải tắt máy chủ vật lý và tăng bộ nhớ và tăng đĩa và tăng bất kỳ thiết bị ngoại vi phần cứng nào bạn 
muốn thay đổi nhưng khi nói đến kịch bản máy ảo, chúng tôi không cần dành thời gian cho máy ảo thay đổi phần cứng ở đây thay đổi phần cứng có nghĩa là là phần cứng ảo thay đổi, khi vm bật nguồn, chúng tôi có một tính năng từ vmware, tính năng được gọi là Hot add feature
 
Host add có nghĩa là nó cho phép bạn thêm đĩa nhớ, cpu và nsa trong khi máy ảo bật nguồn, chúng tôi không cần tắt nguồn vm
mà chúng tôi chỉ trong khi vm đang lên và chạy, bạn có thể chỉ cần nhấp chuột phải vào cài đặt chỉnh sửa vm và bạn có thể tăng đĩa nhớ cpu bất kỳ thành phần phần cứng nào bạn muốn thêm vào đều được

Nhược điểm: Hạn chế về khả năng tương thích ví dụ phần cứng của model như thế hệ thứ 9 hỗ trợ lên đến esxi 6.5 OS chỉ khi bản muốn sử dung esx 6.7 hoặc esxi 7.0 