import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
static const String baseUrl = 'http://localhost/MyProject/backendapi';


  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'Email': email,
          'MatKhau': password,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Lỗi kết nối server: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/add_user.php'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'Ten': name,
          'Email': email,
          'MatKhau': password,
          'SoDienThoai': phone,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Lỗi kết nối server: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/get_products.php'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Lỗi kết nối server: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi kết nối 111: $e',
      };
    }
  }
} 