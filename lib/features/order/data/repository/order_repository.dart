// order_repository.dart
import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepository implements BaseOrderRepository {
  final ApiMethods api;

  OrderRepository(this.api);

  @override
  Future<Either<String, Map<String, dynamic>>> makeOrder({
    required int addressId,
    required int paymentId,
    required String shippingDay,
    required String shippingTime,
    bool? confirmOrder,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'address_id': addressId,
        'payment_id': paymentId,
        'shipping_day': shippingDay,
        'shipping_time': shippingTime,
      };
      if (confirmOrder != null) {
        data['confirm'] = confirmOrder;
        data['confirm_order'] = confirmOrder;
        data['skip_balance_check'] = confirmOrder;
        data['force_order'] = confirmOrder;
        data['auto_confirm'] = confirmOrder;
      }

      final response = await api.post(ApiConstances.makeOrder, data: data);

      return Right(response.data);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
