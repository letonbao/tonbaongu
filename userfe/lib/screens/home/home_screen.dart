import 'dart:math' as console;

import 'package:flutter/material.dart';
import 'package:userfe/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

qclass _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> productsDetail = [];
  bool isLoading = true;
  Map<String, dynamic>? currentUser;
  Map<int, String?> selectedColors = {};
  Map<int, String?> selectedSizes = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
    // You can store user data in shared preferences or state management
    // For now, we'll simulate user data
    currentUser = {
      'Ten': 'Người dùng',
      'Email': 'user@example.com',
    };
  }

  Future<void> _loadProducts() async {
    try {
      final result = await AuthService.getProducts();
      final detailResult = await AuthService.getProductsDetail();
      
      if (result['success'] == 200 && detailResult['success'] == 200) {
        setState(() {
          products = List<Map<String, dynamic>>.from(result['data'] ?? []);
          productsDetail = List<Map<String, dynamic>>.from(detailResult['data'] ?? []);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? detailResult['message'] ?? 'Lỗi tải sản phẩm'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Đăng xuất'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );
  }

  // Add method to get product details by MaSanPham
  List<Map<String, dynamic>> _getProductDetails(String maSanPham) {
    return productsDetail.where((detail) => detail['MaSanPham'] == maSanPham).toList();
  }

  // Add method to calculate price based on color and size
  double _calculatePrice(Map<String, dynamic> product, int index) {
    // Get product details for this specific product
    List<Map<String, dynamic>> details = _getProductDetails(product['MaSanPham'] ?? '');
    
    // Find the specific detail based on selected color and size
    Map<String, dynamic>? selectedDetail;
    String? selectedColor = selectedColors[index];
    String? selectedSize = selectedSizes[index];
    
    if (selectedColor != null && selectedSize != null) {
      selectedDetail = details.firstWhere(
        (detail) => 
          detail['MauSac']?.toString().toLowerCase().contains(selectedColor.toLowerCase()) == true &&
          detail['KichCo']?.toString().toLowerCase().contains(selectedSize.toLowerCase()) == true,
        orElse: () => details.isNotEmpty ? details.first : {},
      );
    } else if (details.isNotEmpty) {
      selectedDetail = details.first;
    }
    
    // Use price from detail if available, otherwise use base product price
    double basePrice = 0.0;
    try {
      if (selectedDetail != null && selectedDetail['Gia'] != null) {
        if (selectedDetail['Gia'] is int) {
          basePrice = (selectedDetail['Gia'] as int).toDouble();
        } else if (selectedDetail['Gia'] is double) {
          basePrice = selectedDetail['Gia'] as double;
        } else if (selectedDetail['Gia'] is String) {
          basePrice = double.tryParse(selectedDetail['Gia'] as String) ?? 0.0;
        }
      } else if (product['Gia'] != null) {
        if (product['Gia'] is int) {
          basePrice = (product['Gia'] as int).toDouble();
        } else if (product['Gia'] is double) {
          basePrice = product['Gia'] as double;
        } else if (product['Gia'] is String) {
          basePrice = double.tryParse(product['Gia'] as String) ?? 0.0;
        }
      }
    } catch (e) {
      basePrice = 0.0;
    }
    
    return basePrice;
  }

  // Format price with thousand separators
  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tính năng giỏ hàng đang phát triển'),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.person),
            onSelected: (value) {
              if (value == 'profile') {
                // Navigate to profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tính năng hồ sơ đang phát triển'),
                  ),
                );
              } else if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text('Hồ sơ: ${currentUser?['Ten'] ?? 'User'}'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Đăng xuất'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _loadProducts,
              child: Column(
                children: [
                  // Welcome Message
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.waving_hand, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Chào mừng ${currentUser?['Ten'] ?? 'bạn'}!',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Products Grid
                  Expanded(
                    child: products.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inventory_2,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Không có sản phẩm nào',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: product['HinhAnh'] != null
                                            ? ClipRRect(
                                                borderRadius: const BorderRadius.vertical(
                                                  top: Radius.circular(12),
                                                ),
                                                child: Image.network(
                                                  product['HinhAnh'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return const Icon(
                                                      Icons.image,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    );
                                                  },
                                                ),
                                              )
                                            : const Icon(
                                                Icons.image,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                      ),
                                    ),
                                    
                                    // Product Info
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product['TenSanPham'] ?? 'Tên sản phẩm',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),

                                            // Price display with original and adjusted prices
                                            Builder(
                                              builder: (context) {
                                                // Get product details for this specific product
                                                List<Map<String, dynamic>> details = _getProductDetails(product['MaSanPham'] ?? '');
                                                
                                                // Safely convert price to double with proper error handling
                                                double basePrice = 0.0;
                                                try {
                                                  if (details.isNotEmpty && details.first['Gia'] != null) {
                                                    if (details.first['Gia'] is int) {
                                                      basePrice = (details.first['Gia'] as int).toDouble();
                                                    } else if (details.first['Gia'] is double) {
                                                      basePrice = details.first['Gia'] as double;
                                                    } else if (details.first['Gia'] is String) {
                                                      basePrice = double.tryParse(details.first['Gia'] as String) ?? 0.0;
                                                    }
                                                  } else if (product['Gia'] != null) {
                                                    if (product['Gia'] is int) {
                                                      basePrice = (product['Gia'] as int).toDouble();
                                                    } else if (product['Gia'] is double) {
                                                      basePrice = product['Gia'] as double;
                                                    } else if (product['Gia'] is String) {
                                                      basePrice = double.tryParse(product['Gia'] as String) ?? 0.0;
                                                    }
                                                  }
                                                } catch (e) {
                                                  basePrice = 0.0;
                                                }
                                                
                                                double adjustedPrice = _calculatePrice(product, index);
                                                
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Show original price
                                                    Text(
                                                      '${_formatPrice(basePrice)} VNĐ',
                                                      style: TextStyle(
                                                        color: Colors.grey.shade600,
                                                        fontSize: 12,
                                                        decoration: adjustedPrice > basePrice ? TextDecoration.lineThrough : null,
                                                      ),
                                                    ),
                                                    
                                                    // Show adjusted price if different
                                                    if (adjustedPrice != basePrice)
                                                      Text(
                                                        '${_formatPrice(adjustedPrice)} VNĐ',
                                                        style: TextStyle(
                                                          color: Colors.orange.shade700,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    else
                                                      Text(
                                                        '${_formatPrice(adjustedPrice)} VNĐ',
                                                        style: TextStyle(
                                                          color: Colors.orange.shade700,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 8),

                                            // Color and Size selection dropdowns in the same row
                                            Builder(
                                              builder: (context) {
                                                List<Map<String, dynamic>> details = _getProductDetails(product['MaSanPham'] ?? '');
                                                List<String> availableColors = details.map((detail) => detail['MauSac']?.toString() ?? '').where((color) => color.isNotEmpty).toSet().toList();
                                                List<String> availableSizes = details.map((detail) => detail['KichCo']?.toString() ?? '').where((size) => size.isNotEmpty).toSet().toList();
                                                
                                                return Row(
                                                  children: [
                                                    // Color dropdown
                                                    if (availableColors.isNotEmpty)
                                                      Expanded(
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.shade300),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: DropdownButton<String>(
                                                            value: selectedColors[index],
                                                            hint: const Text('Màu', style: TextStyle(fontSize: 30)),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            icon: const Icon(Icons.arrow_drop_down, size: 16),
                                                            items: availableColors.map((String color) {
                                                              return DropdownMenuItem<String>(
                                                                value: color.trim(),
                                                                child: Text(
                                                                  color.trim(),
                                                                  style: const TextStyle(fontSize: 20),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {
                                                              setState(() {
                                                                selectedColors[index] = newValue;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    
                                                    const SizedBox(width: 8),
                                                    
                                                    // Size dropdown
                                                    if (availableSizes.isNotEmpty)
                                                      Expanded(
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 6),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.grey.shade300),
                                                            borderRadius: BorderRadius.circular(4),
                                                          ),
                                                          child: DropdownButton<String>(
                                                            value: selectedSizes[index],
                                                            hint: const Text('Size', style: TextStyle(fontSize: 30)),
                                                            isExpanded: true,
                                                            underline: Container(),
                                                            icon: const Icon(Icons.arrow_drop_down, size: 16),
                                                            items: availableSizes.map((String size) {
                                                              return DropdownMenuItem<String>(
                                                                value: size.trim(),
                                                                child: Text(
                                                                  size.trim(),
                                                                  style: const TextStyle(fontSize: 20),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {
                                                              setState(() {
                                                                selectedSizes[index] = newValue;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),

                                            const SizedBox(height: 8),

                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Đã thêm ${product['TenSanPham']} vào giỏ hàng'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.orange.shade700,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Thêm vào giỏ',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
} 