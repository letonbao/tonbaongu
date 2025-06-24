class Order {
  final String maDH;
  final String maND;
  final String ngayDatHang;
  final double tongGiaTri;
  final String trangThaiDonHang;

  Order({
    required this.maDH,
    required this.maND,
    required this.ngayDatHang,
    required this.tongGiaTri,
    required this.trangThaiDonHang,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      maDH: json['MaDH']?.toString() ?? '',
      maND: json['MaND']?.toString() ?? '',
      ngayDatHang: json['NgayDatHang'] ?? '',
      tongGiaTri: double.tryParse(json['TongGiaTri']?.toString() ?? '0.0') ?? 0.0,
      trangThaiDonHang: json['TrangThaiDonHang'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'MaDH': maDH,
    'MaND': maND,
    'NgayDatHang': ngayDatHang,
    'TongGiaTri': tongGiaTri,
    'TrangThaiDonHang': trangThaiDonHang,
  };
}
