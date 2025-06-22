import 'package:al_omda/features/order/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseOrderRepository {
  
   Future<Either<String, OrderResponseModel>> makeOrder(OrderRequestModel request);
}
