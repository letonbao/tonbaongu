class User {
  final String maND;
  final String ten;
  final String matKhau;
  final String soDienThoai;
  final String email;

  User({
    required this.maND,
    required this.ten,
    required this.matKhau,
    required this.soDienThoai,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      maND: json['MaND'].toString(),
      ten: json['Ten'],
      matKhau: json['MatKhau'],
      soDienThoai: json['SoDienThoai'],
      email: json['Email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaND': maND,
      'Ten': ten,
      'MatKhau': matKhau,
      'SoDienThoai': soDienThoai,
      'Email': email,
    };
  }
}
