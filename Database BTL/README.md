💼 Dự án CSDL nâng cao: Quản lý bán hàng & kho cho chuỗi cửa hàng
👤 Thành viên thực hiện:

Tên: Nguyễn Văn Du

Vai trò: Tạo CSDL + viết script SQL + thêm dữ liệu mẫu (≥10 bản ghi/bảng)

Ngày hoàn thành: 25/10/2025

⚙️ 1. Thông tin môi trường
Thành phần	Phiên bản
Hệ quản trị CSDL (DBMS)	MySQL 8.0.x
Công cụ làm việc	MySQL Workbench 8.x
Hệ điều hành	Windows 10 / 11
Ngôn ngữ script	SQL (MySQL dialect)
🏗️ 2. Cấu trúc database

CSDL: QuanLyBanHang
Gồm 11 bảng chính:

DANHMUC, SANPHAM, NHACUNGCAP, KHO, TONKHO, KHACHHANG,
DONHANG, CHITIET_DONHANG, THANHTOAN, KHUYENMAI, SANPHAM_KHUYENMAI


Mỗi bảng có ít nhất 10 bản ghi mẫu, có khóa chính – khóa ngoại đầy đủ,
và đảm bảo quan hệ N–N giữa:

SANPHAM ↔ NHACUNGCAP

SANPHAM ↔ KHUYENMAI

KHO ↔ SANPHAM (qua TONKHO)

DONHANG ↔ SANPHAM (qua CHITIET_DONHANG)

🧩 3. Hướng dẫn chạy
🔹 Bước 1: Tạo CSDL và bảng

Mở MySQL Workbench → Tạo kết nối → Mở file create_database.sql
Chạy toàn bộ script để:

Tạo database QuanLyBanHang

Tạo tất cả các bảng

Thêm dữ liệu mẫu

🔹 Bước 2: Kiểm tra dữ liệu

Chạy các câu truy vấn sau để kiểm tra:

-- Kiểm tra tổng số bản ghi mỗi bảng
SELECT 'DANHMUC' AS Bang, COUNT(*) FROM DANHMUC
UNION ALL SELECT 'SANPHAM', COUNT(*) FROM SANPHAM
UNION ALL SELECT 'KHACHHANG', COUNT(*) FROM KHACHHANG
UNION ALL SELECT 'DONHANG', COUNT(*) FROM DONHANG
UNION ALL SELECT 'CHITIET_DONHANG', COUNT(*) FROM CHITIET_DONHANG;

📊 4. Các truy vấn minh họa
4.1. Báo cáo doanh thu theo tháng
SELECT 
  MONTH(NgayDat) AS Thang,
  YEAR(NgayDat) AS Nam,
  SUM(TongTien) AS DoanhThu
FROM DONHANG
GROUP BY YEAR(NgayDat), MONTH(NgayDat)
ORDER BY Nam, Thang;

4.2. Sản phẩm bán chạy nhất
SELECT sp.TenSP, SUM(ct.SoLuong) AS TongSoLuong
FROM CHITIET_DONHANG ct
JOIN SANPHAM sp ON ct.MaSP = sp.MaSP
GROUP BY sp.MaSP, sp.TenSP
ORDER BY TongSoLuong DESC
LIMIT 5;

4.3. Khách hàng VIP (mua nhiều nhất)
SELECT kh.HoTen, SUM(dh.TongTien) AS TongChiTieu
FROM DONHANG dh
JOIN KHACHHANG kh ON dh.MaKH = kh.MaKH
GROUP BY kh.MaKH, kh.HoTen
ORDER BY TongChiTieu DESC
LIMIT 5;