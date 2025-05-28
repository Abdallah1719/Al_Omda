class HomeCategoriesModel {
  final String icon;
  final String name;
  final String slug;

  HomeCategoriesModel({
    required this.slug,
    required this.icon,
    required this.name,
  });
  factory HomeCategoriesModel.fromJson(Map<String, dynamic> json) =>
      HomeCategoriesModel(
        icon: json["icon"],
        name: json["name"],
        slug: json["slug"],
      );
}
