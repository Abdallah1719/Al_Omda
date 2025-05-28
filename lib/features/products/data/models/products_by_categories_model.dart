class ProductsByCategoriesModel {
  final String title;
  final int price;
  final String image;
  final String weight;
  final String unitName;

  factory ProductsByCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ProductsByCategoriesModel(
        title: json["title"] ?? '',
        image: json["image"] ?? '',
        price: json['price'] ?? 0.0,
        unitName: json["unit_name"] ?? 'Unknown',
        weight: json["weight"],
      );

  ProductsByCategoriesModel({
    required this.title,
    required this.price,
    required this.image,
    required this.weight,
    required this.unitName,
  });
}
