import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/user_model.dart';
import 'add_edit_user_screen.dart';
import 'components/user_table.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    try {
    final response = await http.get(Uri.parse('http://localhost/MyProject/backendapi/users/get_users.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == 200) {
        final List<User> loadedUsers = (data['data'] as List)
            .map((json) => User.fromJson(json))
            .toList();
        setState(() {
          users = loadedUsers;
        });
      } else {
        print('Lỗi dữ liệu: ${data['message']}');
      }
    } else {
      print('Lỗi kết nối API: ${response.statusCode}');
    }
  } catch (e) {
    print('Lỗi tải người dùng: $e');
  }
  }

  void _addUser() async {
    final newUser = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditUserScreen()),
    );
    if (newUser != null) {
      // TODO: Gửi API thêm user
      print('Thêm người dùng: ${newUser.toJson()}');
      _loadUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Danh sách người dùng",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _addUser,
              child: const Text("Thêm người dùng"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: UserTable(
              users: users,
              onReload: _loadUsers,
            ),
          ),
        ),
      ],
    );
  }
}
