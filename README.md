Dự án CSDL nâng cao: “Quản lý bán hàng & kho cho chuỗi cửa hàng”

1️⃣ Mục tiêu

Xây dựng hệ thống cơ sở dữ liệu quản lý:
 • Sản phẩm, danh mục, tồn kho
 • Nhà cung cấp
 • Khách hàng & đơn hàng
 • Thanh toán, khuyến mãi
 • Báo cáo doanh thu

Hệ thống này mô phỏng nghiệp vụ thực tế của một doanh nghiệp bán lẻ.

⸻

2️⃣ Các bảng & quan hệ

Bảng SANPHAM

| MaSP (PK) | TenSP | MaDM (FK) | DonGia | DonViTinh | TrangThai |

Bảng DANHMUC

| MaDM (PK) | TenDM | MoTa |

Bảng NHACUNGCAP

| MaNCC (PK) | TenNCC | DiaChi | SDT | Email |

Bảng KHO

| MaKho (PK) | TenKho | DiaChi |

Bảng TONKHO

| MaKho (FK) | MaSP (FK) | SoLuong | NgayCapNhat | PRIMARY KEY(MaKho,MaSP) |

Bảng KHACHHANG

| MaKH (PK) | HoTen | SDT | Email | DiaChi | HangThanhVien |

Bảng DONHANG

| MaDH (PK) | MaKH (FK) | NgayDat | NgayGiao | TrangThai | TongTien |

Bảng CHITIET_DONHANG

| MaDH (FK) | MaSP (FK) | SoLuong | DonGia | ChietKhau | PRIMARY KEY(MaDH,MaSP) |

Bảng THANHTOAN

| MaTT (PK) | MaDH (FK) | NgayThanhToan | SoTien | PhuongThuc |

Bảng KHUYENMAI

| MaKM (PK) | TenKM | NgayBatDau | NgayKetThuc | PhanTramGiam |

Bảng SANPHAM_KHUYENMAI

| MaSP (FK) | MaKM (FK) | PRIMARY KEY(MaSP,MaKM) |

⸻

3️⃣ Nghiệp vụ phức tạp hơn
 • Sản phẩm có nhiều nhà cung cấp, nhiều khuyến mãi cùng lúc.
 • Tồn kho quản lý ở nhiều kho khác nhau.
 • Đơn hàng có nhiều sản phẩm, áp dụng nhiều mức chiết khấu.
 • Khách hàng có hạng thành viên (tích điểm).
 • Thanh toán có thể chia làm nhiều lần (nếu muốn nâng cao hơn nữa).

⸻

4️⃣ Phân công cho 4 thành viên
Thành viên
Nhiệm vụ
1
Thiết kế ERD & mô hình quan hệ (liệt kê các bảng, khoá chính, khoá ngoại, quan hệ N-N).
2
Tạo CSDL + viết script SQL tạo bảng, thêm dữ liệu mẫu (ít nhất 10 bản ghi mỗi bảng).
3
Viết truy vấn SQL nâng cao: báo cáo tồn kho, doanh thu theo tháng, khách hàng VIP, sản phẩm bán chạy… (có GROUP BY, JOIN, subquery, view).
4
Viết Stored Procedure/Trigger: ví dụ cập nhật tự động số lượng tồn kho khi có đơn hàng mới, tự động tính điểm tích lũy khách hàng, áp dụng khuyến mãi.
5️⃣ Công cụ & kết quả
 • DBMS: MySQL hoặc PostgreSQL
 • Vẽ ERD: Lucidchart, Draw.io, MySQL Workbench
 • Báo cáo: mô tả nghiệp vụ, sơ đồ CSDL, script SQL, output các truy vấn