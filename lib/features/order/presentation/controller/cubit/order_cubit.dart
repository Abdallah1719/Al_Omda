// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'order_state.dart';

// class OrderCubit extends Cubit<OrderState> {
//   OrderCubit() : super(OrderInitial());
// }
// order_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/order/domain/repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  // final OrderRepository _orderRepository;
  
  // Form data
  String? _selectedDate;
  String? _selectedTime;
  String? _selectedPaymentMethod;
  int? _selectedAddressId;

  OrderCubit(
    // this._orderRepository,
  ) : super(OrderInitial());

  // Getters للـ current form data
  String? get selectedDate => _selectedDate;
  String? get selectedTime => _selectedTime;
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  int? get selectedAddressId => _selectedAddressId;
  
  bool get isFormValid => 
      _selectedDate != null && 
      _selectedTime != null && 
      _selectedPaymentMethod != null && 
      _selectedAddressId != null;

  // Update date
  void updateSelectedDate(String date) {
    _selectedDate = date;
    _emitFormUpdated();
  }

  // Update time
  void updateSelectedTime(String time) {
    _selectedTime = time;
    _emitFormUpdated();
  }

  // Update payment method
  void updatePaymentMethod(String paymentMethodId) {
    _selectedPaymentMethod = paymentMethodId;
    _emitFormUpdated();
  }

  // Update address
  void updateSelectedAddress(int addressId) {
    _selectedAddressId = addressId;
    _emitFormUpdated();
  }

  // Reset form
  void resetForm() {
    _selectedDate = null;
    _selectedTime = null;
    _selectedPaymentMethod = null;
    _selectedAddressId = null;
    emit(OrderInitial());
  }

  // Helper method لـ emit form updated state
  void _emitFormUpdated() {
    emit(OrderFormUpdated(
      selectedDate: _selectedDate,
      selectedTime: _selectedTime,
      selectedPaymentMethod: _selectedPaymentMethod,
      selectedAddressId: _selectedAddressId,
      isFormValid: isFormValid,
    ));
  }

  // Make order
  Future<void> makeOrder() async {
    if (!isFormValid) {
      emit(const OrderError(error: 'برجاء ملء جميع البيانات المطلوبة'));
      return;
    }

    emit(OrderLoading());

    try {
      // استدعاء الـ repository
      // final result = await _orderRepository.makeOrder(
      //   date: _selectedDate!.split(' ')[0], // Extract date part only
      //   time: _selectedTime!,
      //   paymentId: int.parse(_selectedPaymentMethod!),
      //   addressId: _selectedAddressId!,
      // );

      // result.fold(
      //   (error) => emit(OrderError(error)),
      //   (success) {
      //     emit(const OrderSuccess('تم تأكيد طلبك بنجاح!'));
      //     resetForm(); // Reset form after successful order
      //   },
      // );

      // Simulate API call for now
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success
      emit(const OrderSuccess(message:'تم تأكيد طلبك بنجاح!'));
      
      // Reset form after successful order
      Future.delayed(const Duration(seconds: 1), () {
        resetForm();
      });

    } catch (e) {
      emit(OrderError(error:'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  // Validate specific field
  String? validateDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'برجاء اختيار تاريخ التوصيل';
    }
    
    try {
      DateTime selectedDate = DateTime.parse(date.split(' ')[0]);
      if (selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        return 'لا يمكن اختيار تاريخ في الماضي';
      }
    } catch (e) {
      return 'تاريخ غير صحيح';
    }
    
    return null;
  }

  String? validateTime(String? time) {
    if (time == null || time.isEmpty) {
      return 'برجاء اختيار وقت التوصيل';
    }
    return null;
  }

  String? validatePaymentMethod(String? paymentMethod) {
    if (paymentMethod == null || paymentMethod.isEmpty) {
      return 'برجاء اختيار طريقة الدفع';
    }
    return null;
  }

  String? validateAddress(int? addressId) {
    if (addressId == null || addressId <= 0) {
      return 'برجاء اختيار عنوان التوصيل';
    }
    return null;
  }
}