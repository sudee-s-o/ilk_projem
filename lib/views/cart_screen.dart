import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ilk_projem/components/mini_card_tile.dart';
import 'package:ilk_projem/models/product_model.dart';

class CartScreen extends StatefulWidget {
  final List<ProductModel> products;
  final Set<int> cardIds;

  const CartScreen({super.key, required this.products, required this.cardIds});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartproducts = widget.products
        .where((element) => widget.cardIds.contains(element.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart"),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: cartproducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Text("your cart is empty"),
                          SizedBox(height: 10),
                          Text("Add İtems to start shopping"),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: cartproducts.length,
                      itemBuilder: (context, index) {
                        final ProductModel = cartproducts[index];
                        return MiniCardTile(
                          name: ProductModel.name,
                          tagline: ProductModel.tagline,
                          price: ProductModel.price,
                          image: ProductModel.image,
                          onRemove: () {
                            setState(() {
                              widget.cardIds.remove(ProductModel.id);
                            });
                          },
                        );
                      },
                    ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Colors.grey.shade600),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: Text("CheckOut", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
