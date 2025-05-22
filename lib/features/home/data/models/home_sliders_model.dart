class HomeSlidersModel {
  final String image;
  HomeSlidersModel({required this.image});

  factory HomeSlidersModel.fromJson(Map<String, dynamic> json) =>
      HomeSlidersModel(image: json["image"]);
}
