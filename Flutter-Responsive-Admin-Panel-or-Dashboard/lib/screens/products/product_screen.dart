// import 'package:flutter/material.dart';
// import 'components/product_table.dart';
// import 'add_edit_product_screen.dart';

// class ProductScreen extends StatelessWidget {
//   const ProductScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   "Sản phẩm",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const Spacer(),
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.add),
//                   label: const Text("Thêm sản phẩm"),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AddEditProductScreen(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Expanded(child: ProductTable()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'add_edit_product_screen.dart';
import 'components/product_table.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/MyProject/backendapi/products/get_products.php')); 
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == 200) {
          final List<Product> loadedProducts = (data['data'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          setState(() {
            products = loadedProducts;
          });
        } else {
          print('Lỗi dữ liệu: \\${data['message']}');
        }
      } else {
        print('Lỗi kết nối API: \\${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi tải sản phẩm: $e');
    }
  }

  void _addProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddEditProductScreen()),
    );
    if (newProduct != null) {
      _loadProducts();
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
              "Danh sách sản phẩm",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text("Thêm sản phẩm"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ProductTable(
              products: products,
              onReload: _loadProducts,
            ),
          ),
        ),
      ],
    );
  }
}
