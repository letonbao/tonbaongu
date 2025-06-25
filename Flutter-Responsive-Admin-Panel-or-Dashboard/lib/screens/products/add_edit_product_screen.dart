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
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/product_model.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController statusController;
  late TextEditingController colorController;
  late TextEditingController sizeController;

  Uint8List? _pickedImageBytes;
  String? _pickedImageName;
  String? _uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.product?.maSanPham ?? '');
    nameController = TextEditingController(text: widget.product?.tenSanPham ?? '');
    descriptionController = TextEditingController(text: widget.product?.mota ?? '');
    priceController = TextEditingController(text: widget.product?.gia.toString() ?? '');
    stockController = TextEditingController(text: widget.product?.soLuongTonKho.toString() ?? '');
    statusController = TextEditingController(text: widget.product?.trangThai ?? '');
    colorController = TextEditingController(text: widget.product?.mauSac ?? '');
    sizeController = TextEditingController(text: widget.product?.kichCo ?? '');
    _uploadedImageUrl = widget.product?.hinhAnh;
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    stockController.dispose();
    statusController.dispose();
    colorController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedImageBytes = result.files.single.bytes;
        _pickedImageName = result.files.single.name;
      });
      await _uploadImage(_pickedImageBytes!, _pickedImageName!);
    }
  }

  Future<void> _uploadImage(Uint8List imageBytes, String fileName) async {
    final uri = Uri.parse('http://localhost/MyProject/backendapi/products/upload_image.php');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: fileName));
    var response = await request.send();
    if (!mounted) return;
    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final data = json.decode(respStr);
      if (data['success'] == 1) {
        if (!mounted) return;
        setState(() {
          _uploadedImageUrl = data['url'];
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi upload ảnh: ${data['message']}')),
        );
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lỗi upload ảnh!')),
      );
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        maSanPham: idController.text,
        tenSanPham: nameController.text,
        mota: descriptionController.text,
        gia: double.tryParse(priceController.text) ?? 0.0,
        soLuongTonKho: int.tryParse(stockController.text) ?? 0,
        trangThai: statusController.text,
        mauSac: colorController.text,
        kichCo: sizeController.text,
        hinhAnh: _uploadedImageUrl ?? '',
      );
      Navigator.pop(context, newProduct);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? "Không được để trống" : null,
      ),
    );
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
              _buildTextField(idController, "Mã sản phẩm"),
              _buildTextField(nameController, "Tên sản phẩm"),
              _buildTextField(descriptionController, "Mô tả"),
              _buildTextField(priceController, "Giá", keyboardType: TextInputType.number),
              _buildTextField(stockController, "Tồn kho", keyboardType: TextInputType.number),
              _buildTextField(statusController, "Trạng thái"),
              _buildTextField(colorController, "Màu sắc"),
              _buildTextField(sizeController, "Kích cỡ"),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hình ảnh sản phẩm", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Chọn ảnh"),
                        ),
                        const SizedBox(width: 12),
                        _pickedImageBytes != null
                            ? Image.memory(_pickedImageBytes!, width: 60, height: 60, fit: BoxFit.cover)
                            : (_uploadedImageUrl != null && _uploadedImageUrl!.isNotEmpty)
                                ? Image.network('http://localhost/MyProject/${_uploadedImageUrl!}', width: 60, height: 60, fit: BoxFit.cover)
                                : const Text("Chưa chọn ảnh"),
                      ],
                    ),
                  ],
                ),
              ),
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
}

