import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiUrl = 'https://your-api-endpoint.com/products'; // Replace with your actual API URL

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> productsData = jsonDecode(response.body);

    for (final product in productsData) {
      print('Product Name: ${product['name']}');
      print('Brand: ${product['brand']}');       
    }
  } else {
    // Handle errors here
    print('Failed to fetch products: ${response.statusCode}');
  }
}
