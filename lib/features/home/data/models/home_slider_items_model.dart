class HomeSliderItemsModel {
  final String image;
  HomeSliderItemsModel({required this.image});

  factory HomeSliderItemsModel.fromJson(Map<String, dynamic> json) =>
      HomeSliderItemsModel(image: json["image"]);
}
