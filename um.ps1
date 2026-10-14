Phần 1: Thiết kế kiến trúc
Cấu trúc của tệp auto_report.ps1 được chia thành 4 khối chức năng chính:

Header block: Khối thông tin chú thích đầu tệp (Script Name, Author, Date) sử dụng ký hiệu #.

Biến cấu hình: Khai báo đường dẫn tệp log nguồn và tệp báo cáo đích thông qua cú pháp biến $variable.

Thông báo tiến trình: Sử dụng lệnh Write-Host để hiển thị trạng thái thực thi trực tiếp ra màn hình terminal một cách trực quan mà không bị trộn lẫn vào dữ liệu ghi vào tệp.

Logic xử lý: Chuỗi thao tác tự động hóa gồm tạo tiêu đề mới, đọc dữ liệu từ tệp log (Get-Content), lọc lỗi qua đường ống Pipeline (Select-String), và ghi nối tiếp kết quả vào tệp báo cáo (Out-File -Append).

<#
.SYNOPSIS
    Script tự động lọc lỗi 404 và xuất báo cáo tự động cho hệ thống log.
.AUTHOR
    Lê Hồ Thanh Thảo
.DATE
    2026-10-14
#>

# Bước 1: Khai báo biến cấu hình đường dẫn tệp
$duong_dan_log = "server.log"
$duong_dan_bao_cao = "report.txt"

# Bước 2: Thông báo tiến trình ra màn hình bằng Write-Host
Write-Host "Đang tiến hành đọc và lọc lỗi 404 từ tệp log hệ thống..." -ForegroundColor Cyan

# Bước 3: Tạo tiêu đề Header mới vào tệp kết quả (Ghi đè nội dung cũ)
"=== HỆ THỐNG TỰ ĐỘNG LỌC LOG ===" | Out-File -FilePath $duong_dan_bao_cao -Encoding utf8

# Bước 4: Đọc log, lọc lỗi 404 qua Pipeline và lưu nối tiếp vào tệp báo cáo
Get-Content -Path $duong_dan_log | Select-String "404" | Out-File -FilePath $duong_dan_bao_cao -Append -Encoding utf8

# Bước 5: Thông báo hoàn tất quá trình thực thi
Write-Host "Hoàn tất! Kết quả đã được lưu thành công vào tệp $duong_dan_bao_cao" -ForegroundColor Green
