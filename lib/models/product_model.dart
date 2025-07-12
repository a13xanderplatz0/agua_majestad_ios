class ProductModel {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String image;
  final int color;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.image,
    required this.color,
    this.quantity = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
} 