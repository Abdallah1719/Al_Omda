import 'package:dartz/dartz.dart';

abstract class BaseOrderRepository {
  Future<Either<String, Map<String, dynamic>>> makeOrder({
    required int addressId,
    required int paymentId,
    required String shippingDay,
    required String shippingTime,
    bool? confirmOrder,
  });
}