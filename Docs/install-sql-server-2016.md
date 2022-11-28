<h1> Cài đặt SQL Server 2016, SSMS và công cụ SSDT</h1>

<h2> Nội dung </h2>

- [1. Chuẩn bị](#1-chuẩn-bị)
- [2. Các bước cài đặt](#2-các-bước-cài-đặt)
- [3. Cài đặt SSMS](#3-cài-đặt-ssms)
- [4. Cài đặt SSDT](#4-cài-đặt-ssdt)
- [Tài liệu tham khảo](#tài-liệu-tham-khảo)




<h3>Các phiên bản của SQL server:</h3>

- SQL Server: đây là phiên bản chính thức dành cho đối tượng doanh nghiệp và bạn có thể sử dụng thử miễn phí không cần xác minh thẻ tín dụng trong vòng 180 ngày.
- SQL Server Express: phiên bản này dành cho các doanh nghiệp nhỏ muốn phát triển và bán các sản phẩm sử dụng phần mềm SQL Server. Tuy nhiên, các tính năng của SQL Server sẽ bị giới hạn khá nhiều như: 10GB bộ nhớ lưu trữ, SQL Server Agent và DTA cũng nhiều chức năng khác sẽ bị cắt bỏ.
- SQL Server Developer edition: đây là phiên bản dành cho các cá nhân, các lập trình viên muốn học cách sử dụng SQL Server. Bạn có thể phát triển ứng dụng hoàn toàn miễn phí, phần mềm SQL Server đầy đủ tính năng. Nhưng bạn không thể phát hành sản phẩm của mình dưới dạng thương mại.

<h3>Vì sao nên chọn SQL Server 2016 SP2 Express?</h3>

- Đối với các doanh nghiệp vừa và nhỏ, tiết kiệm chi phí sẽ luôn là ưu tiên hàng đầu để doanh nghiệp có thể xoay vòng vốn và sử dụng vào những chi phí không thể cắt giảm. Vì thế, sử dụng phiên bản SQL Server Express sẽ là một lựa chọn tối ưu nhất.

- Hầu hết những tính năng cắt bỏ là những tính năng mở rộng, nâng cao đa phần các doanh nghiệp nhỏ ít sử dụng. Với khối lượng lưu trữ dữ liệu lên đến 10GB là một con số rất lớn (đối với dạng lưu trữ văn bản, không phải âm thanh hay video).

- Và phiên bản SQL Server 2016 SP2 Express là phiên bản được nâng cấp rất nhiều so với phiên bản SQL Server 2016 Express tiền nhiệm cùng năm.

- SQL Server 2016 SP2 Express ổn định hơn, có mức độ tin cậy cao hơn, phù hợp với nhiều dòng thiết bị hơn.

- Vì thế, SQL Server 2016 SP2 Express sẽ là một lựa chọn phù hợp cho các doanh nghiệp nếu muốn phát triển sản phẩm thương mại trên một phần mềm bản quyền hoàn toàn miễn phí!
# 1. Chuẩn bị

- Tải về SQL Server 2016:
https://www.microsoft.com/en-in/evalcenter/evaluate-sql-server-2016

- Một số công cụ khác:
  - SSMS (SQL Server Management Studio): là môi trường tích hợp cho quản lý toàn bộ hạ tầng SQL, từ cơ sở dữ liệu SQL Server đến cơ sở dữ liệu Aruze SQL. SSMS cung cấp các công cụ để định cấu hình, giám sát và quản trị các phiên bản của SQL Server và cơ sở dữ liệu (Xem thêm)
    - Xem thêm: https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
  - SSDT (SQL Server Data Tools): một công cụ phát triển hiện đại để xây dựng cơ sở dữ liệu quan hệ SQL Server, cơ sở dữ liệu Azure SQL, mô hình các dịch vụ phân tích dữ liệu (AS), các gói dịch vụ tích hợp (IS) và các Dịch vụ cho report (RS)
    - Xem thêm: https://learn.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-2017

- Bản SQL Server 2016 có key:
https://drive.google.com/file/d/1ExA34IiTZZ2IesvIlrJi6wJt0XfKuUmy/view
- Bản SSMS:
https://drive.google.com/file/d/1N3aWVuEuvvOPBfs_py40r-VbttBAoYCH/view

# 2. Các bước cài đặt

<a href="https://imgur.com/UdkMqnn"><img src="https://i.imgur.com/UdkMqnn.png" title="source: imgur.com" /></a>

- Bước 1: Chọn chuột phải file **setup** > **Run as administrator**

<a href="https://imgur.com/VQ6FU1K"><img src="https://i.imgur.com/VQ6FU1K.png" title="source: imgur.com" /></a>

- Bước 2: Sau một vài giây, màn hình sẽ xuất hiện như hình bên dưới, kiểm tra yêu cầu phần cứng và phần mềm bằng cách tích vào **Hardware and Software Requirements** và nếu kiểm tra OK thì kích vào tab **Installation**.

<a href="https://imgur.com/PgUdfoG"><img src="https://i.imgur.com/PgUdfoG.png" title="source: imgur.com" /></a>

- Bước 3: Chọn **New SQL Server stand-alone installation or add the feature to an existing installation**

<a href="https://imgur.com/aPDmi1r"><img src="https://i.imgur.com/aPDmi1r.png" title="source: imgur.com" /></a>

- Bước 4: Nếu bạn đã có Product ID thì nhập ở dòng dưới hoặc chọn free edition (như bản của mình sẽ tự động điền key) sau đó ấn nút Next

<a href="https://imgur.com/vcTOZEn"><img src="https://i.imgur.com/vcTOZEn.png" title="source: imgur.com" /></a>

- Bước 5: Tích vào ô I accept the license terms và kích Next.

<a href="https://imgur.com/Y8BkEDc"><img src="https://i.imgur.com/Y8BkEDc.png" title="source: imgur.com" /></a>

- Bước 6: bước Global Rules sẽ kiểm tra tổng thể để phát hiện những vấn đề có thể xảy ra khi cài đặt.

<a href="https://imgur.com/8Brhjy8"><img src="https://i.imgur.com/8Brhjy8.png" title="source: imgur.com" /></a>

- Bước 7: Kiểm tra Microsoft Update và kích Next.

<a href="https://imgur.com/n3vTIl6"><img src="https://i.imgur.com/n3vTIl6.png" title="source: imgur.com" /></a>

  - Nếu bạn đang cài SQL Server offline, tức không có kết nối Internet thì bạn có thể bỏ tích phần User Microsoft Update ...
- Bước 8: Thực hiện update SQL Server

<a href="https://imgur.com/pWInQOc"><img src="https://i.imgur.com/pWInQOc.png" title="source: imgur.com" /></a>

- Bước 9: Sẽ kiểm tra tất cả các rules cho cài đặt SQL Server. Trong hình trên tất cả các rule đều Passed ngoại trừ Windows Fiwall hiển thị cảnh báo (warning), nhưng đâu không phải là vấn đề và bạn có thể Next tiếp. Xem thêm ở đây cách cấu hình Windows Firewall cho truy cập SQL Server.

<a href="https://imgur.com/aEMPwnb"><img src="https://i.imgur.com/aEMPwnb.png" title="source: imgur.com" /></a>

- Bước 10: Chọn các feature mà bạn sẽ cài đặt rồi ấn nút Next (tham khảo phần chọn của chúng tôi). Các bạn chọn từng feature, ở bên tay phải có phần mô tả (description) của feature đó để các bạn hiểu thêm về chức năng của feature đó.
  - Phần (1/2)
  
  <a href="https://imgur.com/noZmtUa"><img src="https://i.imgur.com/noZmtUa.png" title="source: imgur.com" /></a>

  - Phần (2/2)
  
  <a href="https://imgur.com/mYisYDC"><img src="https://i.imgur.com/mYisYDC.png" title="source: imgur.com" /></a>

- Bước 11: Nếu bạn cài SQL Server lần đầu tiên trên máy tính của bạn, thì sẽ không có tên instance (lấy theo mặc định tên máy). Trên một máy có thể cài nhiều bản SQL Server, và mỗi bản có một tên instance khác nhau. Nhập vào Named instance muốn tạo và ấn nút Next.

<a href="https://imgur.com/0qqb2zm"><img src="https://i.imgur.com/0qqb2zm.png" title="source: imgur.com" /></a>

- Bước 12: Cấu hình Server
  - Nếu bạn muốn mỗi tài khoản sẻ phụ trách một dịch vụ SQL Server riêng, bạn có thể tạo tài khoản mới và khởi gán mật khẩu. Nếu không bạn có thể để mặc định và ấn nút Next.

<a href="https://imgur.com/Ju54DXb"><img src="https://i.imgur.com/Ju54DXb.png" title="source: imgur.com" /></a>

- Bước 14: Cấu hình Database Engine
Bạn muốn đăng nhập vào SQL Server theo chết độ nào:
  - Theo tài khoản đăng nhập vào hệ điều hành window (Windows authentication mode)
  - Hoặc hỗn hợp Mixed Mode: bạn phải cung cấp mật khẩu cho chế độ chứng thực SQL Server authentication. Kích nút ADD Current User  để thêm người hiện tại như một người quản trị.

  - Một tài khoản người sử dụng được thêm vào và kích nút Next.
  - Nếu bạn muốn thay đổi đường dẫn chứa dữ liệu thì chọn ở màn hình này.
  - Chọn vào tab TempDB nếu bạn muốn thay đổi kích thước của file TempDB và đường dẫn.
  - Tích vào Enable FILESTREAM nếu muốn có thêm dữ liệu liên quan đến các truy cập T-SQL. Kích nút Next để đi tiếp.

- Bước 15: Cấu hình các dịch vụ phân tích.
  - Chọn chế độ Server Mode và thêm người dùng hiện tại là người quản trị SSAS administrator.
  - Chọn sang tab Data Directories nếu bạn muốn thay đổi đường dẫn cài đặt SSAS, sau đó Ấn Next..

- Bước 16: Cài đặt dịch vụ Reporting


  - Chọn chế độ mặc định Install and configure.
- Bước 17: Cài đặt Microsoft R Open trên máy tính bạn.


- Bước 18: Kiểm tra các rule của các feature đã cài đặt xem có vấn đề gì không.


- Bước 19: Sau khi quá trình kiểm tra hoàn tất, ta sẽ sang bước sẵn sàng để cài đặt. Bạn kích nút Install


- Bước 20: Tranh thủ làm cốc cafe và chờ đợi thành quả cài đặt.


- Bước 21: Quá trình cài đặt thành công thì sẽ hiển thị lên thông báo và yêu cầu khởi động lại máy tính.


  - Kích nút Close để hoàn thành việc cài đặt.
  - Bây giờ tôi sẽ thử kiểm tra sẽ các feature nào đã được cài đặt trong menu Start?
  - Bạn có thể phát hiện ra là không SQL Server Management Studio.
  - Đưng lo lắng, chúng ta phải download SQL Server Management Studio and SSDT 2015 (SSIS, SSRS và SSAS) và cài đặt riêng rẽ.

# 3. Cài đặt SSMS

Bước 1: Kích vào tệp vừa tải về (mặc định trong thư mục Download).

Bước 2: Kích Install.

Qúa trình cài đặt mất một khoảng thời gian, sau khi hoàn thành thì ấn nút Close để kết thúc.

SSMS đã cài đặt thành công.

# 4. Cài đặt SSDT
Giống như SSMS, tải SSDT từ Internet, sau khi tải về thành công, bạn chạy file SSDT Setup như hình bên dưới.

Chọn SSIS, SSRS và SSAS và kích Next.

Kích nút Close để kết thúc quá trình cài đặt.

# Tài liệu tham khảo

1. https://timoday.edu.vn/cai-dat-tung-buoc-sql-server-2016-ssms-va-cong-cu-ssdt/
2. https://www.microsoft.com/en-us/download/confirmation.aspx?id=54276
3. https://www.microsoft.com/en-us/download/details.aspx?id=56836
4. https://wiki.tino.org/huong-dan-cai-dat-sql-server-2016-sp2-express/
