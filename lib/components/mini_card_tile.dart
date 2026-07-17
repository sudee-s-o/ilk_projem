import 'package:flutter/material.dart';

class MiniCardTile extends StatelessWidget {
  final String name;
  final String tagline;
  final double price;
  final String image;
  final VoidCallback? onRemove;

  const MiniCardTile({
    super.key,
    required this.name,
    required this.tagline,
    required this.price,
    required this.image,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(8),
              image: image.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            child: image.isEmpty
                ? const Icon(Icons.image, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  tagline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '\$${price.toInt()}',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.grey,
                  onPressed: onRemove,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
