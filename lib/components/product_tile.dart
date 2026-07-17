import 'package:flutter/material.dart';
import 'package:ilk_projem/models/product_model.dart';
import 'package:ilk_projem/views/product_detail_screen.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final Set<int> cardIds;

  const ProductTile({super.key, required this.product, required this.cardIds});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductDetailScreen(product: product, cardIds: cardIds),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: product.id ?? 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: Image.network(
                    product.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 1),

                  Text(
                    product.tagline,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),

                  Text(
                    "\$${product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
