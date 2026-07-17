import 'package:flutter/material.dart';
import 'package:ilk_projem/components/product_tile.dart';
import 'package:ilk_projem/services/api_service.dart';
import 'package:ilk_projem/models/product_model.dart';
import 'package:ilk_projem/views/cart_screen.dart';
import 'package:ilk_projem/views/product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ApiService apiService = ApiService();
  List<ProductModel> allproducts = [];
  bool isLoading = false;
  String errorMessage = '';
  Set<int> cardIds = {};

  Future<void> loadProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final products = await apiService.fetchProducts();
      debugPrint("Ürün sayısı: ${products.length}");

      setState(() {
        allproducts = products;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("HATA: $e");

      setState(() {
        errorMessage = 'Ürünler yüklenemedi: $e';
        isLoading = false;
      });
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(
                            products: allproducts,
                            cardIds: cardIds,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                    iconSize: 32,
                  ),
                ],
              ),

              const Text(
                'Find your perfect device',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16.0),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  filled: true,
                  fillColor: Colors.grey.shade100,

                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/image/gift_store.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 12),

              Expanded(
                child: GridView.builder(
                  itemCount: allproducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 sütun
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    final product = allproducts[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: product,
                              cardIds: cardIds,
                            ),
                          ),
                        );
                      },

                      child: ProductTile(product: product, cardIds: cardIds),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
