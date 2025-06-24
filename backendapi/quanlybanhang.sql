-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th6 24, 2025 lúc 05:17 AM
-- Phiên bản máy phục vụ: 8.2.0
-- Phiên bản PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `quanlybanhang`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitietdonhang`
--

DROP TABLE IF EXISTS `chitietdonhang`;
CREATE TABLE IF NOT EXISTS `chitietdonhang` (
  `MaCTDH` int NOT NULL AUTO_INCREMENT,
  `MaDH` int NOT NULL,
  `MaSanPham` int NOT NULL,
  `SoLuong` int NOT NULL,
  `Gia` decimal(15,2) NOT NULL,
  PRIMARY KEY (`MaCTDH`),
  KEY `MaDH` (`MaDH`),
  KEY `MaSanPham` (`MaSanPham`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

DROP TABLE IF EXISTS `danhgia`;
CREATE TABLE IF NOT EXISTS `danhgia` (
  `MaDG` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `MaSanPham` int NOT NULL,
  `NoiDungDanhGia` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `SoSao` int DEFAULT NULL,
  `NgayDanhGia` date DEFAULT NULL,
  PRIMARY KEY (`MaDG`),
  KEY `MaND` (`MaND`),
  KEY `MaSanPham` (`MaSanPham`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhsachyeuthich`
--

DROP TABLE IF EXISTS `danhsachyeuthich`;
CREATE TABLE IF NOT EXISTS `danhsachyeuthich` (
  `MaDSYT` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `MaSanPham` int NOT NULL,
  PRIMARY KEY (`MaDSYT`),
  KEY `MaND` (`MaND`),
  KEY `MaSanPham` (`MaSanPham`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danhsachyeuthich`
--

INSERT INTO `danhsachyeuthich` (`MaDSYT`, `MaND`, `MaSanPham`) VALUES
(1, 6, 4),
(2, 6, 1),
(3, 6, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diachi`
--

DROP TABLE IF EXISTS `diachi`;
CREATE TABLE IF NOT EXISTS `diachi` (
  `MaDC` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `DuongPho` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Tinh` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ThanhPho` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MaBuuDien` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaDC`),
  KEY `MaND` (`MaND`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `donhang`
--

DROP TABLE IF EXISTS `donhang`;
CREATE TABLE IF NOT EXISTS `donhang` (
  `MaDH` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `NgayDatHang` date NOT NULL,
  `TongGiaTri` decimal(15,2) NOT NULL,
  `TrangThaiDonHang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`MaDH`),
  KEY `MaND` (`MaND`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `donhang`
--

INSERT INTO `donhang` (`MaDH`, `MaND`, `NgayDatHang`, `TongGiaTri`, `TrangThaiDonHang`) VALUES
(1, 1, '2025-06-10', 10000.00, 'Đang xử lý'),
(3, 4, '2025-06-20', 50000.00, 'Hoàn thành');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giohang`
--

DROP TABLE IF EXISTS `giohang`;
CREATE TABLE IF NOT EXISTS `giohang` (
  `MaGH` int NOT NULL AUTO_INCREMENT,
  `MaND` int NOT NULL,
  `MaSanPham` int NOT NULL,
  `SoLuong` int NOT NULL,
  `Gia` decimal(10,2) NOT NULL,
  PRIMARY KEY (`MaGH`),
  KEY `MaND` (`MaND`),
  KEY `MaSanPham` (`MaSanPham`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

DROP TABLE IF EXISTS `nguoidung`;
CREATE TABLE IF NOT EXISTS `nguoidung` (
  `MaND` int NOT NULL AUTO_INCREMENT,
  `Ten` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MatKhau` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SoDienThoai` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Role` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'user',
  PRIMARY KEY (`MaND`),
  UNIQUE KEY `Email` (`Email`)
) ;

--
-- Đang đổ dữ liệu cho bảng `nguoidung`
--

INSERT INTO `nguoidung` (`MaND`, `Ten`, `MatKhau`, `SoDienThoai`, `Email`, `Role`) VALUES
(1, 'Nguyễn Văn A', '123456412', '0901234567', 'vana@example.com', 'admin'),
(4, 'few', '123123', '4184184', 'b@gmail.com', 'user'),
(6, 'bao ngu', '123', '09123123121', 'tonbao@gmail.com', 'user'),
(8, 'ton bao', '123', '09123123121', 'tonbao1@gmail.com', 'user'),
(10, 'Admin mới', 'admin123', '0900000000', 'admin@gmail.com', 'admin'),
(11, 'Khách mới', 'user123', '0900111222', 'user@example.com', 'user');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

DROP TABLE IF EXISTS `sanpham`;
CREATE TABLE IF NOT EXISTS `sanpham` (
  `MaSanPham` int NOT NULL AUTO_INCREMENT,
  `TenSanPham` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Mota` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Gia` decimal(15,2) NOT NULL,
  `SoLuongTonKho` int NOT NULL,
  `TrangThai` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MauSac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `KichCo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `HinhAnh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`MaSanPham`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`MaSanPham`, `TenSanPham`, `Mota`, `Gia`, `SoLuongTonKho`, `TrangThai`, `MauSac`, `KichCo`, `HinhAnh`) VALUES
(1, 'Áo thun nam', 'Áo thun chất lượng cao', 199000.00, 20, 'Còn hàng', 'Đen', 'XXL', 'assets/images/shirt.png'),
(2, 'Áo len nữ', 'Sang trọng , quý phái', 299000.00, 15, 'Còn hàng', 'Xám', 'M', 'assets/images/aolen.png'),
(4, 'Áo len nam', 'Áo len siêu đẹp', 50000.00, 1, 'Còn hàng', 'Đen, trắng', 'L', 'assets/images/shirt_len.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanhtoan`
--

DROP TABLE IF EXISTS `thanhtoan`;
CREATE TABLE IF NOT EXISTS `thanhtoan` (
  `MaTT` int NOT NULL AUTO_INCREMENT,
  `MaDH` int NOT NULL,
  `PhuongThuc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TrangThai` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NgayThanhToan` date DEFAULT NULL,
  PRIMARY KEY (`MaTT`),
  KEY `MaDH` (`MaDH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `donhang`
--
ALTER TABLE `donhang`
  ADD CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

--
-- Các ràng buộc cho bảng `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `giohang_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`),
  ADD CONSTRAINT `giohang_ibfk_2` FOREIGN KEY (`MaSanPham`) REFERENCES `sanpham` (`MaSanPham`);

--
-- Các ràng buộc cho bảng `thanhtoan`
--
ALTER TABLE `thanhtoan`
  ADD CONSTRAINT `thanhtoan_ibfk_1` FOREIGN KEY (`MaDH`) REFERENCES `donhang` (`MaDH`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
