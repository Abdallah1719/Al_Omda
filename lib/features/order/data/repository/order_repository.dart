import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepository extends BaseOrderRepository {
  final ApiMethods api;

  OrderRepository({required this.api});

  @override
  Future<Either<String, bool>> makeOrder({
    required String date,
    required String time,
    required int paymentId,
    required int addressId,
  }) async {
    final response = await api.post(
      ApiConstances.makeOrder,
      data: {
        'shipping_day': date,
        'shipping_time': time,
        'payment_id': paymentId,
        'address_id': addressId,
      },
    );
    return response;
  }

  //   Future<void> clearCartAfterOrder() async {
  //   // Call cart repository to clear items
  //   await _cartRepository.clearCart();
  // }
  // }}
}
