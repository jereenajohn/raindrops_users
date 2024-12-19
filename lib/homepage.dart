import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:raindrops/api.dart';
import 'package:raindrops/product_big_view.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? _userLocation;
  int _selectedIndex = 0;
  late String imageUrl;
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    fetchCategories();
    fetchproducts();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$url/api/category'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<dynamic> categoryData = parsed['data'];
        setState(() {
          categories = categoryData
              .map((category) => {
                    'id': category['_id'],
                    'name': category['name'],
                    'image': "$url/${category['image']}",
                    'slug': category['slug'],
                  })
              .toList();
        });
      }
    } catch (error) {
      print("Error fetching categories: $error");
    }
  }

  Future<void> fetchproducts() async {
    try {
      final response = await http.get(Uri.parse('$url/api/product'));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<dynamic> productData = parsed['data'];
        setState(() {
          products = productData
              .map((product) => {
                    'id': product['_id'],
                    'name': product['name'],
                    'image': "$url/${product['image']}",
                    'slug': product['slug'],
                    'price': product['price'],
                    'saleprice': product['sale_price'],
                    'discount': product['discount'],
                  })
              .toList();
        });
      }
    } catch (error) {
      print("Error fetching products: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Container
            Container(
              height: 180,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rain Drops',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.white, size: 15),
                            SizedBox(width: 8),
                            Text(
                              _userLocation ?? 'Enable Location',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories Grid
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop Popular Categories',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(25.0), // Rounded corners
                        child: Image.network(
                          categories[index]['image'],
                          height: 60.0,
                          width: 60.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 40.0,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      categories[index]['name'],
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),

            // Horizontal Products Section
            SizedBox(height: 16.0),
            // Products Grid (Horizontal Scroll)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              height: 250, // Set a fixed height for horizontal scroll
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Product_Big_view(id:products[index]['slug'])));

                    },
                    child: Container(
                      width: 180, // Set card width
                      margin: EdgeInsets.only(
                          right: 12.0), // Add spacing between items
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                                child: Image.network(
                                  products[index]['image'] ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      width: double.infinity,
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey[500],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    products[index]['name'] ?? 'No Name',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$${products[index]['saleprice'] ?? 'N/A'}',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String address = placemarks.first.subLocality ?? 'Unknown location';
    updateLocation(address);
  }

  void updateLocation(String location) {
    setState(() {
      _userLocation = location;
    });
  }
}
