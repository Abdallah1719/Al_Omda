// // // order_request_model.dart
// // class OrderRequestModel {
// //   final int paymentId;
// //   final String shippingDay;
// //   final String shippingTime;
// //   final int addressId;

// //   OrderRequestModel({
// //     required this.paymentId,
// //     required this.shippingDay,
// //     required this.shippingTime,
// //     required this.addressId,
// //   });

// //   Map<String, dynamic> toJson() {
// //     return {
// //       'payment_id': paymentId,
// //       'shipping_day': shippingDay,
// //       'shipping_time': shippingTime,
// //       'address_id': addressId,
// //     };
// //   }
// // }

// // // order_response_model.dart
// // class OrderResponseModel {
// //   final String message;
// //   final bool success;
// //   final OrderData? data;

// //   OrderResponseModel({required this.message, required this.success, this.data});

// //   factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
// //     return OrderResponseModel(
// //       message: json['message'] ?? '',
// //       success: json['success'] ?? false,
// //       data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
// //     );
// //   }
// // }

// // class OrderData {
// //   final int? orderId;
// //   final String? orderNumber;
// //   final String? status;

// //   OrderData({this.orderId, this.orderNumber, this.status});

// //   factory OrderData.fromJson(Map<String, dynamic> json) {
// //     return OrderData(
// //       orderId: json['order_id'],
// //       orderNumber: json['order_number'],
// //       status: json['status'],
// //     );
// //   }
// // }

// // // order_error_model.dart
// // class OrderErrorModel {
// //   final List<String>? shippingDay;
// //   final List<String>? addressId;
// //   final List<String>? paymentId;
// //   final List<String>? shippingTime;

// //   OrderErrorModel({
// //     this.shippingDay,
// //     this.addressId,
// //     this.paymentId,
// //     this.shippingTime,
// //   });

// //   factory OrderErrorModel.fromJson(Map<String, dynamic> json) {
// //     return OrderErrorModel(
// //       shippingDay: json['shipping_day']?.cast<String>(),
// //       addressId: json['address_id']?.cast<String>(),
// //       paymentId: json['payment_id']?.cast<String>(),
// //       shippingTime: json['shipping_time']?.cast<String>(),
// //     );
// //   }

// //   String get firstError {
// //     if (shippingDay?.isNotEmpty == true) return shippingDay!.first;
// //     if (addressId?.isNotEmpty == true) return addressId!.first;
// //     if (paymentId?.isNotEmpty == true) return paymentId!.first;
// //     if (shippingTime?.isNotEmpty == true) return shippingTime!.first;
// //     return 'Unknown error occurred';
// //   }
// // }
// // order_request_model.dart
// class OrderRequestModel {
//   final int paymentId;
//   final String shippingDay;
//   final String shippingTime;
//   final int addressId;
//   final bool? confirmOrder; // Add this parameter

//   OrderRequestModel({
//     required this.paymentId,
//     required this.shippingDay,
//     required this.shippingTime,
//     required this.addressId,
//     this.confirmOrder, // Optional parameter
//   });

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> json = {
//       'payment_id': paymentId,
//       'shipping_day': shippingDay,
//       'shipping_time': shippingTime,
//       'address_id': addressId,
//     };

//     // Add confirmation parameter if provided
//     if (confirmOrder != null) {
//       json['confirm'] = confirmOrder;
//     }

//     return json;
//   }
// }

// // order_response_model.dart
// class OrderResponseModel {
//   final String message;
//   final bool success;
//   final OrderData? data;
//   final bool? requiresConfirmation; // Add this to handle confirmation requests

//   OrderResponseModel({
//     required this.message,
//     required this.success,
//     this.data,
//     this.requiresConfirmation,
//   });

//   factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
//     return OrderResponseModel(
//       message: json['message'] ?? '',
//       success: json['success'] ?? false,
//       data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
//       requiresConfirmation: json['requires_confirmation'] ?? false,
//     );
//   }
// }

// class OrderData {
//   final int? orderId;
//   final String? orderNumber;
//   final String? status;

//   OrderData({this.orderId, this.orderNumber, this.status});

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'],
//       orderNumber: json['order_number'],
//       status: json['status'],
//     );
//   }
// }

// // order_error_model.dart
// class OrderErrorModel {
//   final List<String>? shippingDay;
//   final List<String>? addressId;
//   final List<String>? paymentId;
//   final List<String>? shippingTime;

//   OrderErrorModel({
//     this.shippingDay,
//     this.addressId,
//     this.paymentId,
//     this.shippingTime,
//   });

//   factory OrderErrorModel.fromJson(Map<String, dynamic> json) {
//     return OrderErrorModel(
//       shippingDay: json['shipping_day']?.cast<String>(),
//       addressId: json['address_id']?.cast<String>(),
//       paymentId: json['payment_id']?.cast<String>(),
//       shippingTime: json['shipping_time']?.cast<String>(),
//     );
//   }

//   String get firstError {
//     if (shippingDay?.isNotEmpty == true) return shippingDay!.first;
//     if (addressId?.isNotEmpty == true) return addressId!.first;
//     if (paymentId?.isNotEmpty == true) return paymentId!.first;
//     if (shippingTime?.isNotEmpty == true) return shippingTime!.first;
//     return 'Unknown error occurred';
//   }
// }
// order_request_model.dart
class OrderRequestModel {
  final int paymentId;
  final String shippingDay;
  final String shippingTime;
  final int addressId;
  final bool? confirmOrder; // Add this parameter

  OrderRequestModel({
    required this.paymentId,
    required this.shippingDay,
    required this.shippingTime,
    required this.addressId,
    this.confirmOrder, // Optional parameter
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'payment_id': paymentId,
      'shipping_day': shippingDay,
      'shipping_time': shippingTime,
      'address_id': addressId,
    };

    // Add confirmation parameter if provided
    if (confirmOrder != null) {
      // Try multiple parameter names that might work
      json['confirm'] = confirmOrder;
      json['confirm_order'] = confirmOrder;
      json['skip_balance_check'] = confirmOrder;
      json['force_order'] = confirmOrder;
      json['auto_confirm'] = confirmOrder;
    }

    return json;
  }
}

// order_response_model.dart
class OrderResponseModel {
  final String message;
  // final bool success;
  // final OrderData? data;
  // final bool? requiresConfirmation; // Add this to handle confirmation requests

  OrderResponseModel({
    required this.message,
    // required this.success,
    // this.data,
    // this.requiresConfirmation,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      message: json["data"]['msg'] ?? '',
      // success: json['success'] ?? false,
      // data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
      // requiresConfirmation: json['requires_confirmation'] ?? false,
    );
  }
}

class OrderData {
  final int? orderId;
  final String? orderNumber;
  final String? status;

  OrderData({this.orderId, this.orderNumber, this.status});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'],
      orderNumber: json['order_number'],
      status: json['status'],
    );
  }
}

// order_error_model.dart
class OrderErrorModel {
  final List<String>? shippingDay;
  final List<String>? addressId;
  final List<String>? paymentId;
  final List<String>? shippingTime;

  OrderErrorModel({
    this.shippingDay,
    this.addressId,
    this.paymentId,
    this.shippingTime,
  });

  factory OrderErrorModel.fromJson(Map<String, dynamic> json) {
    return OrderErrorModel(
      shippingDay: json['shipping_day']?.cast<String>(),
      addressId: json['address_id']?.cast<String>(),
      paymentId: json['payment_id']?.cast<String>(),
      shippingTime: json['shipping_time']?.cast<String>(),
    );
  }

  String get firstError {
    if (shippingDay?.isNotEmpty == true) return shippingDay!.first;
    if (addressId?.isNotEmpty == true) return addressId!.first;
    if (paymentId?.isNotEmpty == true) return paymentId!.first;
    if (shippingTime?.isNotEmpty == true) return shippingTime!.first;
    return 'Unknown error occurred';
  }
}
