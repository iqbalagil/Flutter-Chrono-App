import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:flutter_application_akhir/firebase_options.dart';
import 'package:flutter_application_akhir/app/mainapp/product_card.dart';


class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final String userName = 'Iqbal';
  String selectedCategory = 'all';

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  List<String> imageUrls = [];
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeFirebase().then((_) {
      fetchImageUrls();
    });
  }

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('Firebase initialization error: $e');
    }
  }

  Future<void> fetchImageUrls() async {
    try {
      final firebase_storage.ListResult result =
          await storage.ref().child('product_imgaes').listAll(); // Use the correct path
      final futures = result.items.map((ref) async {
        final url = await ref.getDownloadURL();
        return url;
      });
      imageUrls = await Future.wait(futures);
      _initializeProductData();
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }

  void _initializeProductData() {
    products = imageUrls.map((imageUrl) {
      // Generate dummy product data
      return {
        'name': 'Blue Eyed',
        'category': 'Rolex',
        'priceRange': r'$300 - $500',
        'description': 'This is a sample product description.',
        'image_url': imageUrl,
      };
    }).toList();

    setState(() {
      isLoading = false; 
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              // Profile Header
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder image
                ),
                title: Text('Welcome back, $userName!', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: const Text('Explore our latest collection!'),
              ),
              SizedBox(height: 30),

              // Image Carousel
              CarouselSlider(
                items: imageUrls.map((url) => 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                  )
                ).toList(),
                options: CarouselOptions(height: 200, enlargeCenterPage: true, autoPlay: true),
              ),
              SizedBox(height: 30),

              // Category Buttons
              Text('Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryButton('All'),
                    _buildCategoryButton('Rolex'),
                    _buildCategoryButton('Patek Philippe'),
                    _buildCategoryButton('Omega'),
                  ],
                ),
              ),

GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        if (selectedCategory == 'all' || product['category'] == selectedCategory) {
                          return ProductCard(
                            imageUrl: product['image_url'],
                            productName: product['name'],
                            priceRange: product['priceRange'],
                            description: product['description'],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

Widget _buildCategoryButton(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: selectedCategory == label.toLowerCase() ? TColor.primaryColor1 : Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(label, style: TextStyle(
          color: selectedCategory == label.toLowerCase() ? Colors.white : Colors.black
        ),
      ),
    );
  }
}
