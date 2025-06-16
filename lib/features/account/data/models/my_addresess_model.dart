class MyAddresessModel {
  final String city;
  final String street;
  MyAddresessModel({required this.city, required this.street});
  factory MyAddresessModel.fromJson(Map<String, dynamic> json) {
    return MyAddresessModel(city: json["city"], street: json["street"]);
  }
}
