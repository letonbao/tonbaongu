// // ===========Cái này hình ảnh thì để link================== 
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// import 'package:flutter/material.dart';
// import '../../models/product_model.dart';

// class AddEditProductScreen extends StatefulWidget {
//   final Product? product;

//   const AddEditProductScreen({super.key, this.product});

//   @override
//   State<AddEditProductScreen> createState() => _AddEditProductScreenState();
// }

// class _AddEditProductScreenState extends State<AddEditProductScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController idController;
//   late TextEditingController nameController;
//   late TextEditingController descriptionController;
//   late TextEditingController priceController;
//   late TextEditingController stockController;
//   late TextEditingController statusController;
//   late TextEditingController colorController;
//   late TextEditingController sizeController;
//   late TextEditingController imageController;

//   @override
//   void initState() {
//     super.initState();
//     idController = TextEditingController(text: widget.product?.id ?? '');
//     nameController = TextEditingController(text: widget.product?.name ?? '');
//     descriptionController = TextEditingController(text: widget.product?.description ?? '');
//     priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
//     stockController = TextEditingController(text: widget.product?.stock.toString() ?? '');
//     statusController = TextEditingController(text: widget.product?.status ?? '');
//     colorController = TextEditingController(text: widget.product?.color ?? '');
//     sizeController = TextEditingController(text: widget.product?.size ?? '');
//     imageController = TextEditingController(text: widget.product?.image ?? '');
//   }

//   @override
//   void dispose() {
//     idController.dispose();
//     nameController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     stockController.dispose();
//     statusController.dispose();
//     colorController.dispose();
//     sizeController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   void _saveProduct() {
//     if (_formKey.currentState!.validate()) {
//       final newProduct = Product(
//         id: idController.text,
//         name: nameController.text,
//         description: descriptionController.text,
//         price: double.tryParse(priceController.text) ?? 0.0,
//         stock: int.tryParse(stockController.text) ?? 0,
//         status: statusController.text,
//         color: colorController.text,
//         size: sizeController.text,
//         image: imageController.text,
//       );

//       // TODO: Gửi API thêm hoặc cập nhật product
//       print("Lưu sản phẩm: ${newProduct.toJson()}");

//       Navigator.pop(context, newProduct);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product == null ? "Thêm sản phẩm" : "Sửa sản phẩm"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildTextField(idController, "Mã sản phẩm"),
//               _buildTextField(nameController, "Tên sản phẩm"),
//               _buildTextField(descriptionController, "Mô tả"),
//               _buildTextField(priceController, "Giá", keyboardType: TextInputType.number),
//               _buildTextField(stockController, "Tồn kho", keyboardType: TextInputType.number),
//               _buildTextField(statusController, "Trạng thái"),
//               _buildTextField(colorController, "Màu sắc"),
//               _buildTextField(sizeController, "Kích cỡ"),
//               _buildTextField(imageController, "Link hình ảnh"),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProduct,
//                 child: const Text("Lưu"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {TextInputType keyboardType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(labelText: label),
//         keyboardType: keyboardType,
//         validator: (value) => value!.isEmpty ? "Không được để trống" : null,
//       ),
//     );
//   }
// }


// =========== Cái này hình ảnh thì upload file , nhưng mà nó đéo hỗ trợ trên Web ================== 
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../models/product_model.dart';

// class AddEditProductScreen extends StatefulWidget {
//   final Product? product;

//   const AddEditProductScreen({super.key, this.product});

//   @override
//   State<AddEditProductScreen> createState() => _AddEditProductScreenState();
// }

// class _AddEditProductScreenState extends State<AddEditProductScreen> {
//   final _formKey = GlobalKey<FormState>();

//   late TextEditingController idController;
//   late TextEditingController nameController;
//   late TextEditingController descriptionController;
//   late TextEditingController priceController;
//   late TextEditingController stockController;
//   late TextEditingController statusController;
//   late TextEditingController colorController;
//   late TextEditingController sizeController;
//   late TextEditingController imageController;

//   File? _pickedImage;

//   @override
//   void initState() {
//     super.initState();
//     idController = TextEditingController(text: widget.product?.id ?? '');
//     nameController = TextEditingController(text: widget.product?.name ?? '');
//     descriptionController = TextEditingController(text: widget.product?.description ?? '');
//     priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
//     stockController = TextEditingController(text: widget.product?.stock.toString() ?? '');
//     statusController = TextEditingController(text: widget.product?.status ?? '');
//     colorController = TextEditingController(text: widget.product?.color ?? '');
//     sizeController = TextEditingController(text: widget.product?.size ?? '');
//     imageController = TextEditingController(text: widget.product?.image ?? '');
//   }

//   @override
//   void dispose() {
//     idController.dispose();
//     nameController.dispose();
//     descriptionController.dispose();
//     priceController.dispose();
//     stockController.dispose();
//     statusController.dispose();
//     colorController.dispose();
//     sizeController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _pickedImage = File(pickedFile.path);
//         imageController.text = pickedFile.path; // tạm lưu đường dẫn ảnh
//       });
//     }
//   }

//   void _saveProduct() {
//     if (_formKey.currentState!.validate()) {
//       final newProduct = Product(
//         id: idController.text,
//         name: nameController.text,
//         description: descriptionController.text,
//         price: double.tryParse(priceController.text) ?? 0.0,
//         stock: int.tryParse(stockController.text) ?? 0,
//         status: statusController.text,
//         color: colorController.text,
//         size: sizeController.text,
//         image: imageController.text,
//       );

//       // TODO: Gửi API thêm hoặc cập nhật product
//       print("Lưu sản phẩm: ${newProduct.toJson()}");

//       Navigator.pop(context, newProduct);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.product == null ? "Thêm sản phẩm" : "Sửa sản phẩm"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildTextField(idController, "Mã sản phẩm"),
//               _buildTextField(nameController, "Tên sản phẩm"),
//               _buildTextField(descriptionController, "Mô tả"),
//               _buildTextField(priceController, "Giá", keyboardType: TextInputType.number),
//               _buildTextField(stockController, "Tồn kho", keyboardType: TextInputType.number),
//               _buildTextField(statusController, "Trạng thái"),
//               _buildTextField(colorController, "Màu sắc"),
//               _buildTextField(sizeController, "Kích cỡ"),
//               const SizedBox(height: 12),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text("Hình ảnh sản phẩm", style: TextStyle(fontSize: 16)),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         ElevatedButton.icon(
//                           onPressed: _pickImage,
//                           icon: const Icon(Icons.upload_file),
//                           label: const Text("Chọn ảnh"),
//                         ),
//                         const SizedBox(width: 12),
//                         _pickedImage != null
//                             ? Image.file(
//                                 _pickedImage!,
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.cover,
//                               )
//                             : imageController.text.isNotEmpty
//                                 ? Image.file(
//                                     File(imageController.text),
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Text("Chưa chọn ảnh"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveProduct,
//                 child: const Text("Lưu"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {TextInputType keyboardType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(labelText: label),
//         keyboardType: keyboardType,
//         validator: (value) => value!.isEmpty ? "Không được để trống" : null,
//       ),
//     );
//   }
// }


// ========== Cấu trúc JSON giống User =================
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController maSanPhamController;
  late TextEditingController tenSanPhamController;
  late TextEditingController motaController;
  late TextEditingController giaController;
  late TextEditingController soLuongTonKhoController;
  late TextEditingController trangThaiController;
  late TextEditingController mauSacController;
  late TextEditingController kichCoController;
  late TextEditingController hinhAnhController;

  @override
  void initState() {
    super.initState();
    maSanPhamController = TextEditingController(text: widget.product?.maSanPham ?? '');
    tenSanPhamController = TextEditingController(text: widget.product?.tenSanPham ?? '');
    motaController = TextEditingController(text: widget.product?.mota ?? '');
    giaController = TextEditingController(text: widget.product?.gia.toString() ?? '');
    soLuongTonKhoController = TextEditingController(text: widget.product?.soLuongTonKho.toString() ?? '');
    trangThaiController = TextEditingController(text: widget.product?.trangThai ?? '');
    mauSacController = TextEditingController(text: widget.product?.mauSac ?? '');
    kichCoController = TextEditingController(text: widget.product?.kichCo ?? '');
    hinhAnhController = TextEditingController(text: widget.product?.hinhAnh ?? '');
  }

  @override
  void dispose() {
    maSanPhamController.dispose();
    tenSanPhamController.dispose();
    motaController.dispose();
    giaController.dispose();
    soLuongTonKhoController.dispose();
    trangThaiController.dispose();
    mauSacController.dispose();
    kichCoController.dispose();
    hinhAnhController.dispose();
    super.dispose();
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        maSanPham: widget.product?.maSanPham ?? '',
        tenSanPham: tenSanPhamController.text,
        mota: motaController.text,
        gia: double.tryParse(giaController.text) ?? 0.0,
        soLuongTonKho: int.tryParse(soLuongTonKhoController.text) ?? 0,
        trangThai: trangThaiController.text,
        mauSac: mauSacController.text,
        kichCo: kichCoController.text,
        hinhAnh: hinhAnhController.text,
      );

      String url;
      Map<String, dynamic> body;

      if (widget.product == null) {
        url = 'http://localhost/MyProject/backendapi/products/add_product.php';
        body = newProduct.toJson();
      } else {
        url = 'http://localhost/MyProject/backendapi/products/update_product.php';
        body = newProduct.toJson();
      }

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body),
        );

        final data = json.decode(response.body);
        if (data['success'] == true) {
          Navigator.pop(context, newProduct);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? "Thêm sản phẩm" : "Sửa sản phẩm"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.product != null)
                _buildTextField(maSanPhamController, "Mã sản phẩm", enabled: false),
              _buildTextField(tenSanPhamController, "Tên sản phẩm"),
              _buildTextField(motaController, "Mô tả"),
              _buildTextField(giaController, "Giá", keyboardType: TextInputType.number),
              _buildTextField(soLuongTonKhoController, "Tồn kho", keyboardType: TextInputType.number),
              _buildTextField(trangThaiController, "Trạng thái"),
              _buildTextField(mauSacController, "Màu sắc"),
              _buildTextField(kichCoController, "Kích cỡ"),
              _buildTextField(hinhAnhController, "Link hình ảnh"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text("Lưu"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        enabled: enabled,
        validator: (value) => value!.isEmpty ? "Không được để trống" : null,
      ),
    );
  }
}

