import 'package:al_omda/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseOrderRepository {
  // Future<Either<String, bool>> makeOrder({
  //   required String date,
  //   required String time,
  //   required int paymentId,
  //   required int addressId,
  // });
   Future<Either<String, OrderResponseModel>> makeOrder(OrderRequestModel request);
}
