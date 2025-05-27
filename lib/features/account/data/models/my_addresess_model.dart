class MyAddresessModel {
  final String city;
  final String street;
  MyAddresessModel({required this.city, required this.street});

  factory MyAddresessModel.fromJson(Map<String, dynamic> json) {
    return MyAddresessModel(city: json["city"], street: json["street"]);
  }
}

class MyAddresessList {
  final List<MyAddresessModel> addresses;

  MyAddresessList({required this.addresses});

  factory MyAddresessList.fromJson(List<dynamic> jsonList) {
    List<MyAddresessModel> addresses =
        jsonList
            .map(
              (item) => MyAddresessModel.fromJson(item as Map<String, dynamic>),
            )
            .toList();

    return MyAddresessList(addresses: addresses);
  }
}
