class MyAddresessModel {
  final String city;
  final int id;
  final String street;
  MyAddresessModel({required this.city, required this.street,required this.id, });
  factory MyAddresessModel.fromJson(Map<String, dynamic> json) {
    return MyAddresessModel(city: json["city"], street: json["street"], id: json["id"]);
  }
}
