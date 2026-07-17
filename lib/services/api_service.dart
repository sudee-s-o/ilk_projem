import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ilk_projem/models/product_model.dart';

class ApiService {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://wantapi.com/products.php'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List list = jsonData['data'];
      return list
          .map((productNew) => ProductModel.fromJson(productNew))
          .toList();
    } else {
      throw Exception('product yüklenemedi');
    }
  }
}
