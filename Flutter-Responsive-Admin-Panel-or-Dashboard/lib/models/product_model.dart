// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final int stock;
//   final String status;
//   final String color;
//   final String size;
//   final String image;

//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.status,
//     required this.color,
//     required this.size,
//     required this.image,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'stock': stock,
//       'status': status,
//       'color': color,
//       'size': size,
//       'image': image,
//     };
//   }
// }

class Product {
  final String maSanPham;
  final String tenSanPham;
  final String mota;
  final double gia;
  final int soLuongTonKho;
  final String trangThai;
  final String mauSac;
  final String kichCo;
  final String hinhAnh;

  Product({
    required this.maSanPham,
    required this.tenSanPham,
    required this.mota,
    required this.gia,
    required this.soLuongTonKho,
    required this.trangThai,
    required this.mauSac,
    required this.kichCo,
    required this.hinhAnh,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      maSanPham: json['MaSanPham']?.toString() ?? '',
      tenSanPham: json['TenSanPham'] ?? '',
      mota: json['Mota'] ?? '',
      gia: double.tryParse(json['Gia']?.toString() ?? '0.0') ?? 0.0,
      soLuongTonKho: int.tryParse(json['SoLuongTonKho']?.toString() ?? '0') ?? 0,
      trangThai: json['TrangThai'] ?? '',
      mauSac: json['MauSac'] ?? '',
      kichCo: json['KichCo'] ?? '',
      hinhAnh: json['HinhAnh'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaSanPham': maSanPham,
      'TenSanPham': tenSanPham,
      'Mota': mota,
      'Gia': gia,
      'SoLuongTonKho': soLuongTonKho,
      'TrangThai': trangThai,
      'MauSac': mauSac,
      'KichCo': kichCo,
      'HinhAnh': hinhAnh,
    };
  }
}
