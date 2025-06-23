// import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// import 'package:al_omda/features/account/data/repository/account_repository.dart';
// import 'package:al_omda/features/order/data/models/order_model.dart';
// import 'package:al_omda/features/order/data/repository/order_repository.dart';
// import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
// import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/core/services/service_locator.dart';

// class OrderCubit extends Cubit<OrderState> {
//   final BaseOrderRepository _orderRepository;
//   final AccountRepository _addressRepository;

//   // Form fields
//   String? selectedDate;
//   String? selectedTime;
//   String? selectedPaymentMethod;
//   int? selectedAddressId;

//   // Address data
//   List<MyAddresessModel> availableAddresses = [];
//   MyAddresessModel? selectedAddress;

//   OrderCubit({
//     OrderRepository? orderRepository,
//     AccountRepository? addressRepository,
//   }) : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
//        _addressRepository = addressRepository ?? getIt<AccountRepository>(),
//        super(OrderInitial());

//   // Initialize with loading addresses
//   void initialize() async {
//     emit(OrderLoading());
//     await loadAddresses();

//     // Set default address if available
//     if (availableAddresses.isNotEmpty) {
//       selectedAddressId = availableAddresses.first.id;
//       selectedAddress = availableAddresses.first;
//     }

//     // لا نضع طريقة دفع افتراضية الآن
//     // selectedPaymentMethod = "1"; // تم إزالة هذا السطر

//     emit(OrderFormUpdated());
//   }

//   // Load available addresses
//   Future<void> loadAddresses() async {
//     try {
//       final result = await _addressRepository.getMyAddresess();

//       result.fold(
//         (failure) {
//           emit(OrderError('Failed to load addresses: $failure'));
//         },
//         (addresses) {
//           availableAddresses = addresses;

//           // Set first address as default if none selected
//           if (selectedAddressId == null && addresses.isNotEmpty) {
//             selectedAddressId = addresses.first.id;
//             selectedAddress = addresses.first;
//           }
//         },
//       );
//     } catch (e) {
//       emit(OrderError('Error loading addresses: $e'));
//     }
//   }

//   // Update methods
//   void updateSelectedDate(String date) {
//     selectedDate = date;
//     emit(OrderFormUpdated());
//   }

//   void updateSelectedTime(String time) {
//     selectedTime = time;
//     emit(OrderFormUpdated());
//   }

//   void updatePaymentMethod(String paymentMethodId) {
//     selectedPaymentMethod = paymentMethodId;
//     emit(OrderFormUpdated());
//   }

//   void updateSelectedAddress(int addressId) {
//     selectedAddressId = addressId;
//     selectedAddress = availableAddresses.firstWhere(
//       (address) => address.id == addressId,
//       orElse: () => availableAddresses.first,
//     );
//     emit(OrderFormUpdated());
//   }

//   // Get selected address details
//   String get selectedAddressText {
//     if (selectedAddress != null) {
//       return '${selectedAddress!.street}\n${selectedAddress!.city}\n${selectedAddress!.id}';
//     }
//     return 'No address selected';
//   }

//   // Validation methods
//   String? validateDate(String? date) {
//     if (date == null || date.isEmpty) {
//       return 'Please select shipping date';
//     }
//     return null;
//   }

//   String? validateTime(String? time) {
//     if (time == null || time.isEmpty) {
//       return 'Please select shipping time';
//     }
//     return null;
//   }

//   String? validatePaymentMethod(String? paymentMethod) {
//     if (paymentMethod == null || paymentMethod.isEmpty) {
//       return 'Please select payment method';
//     }
//     return null;
//   }

//   String? validateAddress(int? addressId) {
//     if (addressId == null) {
//       return 'Please select delivery address';
//     }

//     final addressExists = availableAddresses.any(
//       (address) => address.id == addressId,
//     );
//     if (!addressExists) {
//       return 'Selected address is not valid';
//     }

//     return null;
//   }

//   bool get isPaymentMethodSelected => selectedPaymentMethod != null;

//   bool get isFormValid {
//     return validateDate(selectedDate) == null &&
//         validateTime(selectedTime) == null &&
//         validatePaymentMethod(selectedPaymentMethod) == null &&
//         validateAddress(selectedAddressId) == null;
//   }

//   // Get form validation status
//   Map<String, String?> get validationErrors {
//     return {
//       'date': validateDate(selectedDate),
//       'time': validateTime(selectedTime),
//       'payment': validatePaymentMethod(selectedPaymentMethod),
//       'address': validateAddress(selectedAddressId),
//     };
//   }

//   Future<void> makeOrder({bool autoConfirm = true}) async {

//     if (!isPaymentMethodSelected) {
//       emit(OrderError('Please select a payment method'));
//       return;
//     }

//     if (!isFormValid) {
//       final errors = validationErrors;
//       final errorMessages = errors.entries
//           .where((entry) => entry.value != null)
//           .map((entry) => entry.value!)
//           .join(', ');

//       emit(OrderError('Please fix the following errors: $errorMessages'));
//       return;
//     }

//     emit(OrderLoading());

//     try {
//       final datePart = selectedDate!.split(' ').first;

//       final request = OrderRequestModel(
//         paymentId: int.parse(selectedPaymentMethod!),
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         addressId: selectedAddressId!,
//         confirmOrder: autoConfirm,
//       );

//       final result = await _orderRepository.makeOrder(request);

//       result.fold(
//         (failure) {
//           if (failure.toLowerCase().contains('balance') ||
//               failure.toLowerCase().contains('confirm') ||
//               failure.toLowerCase().contains('رصيد')) {
//             _retryOrderWithConfirmation();
//           } else {
//             emit(OrderError(failure));
//           }
//         },
//         (response) {
//           if (response.success) {
//             emit(OrderSuccess(response.message));
//             Future.delayed(const Duration(milliseconds: 500), resetForm);
//           } else {
//             if (response.requiresConfirmation == true ||
//                 response.message.toLowerCase().contains('balance') ||
//                 response.message.toLowerCase().contains('confirm') ||
//                 response.message.toLowerCase().contains('رصيد')) {
//               _retryOrderWithConfirmation();
//             } else {
//               emit(OrderError(response.message));
//             }
//           }
//         },
//       );
//     } catch (e) {
//       emit(OrderError('Unexpected error: $e'));
//     }
//   }

//   Future<void> _retryOrderWithConfirmation() async {
//     try {
//       final datePart = selectedDate!.split(' ').first;

//       final confirmedRequest = OrderRequestModel(
//         paymentId: int.parse(selectedPaymentMethod!),
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         addressId: selectedAddressId!,
//         confirmOrder: true,
//       );

//       final result = await _orderRepository.makeOrder(confirmedRequest);

//       result.fold(
//         (failure) {
//           emit(OrderError(failure));
//         },
//         (response) {
//           if (response.success) {
//             emit(OrderSuccess(response.message));
//             Future.delayed(const Duration(milliseconds: 500), resetForm);
//           } else {
//             emit(OrderError(response.message));
//           }
//         },
//       );
//     } catch (e) {
//       emit(OrderError('Unexpected error in retry: $e'));
//     }
//   }

//   void resetForm() {
//     selectedDate = null;
//     selectedTime = null;
//     selectedPaymentMethod = null;
//     selectedAddressId = null;
//     selectedAddress = null;
//     emit(OrderInitial());
//   }

//   // Refresh addresses
//   Future<void> refreshAddresses() async {
//     emit(OrderLoading());
//     await loadAddresses();
//     emit(OrderFormUpdated());
//   }
// }

import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/data/repository/account_repository.dart';
import 'package:al_omda/features/order/data/models/order_model.dart';
import 'package:al_omda/features/order/data/repository/order_repository.dart';
import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/core/services/service_locator.dart';

class OrderCubit extends Cubit<OrderState> {
  final BaseOrderRepository _orderRepository;
  final AccountRepository _addressRepository;

  // Form fields
  String? selectedDate;
  String? selectedTime;
  String? selectedPaymentMethod;
  int? selectedAddressId;

  // Address data
  List<MyAddresessModel> availableAddresses = [];
  MyAddresessModel? selectedAddress;

  OrderCubit({
    OrderRepository? orderRepository,
    AccountRepository? addressRepository,
  }) : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
       _addressRepository = addressRepository ?? getIt<AccountRepository>(),
       super(OrderInitial());

  // Initialize with loading addresses
  void initialize() async {
    emit(OrderLoading());
    await loadAddresses();

    // Set default address if available
    if (availableAddresses.isNotEmpty) {
      selectedAddressId = availableAddresses.first.id;
      selectedAddress = availableAddresses.first;
    }

    emit(OrderFormUpdated());
  }

  // Load available addresses
  Future<void> loadAddresses() async {
    try {
      final result = await _addressRepository.getMyAddresess();

      result.fold(
        (failure) {
          emit(OrderError('Failed to load addresses: $failure'));
        },
        (addresses) {
          availableAddresses = addresses;

          // Set first address as default if none selected
          if (selectedAddressId == null && addresses.isNotEmpty) {
            selectedAddressId = addresses.first.id;
            selectedAddress = addresses.first;
          }
          emit(OrderFormUpdated());
        },
      );
    } catch (e) {
      emit(OrderError('Error loading addresses: $e'));
    }
  }

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
    selectedAddress = availableAddresses.firstWhere(
      (address) => address.id == addressId,
      orElse: () => availableAddresses.first,
    );
    emit(OrderFormUpdated());
  }

  // Get selected address details
  String get selectedAddressText {
    if (selectedAddress != null) {
      return '${selectedAddress!.street}\n${selectedAddress!.city}\n${selectedAddress!.id}';
    }
    return 'No address selected';
  }

  // Validation methods
  String? validateDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'Please select shipping date';
    }
    return null;
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

    final addressExists = availableAddresses.any(
      (address) => address.id == addressId,
    );
    if (!addressExists) {
      return 'Selected address is not valid';
    }

    return null;
  }

  // Check if payment method is selected
  bool get isPaymentMethodSelected => selectedPaymentMethod != null;

  // Check if form is valid
  bool get isFormValid {
    return validateDate(selectedDate) == null &&
        validateTime(selectedTime) == null &&
        validatePaymentMethod(selectedPaymentMethod) == null &&
        validateAddress(selectedAddressId) == null;
  }

  // Get form validation status
  Map<String, String?> get validationErrors {
    return {
      'date': validateDate(selectedDate),
      'time': validateTime(selectedTime),
      'payment': validatePaymentMethod(selectedPaymentMethod),
      'address': validateAddress(selectedAddressId),
    };
  }

  // Make order - with all enhancements
  Future<void> makeOrder({bool autoConfirm = true}) async {
    // 1. Check payment method first
    if (!isPaymentMethodSelected) {
      emit(OrderError('Please select a payment method'));
      return;
    }

    // 2. Validate all form fields
    if (!isFormValid) {
      final errors = validationErrors;
      final errorMessages = errors.entries
          .where((entry) => entry.value != null)
          .map((entry) => entry.value!)
          .join(', ');

      emit(OrderError('Please fix the following errors: $errorMessages'));
      return;
    }

    emit(OrderLoading());

    try {
      final datePart = selectedDate!.split(' ').first;

      final request = OrderRequestModel(
        paymentId: 2, //int.parse(selectedPaymentMethod!),
        shippingDay: datePart,
        shippingTime: selectedTime!,
        addressId: selectedAddressId!,
        confirmOrder: autoConfirm,
      );

      final result = await _orderRepository.makeOrder(request);

      result.fold(
        (failure) {
          if (_isBalanceError(failure)) {
            emit(
              OrderBalanceError(
                'Your balance is not enough to complete this order. Please recharge your wallet.',
              ),
            );
          } else {
            emit(OrderError(failure));
          }
        },
        (response) {
          if (response.message.isNotEmpty) {
            emit(
              OrderSuccess(
                response.message.isEmpty
                    ? 'Order placed successfully!'
                    : response.message,
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () => resetForm);
          } else {
            if (_isBalanceError(response.message)) {
              emit(
                OrderBalanceError(
                  'Your balance is not enough to complete this order. Please recharge your wallet.',
                ),
              );
            } else {
              emit(
                OrderError(
                  response.message.isEmpty ? 'Order failed' : response.message,
                ),
              );
            }
          }
        },
      );
    } catch (e) {
      emit(OrderError('Unexpected error: $e'));
    }
  }

  // Helper method to detect balance errors
  bool _isBalanceError(String message) {
    final lowerMessage = message.toLowerCase();
    return lowerMessage.contains('balance') ||
        lowerMessage.contains('not enough') ||
        lowerMessage.contains('رصيد') ||
        lowerMessage.contains('غير كافي') ||
        lowerMessage.contains('insufficient');
  }

  // Reset form
  void resetForm() {
    selectedDate = null;
    selectedTime = null;
    selectedPaymentMethod = null;
    selectedAddressId = null;
    selectedAddress = null;
    emit(OrderInitial());
  }

  // Refresh addresses
  Future<void> refreshAddresses() async {
    emit(OrderLoading());
    await loadAddresses();
    emit(OrderFormUpdated());
  }
}
