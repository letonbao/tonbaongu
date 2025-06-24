import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEditUserScreen extends StatefulWidget {
  final User? user;

  const AddEditUserScreen({super.key, this.user});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController maNDController;
  late TextEditingController tenController;
  late TextEditingController matKhauController;
  late TextEditingController sdtController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    maNDController = TextEditingController(text: widget.user?.maND ?? '');
    tenController = TextEditingController(text: widget.user?.ten ?? '');
    matKhauController = TextEditingController(text: widget.user?.matKhau ?? '');
    sdtController = TextEditingController(text: widget.user?.soDienThoai ?? '');
    emailController = TextEditingController(text: widget.user?.email ?? '');
  }

  @override
  void dispose() {
    maNDController.dispose();
    tenController.dispose();
    matKhauController.dispose();
    sdtController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        maND: maNDController.text,
        ten: tenController.text,
        matKhau: matKhauController.text,
        soDienThoai: sdtController.text,
        email: emailController.text,
      );
      String url;
      Map<String, dynamic> body;
      if (widget.user == null) {
        url = 'http://localhost/MyProject/backendapi/users/add_user.php';
        body = {
          'Ten': newUser.ten,
          'MatKhau': newUser.matKhau,
          'SoDienThoai': newUser.soDienThoai,
          'Email': newUser.email,
        };
      } else {
        url = 'http://localhost/MyProject/backendapi/users/update_user.php';
        body = {
          'MaND': newUser.maND,
          'Ten': newUser.ten,
          'MatKhau': newUser.matKhau,
          'SoDienThoai': newUser.soDienThoai,
          'Email': newUser.email,
        };
      }
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        );
        final data = json.decode(response.body);
        if (data['success'] == true) {
          Navigator.pop(context, newUser);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${data['message']}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi kết nối: $e')),
        );
      }
    }
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) => value!.isEmpty ? "Không được để trống" : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Thêm người dùng" : "Sửa người dùng"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(maNDController, "Mã người dùng"),
              _buildTextField(tenController, "Tên"),
              _buildTextField(matKhauController, "Mật khẩu"),
              _buildTextField(sdtController, "Số điện thoại"),
              _buildTextField(emailController, "Email"),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveUser, child: const Text("Lưu")),
            ],
          ),
        ),
      ),
    );
  }
}
