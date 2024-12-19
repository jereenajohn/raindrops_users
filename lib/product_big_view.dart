import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raindrops/api.dart';

class Product_Big_view extends StatefulWidget {
  final String id;

  const Product_Big_view({super.key, required this.id});

  @override
  State<Product_Big_view> createState() => _Product_Big_viewState();
}

class _Product_Big_viewState extends State<Product_Big_view> {
  Map<String, dynamic>? product;

  @override
  void initState() {
    super.initState();
    print("Product ID: ${widget.id}");
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      final response = await http.get(Uri.parse('$url/api/product/${widget.id}'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final productData = parsed['data'];
        setState(() {
          product = {
            'id': productData['_id'],
            'name': productData['name'],
            'image': "$url/${productData['image']}",
            'slug': productData['slug'],
            'price': productData['price'],
            'saleprice': productData['sale_price'],
            'discount': productData['discount'],
            'description': productData['description'],
          };
        });

        print("=====================$product");
      }
    } catch (error) {
      print("Error fetching product: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: product == null
          ? const Center(child: CircularProgressIndicator()) // Loading state
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product Image
                  // Image.network(
                  //                "${product?['image']}",
                  //                 width: double.infinity,
                  //                 fit: BoxFit.cover,
                  //                 errorBuilder: (context, error, stackTrace) {
                  //                   return Container(
                  //                     color: Colors.grey[200],
                  //                     width: double.infinity,
                  //                     child: Icon(
                  //                       Icons.broken_image,
                  //                       size: 50,
                  //                       color: Colors.grey[500],
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  const SizedBox(height: 16),
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!['name'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "Price: \$${product!['price']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Sale Price: \$${product!['saleprice']}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Discount: ${product!['discount']}%",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Description:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product!['description'],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
