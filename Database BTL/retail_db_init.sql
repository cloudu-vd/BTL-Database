-- Tạo database và dùng nó
DROP DATABASE IF EXISTS retail_db;
CREATE DATABASE retail_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE retail_db;

-- -----------------------------
-- Bảng DANHMUC (Danh mục sản phẩm)
-- -----------------------------
CREATE TABLE DANHMUC (
  MaDM VARCHAR(10) PRIMARY KEY,
  TenDM VARCHAR(100) NOT NULL,
  MoTa TEXT
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng NHACUNGCAP (Nhà cung cấp)
-- -----------------------------
CREATE TABLE NHACUNGCAP (
  MaNCC VARCHAR(10) PRIMARY KEY,
  TenNCC VARCHAR(150) NOT NULL,
  DiaChi VARCHAR(255),
  SDT VARCHAR(20),
  Email VARCHAR(100)
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng KHO
-- -----------------------------
CREATE TABLE KHO (
  MaKho VARCHAR(10) PRIMARY KEY,
  TenKho VARCHAR(150) NOT NULL,
  DiaChi VARCHAR(255)
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng SANPHAM
-- -----------------------------
CREATE TABLE SANPHAM (
  MaSP VARCHAR(15) PRIMARY KEY,
  TenSP VARCHAR(200) NOT NULL,
  MaDM VARCHAR(10) NOT NULL,
  DonGia DECIMAL(14,2) NOT NULL DEFAULT 0.00,
  DonViTinh VARCHAR(30),
  TrangThai ENUM('HoatDong','NgungBan','HetHang') DEFAULT 'HoatDong',
  FOREIGN KEY (MaDM) REFERENCES DANHMUC(MaDM)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng nối NHACUNGCAP <-> SANPHAM (N-N)
-- -----------------------------
CREATE TABLE NHACUNGCAP_SANPHAM (
  MaNCC VARCHAR(10) NOT NULL,
  MaSP VARCHAR(15) NOT NULL,
  GiaNhap DECIMAL(14,2) DEFAULT NULL,
  PRIMARY KEY (MaNCC, MaSP),
  FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng TONKHO
-- -----------------------------
CREATE TABLE TONKHO (
  MaKho VARCHAR(10) NOT NULL,
  MaSP VARCHAR(15) NOT NULL,
  SoLuong INT NOT NULL DEFAULT 0,
  NgayCapNhat DATE NOT NULL,
  PRIMARY KEY (MaKho, MaSP),
  FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng KHACHHANG
-- -----------------------------
CREATE TABLE KHACHHANG (
  MaKH VARCHAR(12) PRIMARY KEY,
  HoTen VARCHAR(150) NOT NULL,
  SDT VARCHAR(20),
  Email VARCHAR(100),
  DiaChi VARCHAR(255),
  HangThanhVien ENUM('Bronze','Silver','Gold','Platinum') DEFAULT 'Bronze',
  DiemTichLuy INT DEFAULT 0
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng DONHANG
-- -----------------------------
CREATE TABLE DONHANG (
  MaDH VARCHAR(15) PRIMARY KEY,
  MaKH VARCHAR(12) NOT NULL,
  NgayDat DATE NOT NULL,
  NgayGiao DATE DEFAULT NULL,
  TrangThai ENUM('ĐangXyLy','DaGiao','DaHuy','HoanThanh') DEFAULT 'ĐangXyLy',
  TongTien DECIMAL(14,2) DEFAULT 0.00,
  FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng CHITIET_DONHANG
-- -----------------------------
CREATE TABLE CHITIET_DONHANG (
  MaDH VARCHAR(15) NOT NULL,
  MaSP VARCHAR(15) NOT NULL,
  SoLuong INT NOT NULL,
  DonGia DECIMAL(14,2) NOT NULL,
  ChietKhau DECIMAL(5,2) DEFAULT 0.00, -- phần trăm
  PRIMARY KEY (MaDH, MaSP),
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng THANHTOAN
-- -----------------------------
CREATE TABLE THANHTOAN (
  MaTT VARCHAR(15) PRIMARY KEY,
  MaDH VARCHAR(15) NOT NULL,
  NgayThanhToan DATETIME NOT NULL,
  SoTien DECIMAL(14,2) NOT NULL,
  PhuongThuc VARCHAR(50),
  FOREIGN KEY (MaDH) REFERENCES DONHANG(MaDH)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng KHUYENMAI
-- -----------------------------
CREATE TABLE KHUYENMAI (
  MaKM VARCHAR(12) PRIMARY KEY,
  TenKM VARCHAR(200) NOT NULL,
  NgayBatDau DATE NOT NULL,
  NgayKetThuc DATE NOT NULL,
  PhanTramGiam DECIMAL(5,2) NOT NULL -- ví dụ 10.00 = 10%
) ENGINE=InnoDB;

-- -----------------------------
-- Bảng SANPHAM_KHUYENMAI (N-N)
-- -----------------------------
CREATE TABLE SANPHAM_KHUYENMAI (
  MaSP VARCHAR(15) NOT NULL,
  MaKM VARCHAR(12) NOT NULL,
  PRIMARY KEY (MaSP, MaKM),
  FOREIGN KEY (MaSP) REFERENCES SANPHAM(MaSP)
    ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (MaKM) REFERENCES KHUYENMAI(MaKM)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================
-- Thêm dữ liệu mẫu (≥10 bản ghi mỗi bảng)
-- ============================================

-- DANHMUC (10)
INSERT INTO DANHMUC (MaDM, TenDM, MoTa) VALUES
('DM001','ThucPham','Đồ ăn, thực phẩm thiết yếu'),
('DM002','DoUong','Nước uống, đồ giải khát'),
('DM003','MyPham','Mỹ phẩm & chăm sóc cá nhân'),
('DM004','DienMay','Điện máy - thiết bị điện tử'),
('DM005','ThoiTrang','Thời trang & phụ kiện'),
('DM006','DoDungGiaDinh','Đồ dùng gia đình'),
('DM007','DoTheThao','Đồ thể thao & dã ngoại'),
('DM008','DoChoTreEm','Đồ chơi & sản phẩm trẻ em'),
('DM009','VanPhongPham','Văn phòng phẩm'),
('DM010','Khac','Sản phẩm khác');

-- NHACUNGCAP (10)
INSERT INTO NHACUNGCAP (MaNCC, TenNCC, DiaChi, SDT, Email) VALUES
('NCC01','Công ty Thực Phẩm A','Hà Nội','024-1234567','info@tp-a.vn'),
('NCC02','Nước Uống B','Hồ Chí Minh','028-7654321','sales@nuocuongb.vn'),
('NCC03','Mỹ Phẩm C','Đà Nẵng','0236-333444','support@myphamc.vn'),
('NCC04','Điện Máy D','Hải Phòng','0225-999888','contact@dienmayd.vn'),
('NCC05','Thời Trang E','Hà Nội','024-5556666','fashion@thoitrange.vn'),
('NCC06','Gia Dụng F','Biên Hòa','0251-444333','service@gd-f.vn'),
('NCC07','Thể Thao G','Đà Lạt','0263-111222','sport@g.com'),
('NCC08','Trẻ Em H','Thanh Hóa','0237-777888','baby@h.vn'),
('NCC09','Văn Phòng I','Ninh Bình','0229-222333','office@i.vn'),
('NCC10','Nhà Cung Cấp J','Huế','0234-888999','jc@example.com');

-- KHO (10)
INSERT INTO KHO (MaKho, TenKho, DiaChi) VALUES
('K001','Kho Hà Nội','Số 1, Hà Nội'),
('K002','Kho HCM','Số 2, Quận 1, HCM'),
('K003','Kho Đà Nẵng','Số 3, Đà Nẵng'),
('K004','Kho Hải Phòng','Số 4, Hải Phòng'),
('K005','Kho Cần Thơ','Số 5, Cần Thơ'),
('K006','Kho Bình Dương','KCN VSIP'),
('K007','Kho Nha Trang','22, Nha Trang'),
('K008','Kho Huế','12, Huế'),
('K009','Kho Vũng Tàu','18, Vũng Tàu'),
('K010','Kho Thanh Hóa','7, Thanh Hóa');

-- SANPHAM (12)
INSERT INTO SANPHAM (MaSP, TenSP, MaDM, DonGia, DonViTinh, TrangThai) VALUES
('SP001','Gạo thơm 5kg','DM001',180000.00,'Bịch','HoatDong'),
('SP002','Nước suối 500ml','DM002',8000.00,'Chai','HoatDong'),
('SP003','Sữa tắm Fresh 250ml','DM003',65000.00,'Chai','HoatDong'),
('SP004','Tivi 43 inch','DM004',7500000.00,'Cái','HoatDong'),
('SP005','Áo thun nam M','DM005',150000.00,'Cái','HoatDong'),
('SP006','Nồi cơm điện 1.8L','DM006',900000.00,'Cái','HoatDong'),
('SP007','Giày chạy bộ size 42','DM007',1200000.00,'Đôi','HoatDong'),
('SP008','Búp bê vải','DM008',250000.00,'Cái','HoatDong'),
('SP009','Tập vở 200 trang','DM009',18000.00,'Cuốn','HoatDong'),
('SP010','Sáp thơm ô tô','DM010',95000.00,'Cái','HoatDong'),
('SP011','Nước ngọt 1.5L','DM002',22000.00,'Chai','HoatDong'),
('SP012','Son môi đỏ 3g','DM003',210000.00,'Cái','HoatDong');

-- NHACUNGCAP_SANPHAM (liên kết nhiều-nhiều)
INSERT INTO NHACUNGCAP_SANPHAM (MaNCC, MaSP, GiaNhap) VALUES
('NCC01','SP001',120000.00),
('NCC02','SP002',4000.00),
('NCC02','SP011',14000.00),
('NCC03','SP003',35000.00),
('NCC03','SP012',120000.00),
('NCC04','SP004',6500000.00),
('NCC05','SP005',80000.00),
('NCC06','SP006',650000.00),
('NCC07','SP007',800000.00),
('NCC08','SP008',150000.00),
('NCC09','SP009',9000.00),
('NCC10','SP010',60000.00);

-- TONKHO (ít nhất 10 bản ghi, phân bổ nhiều kho)
INSERT INTO TONKHO (MaKho, MaSP, SoLuong, NgayCapNhat) VALUES
('K001','SP001',120, '2025-10-01'),
('K002','SP001',80,  '2025-10-05'),
('K001','SP002',500, '2025-10-10'),
('K002','SP002',400, '2025-10-09'),
('K003','SP004',20,  '2025-10-02'),
('K004','SP006',35,  '2025-10-03'),
('K005','SP005',60,  '2025-10-08'),
('K001','SP009',200, '2025-10-06'),
('K006','SP007',50,  '2025-10-07'),
('K007','SP008',30,  '2025-10-04'),
('K008','SP010',90,  '2025-10-01'),
('K009','SP011',220, '2025-10-10'),
('K010','SP012',40, '2025-10-11'),
('K002','SP004',10, '2025-10-12'),
('K003','SP005',12, '2025-10-12');

-- KHACHHANG (12)
INSERT INTO KHACHHANG (MaKH, HoTen, SDT, Email, DiaChi, HangThanhVien, DiemTichLuy) VALUES
('KH001','Nguyễn Văn A','0912345678','a@example.com','Hà Nội','Gold',1200),
('KH002','Trần Thị B','0987654321','b@example.com','Hồ Chí Minh','Silver',450),
('KH003','Lê Văn C','0901111222','c@example.com','Đà Nẵng','Bronze',80),
('KH004','Phạm Thị D','0911222333','d@example.com','Hải Phòng','Gold',980),
('KH005','Hoàng E','0912333444','e@example.com','Cần Thơ','Silver',500),
('KH006','Vũ F','0922333444','f@example.com','Bình Dương','Bronze',60),
('KH007','Đỗ G','0933444555','g@example.com','Huế','Platinum',3200),
('KH008','Phan H','0944555666','h@example.com','Nha Trang','Silver',700),
('KH009','Trương I','0955666777','i@example.com','Vũng Tàu','Bronze',30),
('KH010','Bùi J','0966777888','j@example.com','Thanh Hóa','Gold',1500),
('KH011','Ngô K','0977888999','k@example.com','Quảng Ninh','Silver',600),
('KH012','Dương L','0988999000','l@example.com','Thái Bình','Bronze',20);

-- KHUYENMAI (10)
INSERT INTO KHUYENMAI (MaKM, TenKM, NgayBatDau, NgayKetThuc, PhanTramGiam) VALUES
('KM001','Giảm 10% Tất cả nước uống','2025-09-01','2025-11-01',10.00),
('KM002','BlackFriday - 25% Điện máy','2025-11-20','2025-11-30',25.00),
('KM003','Giảm 5% Khách hàng Silver','2025-01-01','2025-12-31',5.00),
('KM004','Combo 2 tặng 1 Búp bê','2025-10-01','2025-12-31',33.33),
('KM005','Giảm 15% Giày chạy bộ','2025-08-01','2025-12-31',15.00),
('KM006','Giảm 20% Son môi','2025-10-10','2025-10-31',20.00),
('KM007','Khuyến mãi Tập vở - học sinh','2025-09-01','2025-10-31',10.00),
('KM008','Giảm 7% Nồi cơm điện','2025-10-01','2025-12-31',7.00),
('KM009','Ưu đãi khách mới 10%','2025-01-01','2026-01-01',10.00),
('KM010','Khuyến mãi tháng 10 - Đồ gia dụng 12%','2025-10-01','2025-10-31',12.00);

-- Áp khuyến mãi cho sản phẩm (≥10 liên kết)
INSERT INTO SANPHAM_KHUYENMAI (MaSP, MaKM) VALUES
('SP002','KM001'),
('SP011','KM001'),
('SP004','KM002'),
('SP007','KM005'),
('SP008','KM004'),
('SP012','KM006'),
('SP006','KM008'),
('SP009','KM007'),
('SP001','KM009'),
('SP005','KM010'),
('SP006','KM010');

-- DONHANG (12)
-- Lưu ý: TongTien tạm thời ghi thủ công, có thể tính bằng truy vấn sau
INSERT INTO DONHANG (MaDH, MaKH, NgayDat, NgayGiao, TrangThai, TongTien) VALUES
('DH0001','KH001','2025-10-01','2025-10-03','HoanThanh', 450000.00),
('DH0002','KH002','2025-10-02',NULL,'ĐangXyLy', 86000.00),
('DH0003','KH003','2025-10-03','2025-10-05','DaGiao', 75000.00),
('DH0004','KH004','2025-10-04','2025-10-06','HoanThanh', 7800000.00),
('DH0005','KH005','2025-10-05',NULL,'ĐangXyLy', 300000.00),
('DH0006','KH006','2025-10-06','2025-10-08','HoanThanh', 180000.00),
('DH0007','KH007','2025-10-07','2025-10-09','DaGiao', 150000.00),
('DH0008','KH008','2025-10-08',NULL,'ĐangXyLy', 22000.00),
('DH0009','KH009','2025-10-09','2025-10-12','HoanThanh', 1250000.00),
('DH0010','KH010','2025-10-10','2025-10-12','HoanThanh', 950000.00),
('DH0011','KH011','2025-10-11',NULL,'ĐangXyLy', 36000.00),
('DH0012','KH012','2025-10-12','2025-10-14','DaGiao', 270000.00);

-- CHITIET_DONHANG (nhiều bản ghi cho các đơn)
INSERT INTO CHITIET_DONHANG (MaDH, MaSP, SoLuong, DonGia, ChietKhau) VALUES
('DH0001','SP001',2,180000.00,0.00),   -- 360k
('DH0001','SP002',3,8000.00,0.00),     -- 24k  => Tổng 384k (ví dụ TongTien 450k có phí/ship)
('DH0002','SP009',2,18000.00,5.00),    -- 36k với chiết khấu 5%
('DH0002','SP003',1,65000.00,0.00),    -- 65k
('DH0003','SP003',1,65000.00,0.00),
('DH0004','SP004',1,7500000.00,10.00), -- điện máy giảm 10% (ví dụ)
('DH0005','SP005',2,150000.00,0.00),
('DH0006','SP002',5,8000.00,0.00),
('DH0007','SP008',1,250000.00,0.00),
('DH0008','SP011',1,22000.00,0.00),
('DH0009','SP007',1,1200000.00,15.00),
('DH0009','SP010',2,95000.00,0.00),
('DH0010','SP006',1,900000.00,7.00),
('DH0011','SP009',2,18000.00,0.00),
('DH0012','SP012',1,210000.00,20.00),
('DH0012','SP002',2,8000.00,0.00);

-- THANHTOAN (≥12, bao gồm nhiều lần thanh toán cho 1 đơn)
INSERT INTO THANHTOAN (MaTT, MaDH, NgayThanhToan, SoTien, PhuongThuc) VALUES
('TT0001','DH0001','2025-10-03 10:00:00',384000.00,'Tiền mặt'),
('TT0002','DH0001','2025-10-03 10:05:00',66000.00,'Chuyển khoản'),
('TT0003','DH0002','2025-10-02 14:00:00',86000.00,'Momo'),
('TT0004','DH0003','2025-10-05 09:30:00',75000.00,'Tiền mặt'),
('TT0005','DH0004','2025-10-06 12:00:00',6750000.00,'Chuyển khoản'),
('TT0006','DH0005','2025-10-06 16:00:00',300000.00,'Tiền mặt'),
('TT0007','DH0006','2025-10-08 11:20:00',180000.00,'Tiền mặt'),
('TT0008','DH0007','2025-10-09 15:00:00',150000.00,'Thẻ'),
('TT0009','DH0008','2025-10-08 17:00:00',22000.00,'Momo'),
('TT0010','DH0009','2025-10-12 10:10:00',1250000.00,'Chuyển khoản'),
('TT0011','DH0010','2025-10-12 18:00:00',950000.00,'Thẻ'),
('TT0012','DH0011','2025-10-11 19:00:00',36000.00,'Momo'),
('TT0013','DH0012','2025-10-14 09:00:00',170000.00,'Tiền mặt'),
('TT0014','DH0012','2025-10-14 09:05:00',100000.00,'Chuyển khoản');

-- Kiểm tra: cập nhật các TongTien cho DONHANG tự động (ví dụ, nếu muốn)
-- (Tùy chọn) Tính lại TongTien từ CHITIET_DONHANG (tạm thời comment, để bạn chạy khi cần)
-- UPDATE DONHANG d
-- JOIN (
--   SELECT MaDH, SUM(SoLuong * DonGia * (1 - ChietKhau/100)) AS ttl
--   FROM CHITIET_DONHANG
--   GROUP BY MaDH
-- ) t ON d.MaDH = t.MaDH
-- SET d.TongTien = t.ttl;

-- Một số index hỗ trợ truy vấn nhanh (khuyến nghị)
CREATE INDEX idx_sanpham_madanhmuc ON SANPHAM(MaDM);
CREATE INDEX idx_tonkho_masp ON TONKHO(MaSP);
CREATE INDEX idx_chitiet_masp ON CHITIET_DONHANG(MaSP);
CREATE INDEX idx_thanhtoan_madh ON THANHTOAN(MaDH);

-- Kết thúc script
COMMIT;
