

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:al_omda/features/order/domain/repository/order_repository.dart';

// part 'order_state.dart';

// class OrderCubit extends Cubit<OrderState> {
//   // final OrderRepository _orderRepository;
  
//   // Form data
//   String? _selectedDate;
//   String? _selectedTime;
//   String? _selectedPaymentMethod;
//   int? _selectedAddressId;

//   OrderCubit(
//     // this._orderRepository,
//   ) : super(OrderInitial());

//   // Getters للـ current form data
//   String? get selectedDate => _selectedDate;
//   String? get selectedTime => _selectedTime;
//   String? get selectedPaymentMethod => _selectedPaymentMethod;
//   int? get selectedAddressId => _selectedAddressId;
  
//   bool get isFormValid => 
//       _selectedDate != null && 
//       _selectedTime != null && 
//       _selectedPaymentMethod != null && 
//       _selectedAddressId != null;

//   // Update date
//   void updateSelectedDate(String date) {
//     _selectedDate = date;
//     _emitFormUpdated();
//   }

//   // Update time
//   void updateSelectedTime(String time) {
//     _selectedTime = time;
//     _emitFormUpdated();
//   }

//   // Update payment method
//   void updatePaymentMethod(String paymentMethodId) {
//     _selectedPaymentMethod = paymentMethodId;
//     _emitFormUpdated();
//   }

//   // Update address
//   void updateSelectedAddress(int addressId) {
//     _selectedAddressId = addressId;
//     _emitFormUpdated();
//   }

//   // Reset form
//   void resetForm() {
//     _selectedDate = null;
//     _selectedTime = null;
//     _selectedPaymentMethod = null;
//     _selectedAddressId = null;
//     emit(OrderInitial());
//   }

//   // Helper method لـ emit form updated state
//   void _emitFormUpdated() {
//     emit(OrderFormUpdated(
//       selectedDate: _selectedDate,
//       selectedTime: _selectedTime,
//       selectedPaymentMethod: _selectedPaymentMethod,
//       selectedAddressId: _selectedAddressId,
//       isFormValid: isFormValid,
//     ));
//   }

//   // Make order
//   Future<void> makeOrder() async {
//     if (!isFormValid) {
//       emit(const OrderError(error: 'برجاء ملء جميع البيانات المطلوبة'));
//       return;
//     }

//     emit(OrderLoading());

//     try {
//       // استدعاء الـ repository
//       // final result = await _orderRepository.makeOrder(
//       //   date: _selectedDate!.split(' ')[0], // Extract date part only
//       //   time: _selectedTime!,
//       //   paymentId: int.parse(_selectedPaymentMethod!),
//       //   addressId: _selectedAddressId!,
//       // );

//       // result.fold(
//       //   (error) => emit(OrderError(error)),
//       //   (success) {
//       //     emit(const OrderSuccess('تم تأكيد طلبك بنجاح!'));
//       //     resetForm(); // Reset form after successful order
//       //   },
//       // );

//       // Simulate API call for now
//       await Future.delayed(const Duration(seconds: 2));
      
//       // Simulate success
//       emit(const OrderSuccess(message:'تم تأكيد طلبك بنجاح!'));
      
//       // Reset form after successful order
//       Future.delayed(const Duration(seconds: 1), () {
//         resetForm();
//       });

//     } catch (e) {
//       emit(OrderError(error:'حدث خطأ غير متوقع: ${e.toString()}'));
//     }
//   }

//   // Validate specific field
//   String? validateDate(String? date) {
//     if (date == null || date.isEmpty) {
//       return 'برجاء اختيار تاريخ التوصيل';
//     }
    
//     try {
//       DateTime selectedDate = DateTime.parse(date.split(' ')[0]);
//       if (selectedDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
//         return 'لا يمكن اختيار تاريخ في الماضي';
//       }
//     } catch (e) {
//       return 'تاريخ غير صحيح';
//     }
    
//     return null;
//   }

//   String? validateTime(String? time) {
//     if (time == null || time.isEmpty) {
//       return 'برجاء اختيار وقت التوصيل';
//     }
//     return null;
//   }

//   String? validatePaymentMethod(String? paymentMethod) {
//     if (paymentMethod == null || paymentMethod.isEmpty) {
//       return 'برجاء اختيار طريقة الدفع';
//     }
//     return null;
//   }

//   String? validateAddress(int? addressId) {
//     if (addressId == null || addressId <= 0) {
//       return 'برجاء اختيار عنوان التوصيل';
//     }
//     return null;
//   }
// }

// order_cubit.dart
import 'package:al_omda/features/order/data/models/order_model.dart';
import 'package:al_omda/features/order/data/repository/order_repository.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/core/services/service_locator.dart';


class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  // Form fields
  String? selectedDate;
  String? selectedTime;
  String? selectedPaymentMethod;
  int? selectedAddressId;

  OrderCubit({OrderRepository? orderRepository})
      : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
        super(OrderInitial());

  // Update methods
  void updateSelectedDate(String date) {
    selectedDate = date;
    emit(OrderFormUpdated());
  }

  void updateSelectedTime(String time) {
    selectedTime = time;
    emit(OrderFormUpdated());
  }

  void updatePaymentMethod(String paymentMethodId) {
    selectedPaymentMethod = paymentMethodId;
    emit(OrderFormUpdated());
  }

  void updateSelectedAddress(int addressId) {
    selectedAddressId = addressId;
    emit(OrderFormUpdated());
  }

  // Validation methods
  String? validateDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Please select shipping date';
    }
    
    try {
      // Extract date part from formatted string (YYYY-MM-DD Day)
      final datePart = date.split(' ').first;
      final selectedDateTime = DateTime.parse(datePart);
      final today = DateTime.now();
      final todayDateOnly = DateTime(today.year, today.month, today.day);
      
      if (selectedDateTime.isBefore(todayDateOnly)) {
        return 'Shipping date must be today or later';
      }
      
      return null;
    } catch (e) {
      return 'Invalid date format';
    }
  }

  String? validateTime(String? time) {
    if (time == null || time.isEmpty) {
      return 'Please select shipping time';
    }
    return null;
  }

  String? validatePaymentMethod(String? paymentMethod) {
    if (paymentMethod == null || paymentMethod.isEmpty) {
      return 'Please select payment method';
    }
    return null;
  }

  String? validateAddress(int? addressId) {
    if (addressId == null) {
      return 'Please select delivery address';
    }
    return null;
  }

  // Check if form is valid
  bool get isFormValid {
    return validateDate(selectedDate) == null &&
           validateTime(selectedTime) == null &&
           validatePaymentMethod(selectedPaymentMethod) == null &&
           validateAddress(selectedAddressId) == null;
  }

  // Make order
  Future<void> makeOrder() async {
    if (!isFormValid) {
      emit(OrderError('Please fill all required fields correctly'));
      return;
    }

    emit(OrderLoading());

    try {
      // Extract date part for API (YYYY-MM-DD)
      final datePart = selectedDate!.split(' ').first;
      
      final request = OrderRequestModel(
        paymentId: int.parse(selectedPaymentMethod!),
        shippingDay: datePart,
        shippingTime: selectedTime!,
        addressId: selectedAddressId!,
      );

      final result = await _orderRepository.makeOrder(request);

      result.fold(
        (failure) => emit(OrderError(failure)),
        (response) {
          if (response.success) {
            emit(OrderSuccess(response.message));
          } else {
            emit(OrderError(response.message.isEmpty ? 'Order failed' : response.message));
          }
        },
      );
    } catch (e) {
      emit(OrderError('Unexpected error: $e'));
    }
  }

  // Reset form
  void resetForm() {
    selectedDate = null;
    selectedTime = null;
    selectedPaymentMethod = null;
    selectedAddressId = null;
    emit(OrderInitial());
  }
}
