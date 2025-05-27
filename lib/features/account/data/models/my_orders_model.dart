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

class MyOrdersList {
  final List<MyOrdersModel> orders;

  MyOrdersList({required this.orders});

  factory MyOrdersList.fromJson(List<dynamic> jsonList) {
    List<MyOrdersModel> orders =
        jsonList
            .map((item) => MyOrdersModel.fromJson(item as Map<String, dynamic>))
            .toList();

    return MyOrdersList(orders: orders);
  }
}
