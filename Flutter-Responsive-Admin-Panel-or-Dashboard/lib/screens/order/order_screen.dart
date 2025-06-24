import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/order_model.dart';
import 'add_edit_order_screen.dart';
import 'components/order_table.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [];

  Future<void> _loadOrders() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/MyProject/backendapi/orders/get_orders.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<Order> loadedOrders = (data['data'] as List)
              .map((item) => Order.fromJson(item))
              .toList();
          setState(() {
            orders = loadedOrders;
          });
        } else {
          print("Lỗi: ${data['message']}");
        }
      } else {
        print("Lỗi kết nối API: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi load đơn hàng: $e");
    }
  }

  void _addOrder() async {
    final newOrder = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditOrderScreen()),
    );
    if (newOrder != null) {
      _loadOrders();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Danh sách đơn hàng", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(onPressed: _addOrder, child: const Text("Thêm đơn hàng")),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: OrderTable(orders: orders, onReload: _loadOrders),
        ),
      ],
    );
  }
}
