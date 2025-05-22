class CategoriesModel {
  final String icon;
  final String name;

  CategoriesModel({required this.icon, required this.name});
  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(icon: json["icon"], name: json["name"]);
}
