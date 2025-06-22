import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/order/data/models/order_model.dart';
import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepository extends BaseOrderRepository {
  final ApiMethods api;

  OrderRepository({required this.api});

  @override
  // Future<Either<String, bool>> makeOrder({
  //   required String date,
  //   required String time,
  //   required int paymentId,
  //   required int addressId,
  // }) async {
  //   final response = await api.post(
  //     ApiConstances.makeOrder,
  //     data: {
  //       'shipping_day': date,
  //       'shipping_time': time,
  //       'payment_id': paymentId,
  //       'address_id': addressId,
  //     },
  //   );
  //   return response;
  // }
  //   Future<void> clearCartAfterOrder() async {
  //   // Call cart repository to clear items
  //   await _cartRepository.clearCart();
  // }
  // }}
  @override
  Future<Either<String, OrderResponseModel>> makeOrder(
    OrderRequestModel request,
  ) async {
    try {
      final response = await api.post(
        ApiConstances.makeOrder,
        data: request.toJson(),
      );

      final orderResponse = OrderResponseModel.fromJson(response.data);
      return Right(orderResponse);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
