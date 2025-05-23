class ProductsTopRatedModel {
  final String title;
  final String price;
  final String image;
  final String weight;
  final String unitName;

  ProductsTopRatedModel({
    required this.title,
    required this.price,
    required this.image,
    required this.weight,
    required this.unitName,
  });

  factory ProductsTopRatedModel.fromJson(Map<String, dynamic> json) =>
      ProductsTopRatedModel(
        title: json["title"]? '',
        image: json["image"] ?? '',
        price: json['price'] ?? 0.0,
        unitName: json["unit_name"] ?? 'Unknown',
        weight: json["weight"],
      );
}
