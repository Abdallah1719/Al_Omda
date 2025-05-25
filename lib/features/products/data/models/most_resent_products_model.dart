class MostRecentProductsModel {
  final String title;
  final int price;
  final String image;
  final String weight;
  final String unitName;

  factory MostRecentProductsModel.fromJson(Map<String, dynamic> json) =>
      MostRecentProductsModel(
        title: json["title"] ?? '',
        image: json["image"] ?? '',
        price: json['price'] ?? 0.0,
        unitName: json["unit_name"] ?? 'Unknown',
        weight: json["weight"],
      );

  MostRecentProductsModel({
    required this.title,
    required this.price,
    required this.image,
    required this.weight,
    required this.unitName,
  });
}
