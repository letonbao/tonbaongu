import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/product_model.dart';
import '../add_edit_product_screen.dart';

class ProductTable extends StatelessWidget {
  final List<Product> products;
  final Function onReload;

  const ProductTable({Key? key, required this.products, required this.onReload}) : super(key: key);

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xác nhận"),
        content: const Text("Bạn có chắc chắn muốn xóa sản phẩm này?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Hủy")),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Xóa")),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final response = await http.post(
          Uri.parse("http://localhost/MyProject/backendapi/products/delete_product.php"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'MaSanPham': productId}),
        );

        if (response.statusCode == 200) {
          final result = json.decode(response.body);
          if (result['success'] == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Xóa sản phẩm thành công")),
            );
            onReload();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Lỗi: \\${result['message']}")),
            );
          }
        } else {
          throw Exception("Kết nối thất bại");
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi xóa: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Tên sản phẩm')),
          DataColumn(label: Text('Mô tả')),
          DataColumn(label: Text('Giá')),
          DataColumn(label: Text('Tồn kho')),
          DataColumn(label: Text('Trạng thái')),
          DataColumn(label: Text('Màu sắc')),
          DataColumn(label: Text('Kích cỡ')),
          DataColumn(label: Text('Hình ảnh')),
          DataColumn(label: Text('Hành động')),
        ],
        rows: products.map((product) {
          return DataRow(cells: [
            DataCell(Text(product.maSanPham)),
            DataCell(Text(product.tenSanPham)),
            DataCell(Text(product.mota)),
            DataCell(Text(product.gia.toString())),
            DataCell(Text(product.soLuongTonKho.toString())),
            DataCell(Text(product.trangThai)),
            DataCell(Text(product.mauSac)),
            DataCell(Text(product.kichCo)),
            DataCell(
              product.hinhAnh.isNotEmpty
                  ? Image.network(
                      product.hinhAnh.startsWith('http')
                          ? product.hinhAnh
                          : 'http://localhost/MyProject/${product.hinhAnh}',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error))
                  : const SizedBox(width: 40, height: 40),
            ),
            DataCell(
              SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final updatedProduct = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddEditProductScreen(product: product),
                          ),
                        );
                        if (updatedProduct != null) onReload();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProduct(context, product.maSanPham),
                    ),
                  ],
                ),
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}
