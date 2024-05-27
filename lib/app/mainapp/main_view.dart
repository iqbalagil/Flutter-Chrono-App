import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_akhir/common/color_common.dart';
import 'package:flutter_application_akhir/firebase_options.dart';
import 'package:flutter_application_akhir/app/mainapp/product_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

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
      downloadFilesInDirectory('product_imgaes').then((_) {
        fetchImageUrls();
      });
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
          await storage.ref().child('product_imgaes').listAll();
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

  Future<void> downloadFilesInDirectory(String directoryPath) async {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    try {
      final firebase_storage.ListResult result =
          await storage.ref().child(directoryPath).listAll();

      for (final firebase_storage.Reference ref in result.items) {
        if (ref.fullPath != null) {
          final url = await ref.getDownloadURL();
          print('Downloading file from $url');
          // Perform the download operation here
          // For example, you can use http package to download the file
        }
      }
    } catch (e) {
      print('Error downloading files: $e');
    }
  }

  void _initializeProductData() {
    products = imageUrls.asMap().entries.map((entry) {
      final index = entry.key;
      final imageUrl = entry.value;
      final categories = ['Rolex', 'Patek Philippe', 'Omega'];
      return {
        'name': 'Product ${index + 1}',
        'category': categories[index % categories.length],
        'priceRange': r'$300 - $500',
        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
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
                    ListTile(
                      leading: const CircleAvatar(),
                      title: Text(
                        'Welcome back, $userName!',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Explore our latest collection!'),
                    ),
                    const SizedBox(height: 30),
                    CarouselSlider(
                      items: imageUrls.map((url) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                            width: 1000.0,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
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
                        if (selectedCategory == 'all' || product['category'].toLowerCase() == selectedCategory.toLowerCase()) {
                          return ProductCard(
                            imagePath: product['image_url'],
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
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label.toLowerCase();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selectedCategory == label.toLowerCase() ? TColor.primaryColor1 : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedCategory == label.toLowerCase() ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
