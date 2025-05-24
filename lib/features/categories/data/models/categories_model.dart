class CategoriesModel {
  final String icon;
  final String name;
  final String slug;

  CategoriesModel({required this.slug, required this.icon, required this.name});
  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        icon: json["icon"],
        name: json["name"],
        slug: json["slug"],
      );
}
