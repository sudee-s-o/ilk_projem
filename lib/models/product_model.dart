class ProductModel {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final double price;
  final String currency;
  final String image;
  final String chip;
  final String material;
  final String camera;

  ProductModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.chip,
    required this.material,
    required this.camera,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final specs = json['specs'] ?? {};

    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      tagline: json['tagline']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price:
          double.tryParse(json['price'].toString().replaceAll('\$', '')) ?? 0.0,
      currency: json['currency']?.toString() ?? '',
      image: json['image']?.toString() ?? '',

      chip: specs['chip']?.toString() ?? '',
      material: specs['material']?.toString() ?? '',
      camera: specs['camera']?.toString() ?? '',
    );
  }
}
