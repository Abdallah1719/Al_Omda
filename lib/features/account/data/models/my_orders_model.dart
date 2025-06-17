class MyOrdersModel {
  final int id;
  final String status;
  final String date;
  MyOrdersModel({required this.id, required this.status, required this.date});

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) {
    return MyOrdersModel(
      id: json["id"],
      status: json["status"],
      date: json["date"],
    );
  }
}
