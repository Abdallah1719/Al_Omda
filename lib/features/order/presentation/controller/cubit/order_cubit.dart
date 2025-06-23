import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/data/repository/account_repository.dart';
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

  // Make order - updated to use the new simplified approach
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

      final result = await _orderRepository.makeOrder(
        addressId: selectedAddressId!,
        paymentId: 2, // int.parse(selectedPaymentMethod!),
        shippingDay: datePart,
        shippingTime: selectedTime!,
        confirmOrder: autoConfirm,
      );

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
        (responseData) {
          // Extract message from response data
          final message = _extractMessage(responseData);

          if (message.isNotEmpty && !_isBalanceError(message)) {
            emit(
              OrderSuccess(
                message.isEmpty ? 'Order placed successfully!' : message,
              ),
            );
            Future.delayed(
              const Duration(milliseconds: 500),
              () => resetForm(),
            );
          } else {
            if (_isBalanceError(message)) {
              emit(
                OrderBalanceError(
                  'Your balance is not enough to complete this order. Please recharge your wallet.',
                ),
              );
            } else {
              emit(OrderError(message.isEmpty ? 'Order failed' : message));
            }
          }
        },
      );
    } catch (e) {
      emit(OrderError('Unexpected error: $e'));
    }
  }

  // Helper method to extract message from response data
  String _extractMessage(Map<String, dynamic> responseData) {
    // Try different possible message keys
    if (responseData['data'] != null && responseData['data']['msg'] != null) {
      return responseData['data']['msg'].toString();
    }
    if (responseData['message'] != null) {
      return responseData['message'].toString();
    }
    if (responseData['msg'] != null) {
      return responseData['msg'].toString();
    }
    if (responseData['data'] != null &&
        responseData['data']['message'] != null) {
      return responseData['data']['message'].toString();
    }
    return '';
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
// // // // import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// // // // import 'package:al_omda/features/account/data/repository/account_repository.dart';
// // // // import 'package:al_omda/features/order/data/repository/order_repository.dart';
// // // // import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
// // // // import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
// // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // import 'package:al_omda/core/services/service_locator.dart';

// // // // class OrderCubit extends Cubit<OrderState> {
// // // //   final BaseOrderRepository _orderRepository;
// // // //   final AccountRepository _addressRepository;

// // // //   // Form fields
// // // //   String? selectedDate;
// // // //   String? selectedTime;
// // // //   String? selectedPaymentMethod;
// // // //   int? selectedAddressId;

// // // //   // Address data
// // // //   List<MyAddresessModel> availableAddresses = [];
// // // //   MyAddresessModel? selectedAddress;

// // // //   OrderCubit({
// // // //     OrderRepository? orderRepository,
// // // //     AccountRepository? addressRepository,
// // // //   }) : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
// // // //        _addressRepository = addressRepository ?? getIt<AccountRepository>(),
// // // //        super(OrderInitial());

// // // //   // Initialize with loading addresses
// // // //   void initialize() async {
// // // //     emit(OrderLoading());
// // // //     await loadAddresses();

// // // //     // Set default address if available
// // // //     if (availableAddresses.isNotEmpty) {
// // // //       selectedAddressId = availableAddresses.first.id;
// // // //       selectedAddress = availableAddresses.first;
// // // //     }

// // // //     emit(OrderFormUpdated());
// // // //   }

// // // //   // Load available addresses
// // // //   Future<void> loadAddresses() async {
// // // //     try {
// // // //       final result = await _addressRepository.getMyAddresess();

// // // //       result.fold(
// // // //         (failure) {
// // // //           emit(OrderError('Failed to load addresses: $failure'));
// // // //         },
// // // //         (addresses) {
// // // //           availableAddresses = addresses;

// // // //           // Set first address as default if none selected
// // // //           if (selectedAddressId == null && addresses.isNotEmpty) {
// // // //             selectedAddressId = addresses.first.id;
// // // //             selectedAddress = addresses.first;
// // // //           }
// // // //           emit(OrderFormUpdated());
// // // //         },
// // // //       );
// // // //     } catch (e) {
// // // //       emit(OrderError('Error loading addresses: $e'));
// // // //     }
// // // //   }

// // // //   // Update methods
// // // //   void updateSelectedDate(String date) {
// // // //     selectedDate = date;
// // // //     emit(OrderFormUpdated());
// // // //   }

// // // //   void updateSelectedTime(String time) {
// // // //     selectedTime = time;
// // // //     emit(OrderFormUpdated());
// // // //   }

// // // //   void updatePaymentMethod(String paymentMethodId) {
// // // //     selectedPaymentMethod = paymentMethodId;
// // // //     emit(OrderFormUpdated());
// // // //   }

// // // //   void updateSelectedAddress(int addressId) {
// // // //     selectedAddressId = addressId;
// // // //     selectedAddress = availableAddresses.firstWhere(
// // // //       (address) => address.id == addressId,
// // // //       orElse: () => availableAddresses.first,
// // // //     );
// // // //     emit(OrderFormUpdated());
// // // //   }

// // // //   // Get selected address details
// // // //   String get selectedAddressText {
// // // //     if (selectedAddress != null) {
// // // //       return '${selectedAddress!.street}\n${selectedAddress!.city}\n${selectedAddress!.id}';
// // // //     }
// // // //     return 'No address selected';
// // // //   }

// // // //   // Validation methods
// // // //   String? validateDate(String? date) {
// // // //     if (date == null || date.isEmpty) {
// // // //       return 'Please select shipping date';
// // // //     }
// // // //     return null;
// // // //   }

// // // //   String? validateTime(String? time) {
// // // //     if (time == null || time.isEmpty) {
// // // //       return 'Please select shipping time';
// // // //     }
// // // //     return null;
// // // //   }

// // // //   String? validatePaymentMethod(String? paymentMethod) {
// // // //     if (paymentMethod == null || paymentMethod.isEmpty) {
// // // //       return 'Please select payment method';
// // // //     }
// // // //     return null;
// // // //   }

// // // //   String? validateAddress(int? addressId) {
// // // //     if (addressId == null) {
// // // //       return 'Please select delivery address';
// // // //     }

// // // //     final addressExists = availableAddresses.any(
// // // //       (address) => address.id == addressId,
// // // //     );
// // // //     if (!addressExists) {
// // // //       return 'Selected address is not valid';
// // // //     }

// // // //     return null;
// // // //   }

// // // //   // Check if payment method is selected
// // // //   bool get isPaymentMethodSelected => selectedPaymentMethod != null;

// // // //   // Check if form is valid
// // // //   bool get isFormValid {
// // // //     return validateDate(selectedDate) == null &&
// // // //         validateTime(selectedTime) == null &&
// // // //         validatePaymentMethod(selectedPaymentMethod) == null &&
// // // //         validateAddress(selectedAddressId) == null;
// // // //   }

// // // //   // Get form validation status
// // // //   Map<String, String?> get validationErrors {
// // // //     return {
// // // //       'date': validateDate(selectedDate),
// // // //       'time': validateTime(selectedTime),
// // // //       'payment': validatePaymentMethod(selectedPaymentMethod),
// // // //       'address': validateAddress(selectedAddressId),
// // // //     };
// // // //   }

// // // //   // Make order - updated to use the new simplified approach
// // // //   Future<void> makeOrder({bool autoConfirm = true}) async {
// // // //     // 1. Check payment method first
// // // //     if (!isPaymentMethodSelected) {
// // // //       emit(OrderError('Please select a payment method'));
// // // //       return;
// // // //     }

// // // //     // 2. Validate all form fields
// // // //     if (!isFormValid) {
// // // //       final errors = validationErrors;
// // // //       final errorMessages = errors.entries
// // // //           .where((entry) => entry.value != null)
// // // //           .map((entry) => entry.value!)
// // // //           .join(', ');

// // // //       emit(OrderError('Please fix the following errors: $errorMessages'));
// // // //       return;
// // // //     }

// // // //     emit(OrderLoading());

// // // //     try {
// // // //       final datePart = selectedDate!.split(' ').first;

// // // //       final result = await _orderRepository.makeOrder(
// // // //         addressId: selectedAddressId!,
// // // //         paymentId: 2, // int.parse(selectedPaymentMethod!),
// // // //         shippingDay: datePart,
// // // //         shippingTime: selectedTime!,
// // // //         confirmOrder: autoConfirm,
// // // //       );

// // // //       result.fold(
// // // //         (failure) {
// // // //           if (_isBalanceError(failure)) {
// // // //             emit(
// // // //               OrderBalanceError(
// // // //                 'Your balance is not enough to complete this order. Please recharge your wallet.',
// // // //               ),
// // // //             );
// // // //           } else {
// // // //             emit(OrderError(failure));
// // // //           }
// // // //         },
// // // //         (responseData) {
// // // //           // Debug: طباعة الـ response لفهم البنية
// // // //           print('Order Response: $responseData');

// // // //           // Check if the request was successful based on status code or success indicators
// // // //           if (_isOrderSuccessful(responseData)) {
// // // //             final message = _extractSuccessMessage(responseData);
// // // //             emit(
// // // //               OrderSuccess(
// // // //                 message.isEmpty ? 'Order placed successfully!' : message,
// // // //               ),
// // // //             );
// // // //             Future.delayed(
// // // //               const Duration(milliseconds: 500),
// // // //               () => resetForm(),
// // // //             );
// // // //           } else {
// // // //             final errorMessage = _extractErrorMessage(responseData);
// // // //             if (_isBalanceError(errorMessage)) {
// // // //               emit(
// // // //                 OrderBalanceError(
// // // //                   'Your balance is not enough to complete this order. Please recharge your wallet.',
// // // //                 ),
// // // //               );
// // // //             } else {
// // // //               emit(
// // // //                 OrderError(
// // // //                   errorMessage.isEmpty ? 'Order failed' : errorMessage,
// // // //                 ),
// // // //               );
// // // //             }
// // // //           }
// // // //         },
// // // //       );
// // // //     } catch (e) {
// // // //       emit(OrderError('Unexpected error: $e'));
// // // //     }
// // // //   }

// // // //   // Helper method to check if order was successful
// // // //   bool _isOrderSuccessful(Map<String, dynamic> responseData) {
// // // //     // Check different success indicators
// // // //     if (responseData['success'] == true) return true;
// // // //     if (responseData['status'] == 'success') return true;
// // // //     if (responseData['status'] == 200) return true;
// // // //     if (responseData['data'] != null && responseData['data']['success'] == true)
// // // //       return true;
// // // //     if (responseData['data'] != null &&
// // // //         responseData['data']['status'] == 'success')
// // // //       return true;

// // // //     // If no explicit success indicator, assume success if we got a response without errors
// // // //     // (since the API call succeeded and we're in the Right side of Either)
// // // //     return true;
// // // //   }

// // // //   // Helper method to extract success message from response data
// // // //   String _extractSuccessMessage(Map<String, dynamic> responseData) {
// // // //     // Try different possible success message keys
// // // //     if (responseData['data'] != null &&
// // // //         responseData['data']['message'] != null) {
// // // //       return responseData['data']['message'].toString();
// // // //     }
// // // //     if (responseData['data'] != null && responseData['data']['msg'] != null) {
// // // //       return responseData['data']['msg'].toString();
// // // //     }
// // // //     if (responseData['message'] != null) {
// // // //       return responseData['message'].toString();
// // // //     }
// // // //     if (responseData['msg'] != null) {
// // // //       return responseData['msg'].toString();
// // // //     }
// // // //     if (responseData['success_message'] != null) {
// // // //       return responseData['success_message'].toString();
// // // //     }
// // // //     return 'Order placed successfully!';
// // // //   }

// // // //   // Helper method to extract error message from response data
// // // //   String _extractErrorMessage(Map<String, dynamic> responseData) {
// // // //     // Try different possible error message keys
// // // //     if (responseData['error'] != null) {
// // // //       return responseData['error'].toString();
// // // //     }
// // // //     if (responseData['error_message'] != null) {
// // // //       return responseData['error_message'].toString();
// // // //     }
// // // //     if (responseData['data'] != null && responseData['data']['error'] != null) {
// // // //       return responseData['data']['error'].toString();
// // // //     }
// // // //     if (responseData['errors'] != null) {
// // // //       return responseData['errors'].toString();
// // // //     }
// // // //     return 'Order failed';
// // // //   }

// // // //   // Helper method to detect balance errors
// // // //   bool _isBalanceError(String message) {
// // // //     final lowerMessage = message.toLowerCase();
// // // //     return lowerMessage.contains('balance') ||
// // // //         lowerMessage.contains('not enough') ||
// // // //         lowerMessage.contains('رصيد') ||
// // // //         lowerMessage.contains('غير كافي') ||
// // // //         lowerMessage.contains('insufficient');
// // // //   }

// // // //   // Reset form
// // // //   void resetForm() {
// // // //     selectedDate = null;
// // // //     selectedTime = null;
// // // //     selectedPaymentMethod = null;
// // // //     selectedAddressId = null;
// // // //     selectedAddress = null;
// // // //     emit(OrderInitial());
// // // //   }

// // // //   // Refresh addresses
// // // //   Future<void> refreshAddresses() async {
// // // //     emit(OrderLoading());
// // // //     await loadAddresses();
// // // //     emit(OrderFormUpdated());
// // // //   }
// // // // }

// // // import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// // // import 'package:al_omda/features/account/data/repository/account_repository.dart';
// // // import 'package:al_omda/features/order/data/repository/order_repository.dart';
// // // import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
// // // import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:al_omda/core/services/service_locator.dart';

// // // class OrderCubit extends Cubit<OrderState> {
// // //   final BaseOrderRepository _orderRepository;
// // //   final AccountRepository _addressRepository;

// // //   // Form fields
// // //   String? selectedDate;
// // //   String? selectedTime;
// // //   String? selectedPaymentMethod;
// // //   int? selectedAddressId;

// // //   // Address data
// // //   List<MyAddresessModel> availableAddresses = [];
// // //   MyAddresessModel? selectedAddress;

// // //   OrderCubit({
// // //     OrderRepository? orderRepository,
// // //     AccountRepository? addressRepository,
// // //   }) : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
// // //        _addressRepository = addressRepository ?? getIt<AccountRepository>(),
// // //        super(OrderInitial());

// // //   // Initialize with loading addresses
// // //   void initialize() async {
// // //     emit(OrderLoading());
// // //     await loadAddresses();

// // //     // Set default address if available
// // //     if (availableAddresses.isNotEmpty) {
// // //       selectedAddressId = availableAddresses.first.id;
// // //       selectedAddress = availableAddresses.first;
// // //     }

// // //     emit(OrderFormUpdated());
// // //   }

// // //   // Load available addresses
// // //   Future<void> loadAddresses() async {
// // //     try {
// // //       final result = await _addressRepository.getMyAddresess();

// // //       result.fold(
// // //         (failure) {
// // //           emit(OrderError('Failed to load addresses: $failure'));
// // //         },
// // //         (addresses) {
// // //           availableAddresses = addresses;

// // //           // Set first address as default if none selected
// // //           if (selectedAddressId == null && addresses.isNotEmpty) {
// // //             selectedAddressId = addresses.first.id;
// // //             selectedAddress = addresses.first;
// // //           }
// // //           emit(OrderFormUpdated());
// // //         },
// // //       );
// // //     } catch (e) {
// // //       emit(OrderError('Error loading addresses: $e'));
// // //     }
// // //   }

// // //   // Update methods
// // //   void updateSelectedDate(String date) {
// // //     selectedDate = date;
// // //     emit(OrderFormUpdated());
// // //   }

// // //   void updateSelectedTime(String time) {
// // //     selectedTime = time;
// // //     emit(OrderFormUpdated());
// // //   }

// // //   void updatePaymentMethod(String paymentMethodId) {
// // //     selectedPaymentMethod = paymentMethodId;
// // //     emit(OrderFormUpdated());
// // //   }

// // //   void updateSelectedAddress(int addressId) {
// // //     selectedAddressId = addressId;
// // //     selectedAddress = availableAddresses.firstWhere(
// // //       (address) => address.id == addressId,
// // //       orElse: () => availableAddresses.first,
// // //     );
// // //     emit(OrderFormUpdated());
// // //   }

// // //   // Get selected address details
// // //   String get selectedAddressText {
// // //     if (selectedAddress != null) {
// // //       return '${selectedAddress!.street}\n${selectedAddress!.city}\n${selectedAddress!.id}';
// // //     }
// // //     return 'No address selected';
// // //   }

// // //   // Validation methods
// // //   String? validateDate(String? date) {
// // //     if (date == null || date.isEmpty) {
// // //       return 'Please select shipping date';
// // //     }
// // //     return null;
// // //   }

// // //   String? validateTime(String? time) {
// // //     if (time == null || time.isEmpty) {
// // //       return 'Please select shipping time';
// // //     }
// // //     return null;
// // //   }

// // //   String? validatePaymentMethod(String? paymentMethod) {
// // //     if (paymentMethod == null || paymentMethod.isEmpty) {
// // //       return 'Please select payment method';
// // //     }
// // //     return null;
// // //   }

// // //   String? validateAddress(int? addressId) {
// // //     if (addressId == null) {
// // //       return 'Please select delivery address';
// // //     }

// // //     final addressExists = availableAddresses.any(
// // //       (address) => address.id == addressId,
// // //     );
// // //     if (!addressExists) {
// // //       return 'Selected address is not valid';
// // //     }

// // //     return null;
// // //   }

// // //   // Check if payment method is selected
// // //   bool get isPaymentMethodSelected => selectedPaymentMethod != null;

// // //   // Check if form is valid
// // //   bool get isFormValid {
// // //     return validateDate(selectedDate) == null &&
// // //         validateTime(selectedTime) == null &&
// // //         validatePaymentMethod(selectedPaymentMethod) == null &&
// // //         validateAddress(selectedAddressId) == null;
// // //   }

// // //   // Get form validation status
// // //   Map<String, String?> get validationErrors {
// // //     return {
// // //       'date': validateDate(selectedDate),
// // //       'time': validateTime(selectedTime),
// // //       'payment': validatePaymentMethod(selectedPaymentMethod),
// // //       'address': validateAddress(selectedAddressId),
// // //     };
// // //   }

// // //   // Make order - updated to use the new simplified approach
// // //   Future<void> makeOrder({bool autoConfirm = true}) async {
// // //     // 1. Check payment method first
// // //     if (!isPaymentMethodSelected) {
// // //       emit(OrderError('Please select a payment method'));
// // //       return;
// // //     }

// // //     // 2. Validate all form fields
// // //     if (!isFormValid) {
// // //       final errors = validationErrors;
// // //       final errorMessages = errors.entries
// // //           .where((entry) => entry.value != null)
// // //           .map((entry) => entry.value!)
// // //           .join(', ');

// // //       emit(OrderError('Please fix the following errors: $errorMessages'));
// // //       return;
// // //     }

// // //     emit(OrderLoading());

// // //     try {
// // //       final datePart = selectedDate!.split(' ').first;

// // //       final result = await _orderRepository.makeOrder(
// // //         addressId: selectedAddressId!,
// // //         paymentId: 2, // int.parse(selectedPaymentMethod!),
// // //         shippingDay: datePart,
// // //         shippingTime: selectedTime!,
// // //         confirmOrder: autoConfirm,
// // //       );

// // //       result.fold(
// // //         (failure) {
// // //           if (_isBalanceError(failure)) {
// // //             emit(
// // //               OrderBalanceError(
// // //                 'Your balance is not enough to complete this order. Please recharge your wallet.',
// // //               ),
// // //             );
// // //           } else {
// // //             emit(OrderError(failure));
// // //           }
// // //         },
// // //         (responseData) {
// // //           // Debug: طباعة الـ response لفهم البنية
// // //           print('Order Response: $responseData');
// // //           print('Response Type: ${responseData.runtimeType}');
// // //           print('Response Keys: ${responseData.keys.toList()}');

// // //           // مؤقتاً - اعتبر أي response في Right هو نجاح
// // //           emit(OrderSuccess('Order placed successfully!'));
// // //           Future.delayed(const Duration(milliseconds: 500), () => resetForm());
// // //         },
// // //       );
// // //     } catch (e) {
// // //       emit(OrderError('Unexpected error: $e'));
// // //     }
// // //   }

// // //   // Helper method to check if order was successful
// // //   bool _isOrderSuccessful(Map<String, dynamic> responseData) {
// // //     // Check different success indicators
// // //     if (responseData['success'] == true) return true;
// // //     if (responseData['status'] == 'success') return true;
// // //     if (responseData['status'] == 200) return true;
// // //     if (responseData['data'] != null && responseData['data']['success'] == true)
// // //       return true;
// // //     if (responseData['data'] != null &&
// // //         responseData['data']['status'] == 'success')
// // //       return true;

// // //     // If no explicit success indicator, assume success if we got a response without errors
// // //     // (since the API call succeeded and we're in the Right side of Either)
// // //     return true;
// // //   }

// // //   // Helper method to extract success message from response data
// // //   String _extractSuccessMessage(Map<String, dynamic> responseData) {
// // //     // Try different possible success message keys
// // //     if (responseData['data'] != null &&
// // //         responseData['data']['message'] != null) {
// // //       return responseData['data']['message'].toString();
// // //     }
// // //     if (responseData['data'] != null && responseData['data']['msg'] != null) {
// // //       return responseData['data']['msg'].toString();
// // //     }
// // //     if (responseData['message'] != null) {
// // //       return responseData['message'].toString();
// // //     }
// // //     if (responseData['msg'] != null) {
// // //       return responseData['msg'].toString();
// // //     }
// // //     if (responseData['success_message'] != null) {
// // //       return responseData['success_message'].toString();
// // //     }
// // //     return 'Order placed successfully!';
// // //   }

// // //   // Helper method to extract error message from response data
// // //   String _extractErrorMessage(Map<String, dynamic> responseData) {
// // //     // Try different possible error message keys
// // //     if (responseData['error'] != null) {
// // //       return responseData['error'].toString();
// // //     }
// // //     if (responseData['error_message'] != null) {
// // //       return responseData['error_message'].toString();
// // //     }
// // //     if (responseData['data'] != null && responseData['data']['error'] != null) {
// // //       return responseData['data']['error'].toString();
// // //     }
// // //     if (responseData['errors'] != null) {
// // //       return responseData['errors'].toString();
// // //     }
// // //     return 'Order failed';
// // //   }

// // //   // Helper method to detect balance errors
// // //   bool _isBalanceError(String message) {
// // //     final lowerMessage = message.toLowerCase();
// // //     return lowerMessage.contains('balance') ||
// // //         lowerMessage.contains('not enough') ||
// // //         lowerMessage.contains('رصيد') ||
// // //         lowerMessage.contains('غير كافي') ||
// // //         lowerMessage.contains('insufficient');
// // //   }

// // //   // Reset form
// // //   void resetForm() {
// // //     selectedDate = null;
// // //     selectedTime = null;
// // //     selectedPaymentMethod = null;
// // //     selectedAddressId = null;
// // //     selectedAddress = null;
// // //     emit(OrderInitial());
// // //   }

// // //   // Refresh addresses
// // //   Future<void> refreshAddresses() async {
// // //     emit(OrderLoading());
// // //     await loadAddresses();
// // //     emit(OrderFormUpdated());
// // //   }
// // // }
// // import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// // import 'package:al_omda/features/account/data/repository/account_repository.dart';
// // import 'package:al_omda/features/order/data/repository/order_repository.dart';
// // import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
// // import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:al_omda/core/services/service_locator.dart';

// // class OrderCubit extends Cubit<OrderState> {
// //   final BaseOrderRepository _orderRepository;
// //   final AccountRepository _addressRepository;

// //   // Form fields
// //   String? selectedDate;
// //   String? selectedTime;
// //   int? selectedAddressId;

// //   // Address data
// //   List<MyAddresessModel> availableAddresses = [];
// //   MyAddresessModel? selectedAddress;

// //   OrderCubit({
// //     OrderRepository? orderRepository,
// //     AccountRepository? addressRepository,
// //   }) : _orderRepository = orderRepository ?? getIt<OrderRepository>(),
// //        _addressRepository = addressRepository ?? getIt<AccountRepository>(),
// //        super(OrderInitial());

// //   // Initialize with loading addresses
// //   void initialize() async {
// //     emit(OrderLoading());
// //     await loadAddresses();

// //     // Set default address if available
// //     if (availableAddresses.isNotEmpty) {
// //       selectedAddressId = availableAddresses.first.id;
// //       selectedAddress = availableAddresses.first;
// //     }

// //     emit(OrderFormUpdated());
// //   }

// //   // Load available addresses
// //   Future<void> loadAddresses() async {
// //     try {
// //       final result = await _addressRepository.getMyAddresess();

// //       result.fold(
// //         (failure) {
// //           emit(OrderError('Failed to load addresses: $failure'));
// //         },
// //         (addresses) {
// //           availableAddresses = addresses;

// //           // Set first address as default if none selected
// //           if (selectedAddressId == null && addresses.isNotEmpty) {
// //             selectedAddressId = addresses.first.id;
// //             selectedAddress = addresses.first;
// //           }
// //           emit(OrderFormUpdated());
// //         },
// //       );
// //     } catch (e) {
// //       emit(OrderError('Error loading addresses: $e'));
// //     }
// //   }

// //   // Update methods
// //   void updateSelectedDate(String date) {
// //     selectedDate = date;
// //     emit(OrderFormUpdated());
// //   }

// //   void updateSelectedTime(String time) {
// //     selectedTime = time;
// //     emit(OrderFormUpdated());
// //   }

// //   void updatePaymentMethod(String paymentMethodId) {
// //     // لم تعد هناك حاجة لهذه الدالة - يمكن حذفها أو تركها فارغة
// //     emit(OrderFormUpdated());
// //   }

// //   void updateSelectedAddress(int addressId) {
// //     selectedAddressId = addressId;
// //     selectedAddress = availableAddresses.firstWhere(
// //       (address) => address.id == addressId,
// //       orElse: () => availableAddresses.first,
// //     );
// //     emit(OrderFormUpdated());
// //   }

// //   // Get selected address details
// //   String get selectedAddressText {
// //     if (selectedAddress != null) {
// //       return '${selectedAddress!.street}\n${selectedAddress!.city}\n${selectedAddress!.id}';
// //     }
// //     return 'No address selected';
// //   }

// //   // Validation methods
// //   String? validateDate(String? date) {
// //     if (date == null || date.isEmpty) {
// //       return 'Please select shipping date';
// //     }
// //     return null;
// //   }

// //   String? validateTime(String? time) {
// //     if (time == null || time.isEmpty) {
// //       return 'Please select shipping time';
// //     }
// //     return null;
// //   }

// //   String? validatePaymentMethod(String? paymentMethod) {
// //     // لم تعد هناك حاجة لهذا التحقق - الدفع عند الاستلام افتراضياً
// //     return null;
// //   }

// //   String? validateAddress(int? addressId) {
// //     if (addressId == null) {
// //       return 'Please select delivery address';
// //     }

// //     final addressExists = availableAddresses.any(
// //       (address) => address.id == addressId,
// //     );
// //     if (!addressExists) {
// //       return 'Selected address is not valid';
// //     }

// //     return null;
// //   }

// //   // Check if payment method is selected
// //   bool get isPaymentMethodSelected => true; // دائماً true لأن الدفع عند الاستلام افتراضي

// //   // Check if form is valid
// //   bool get isFormValid {
// //     return validateDate(selectedDate) == null &&
// //         validateTime(selectedTime) == null &&
// //         validateAddress(selectedAddressId) == null;
// //   }

// //   // Get form validation status
// //   Map<String, String?> get validationErrors {
// //     return {
// //       'date': validateDate(selectedDate),
// //       'time': validateTime(selectedTime),
// //       'address': validateAddress(selectedAddressId),
// //     };
// //   }

// //   // Make order - updated to use the new simplified approach
// //   Future<void> makeOrder({bool autoConfirm = true}) async {
// //     // Validate form fields (no payment validation needed)
// //     if (!isFormValid) {
// //       final errors = validationErrors;
// //       final errorMessages = errors.entries
// //           .where((entry) => entry.value != null)
// //           .map((entry) => entry.value!)
// //           .join(', ');

// //       emit(OrderError('Please fix the following errors: $errorMessages'));
// //       return;
// //     }

// //     emit(OrderLoading());

// //     try {
// //       final datePart = selectedDate!.split(' ').first;

// //       final result = await _orderRepository.makeOrder(
// //         addressId: selectedAddressId!,
// //         paymentId: 1, // الدفع عند الاستلام - ID ثابت
// //         shippingDay: datePart,
// //         shippingTime: selectedTime!,
// //         confirmOrder: autoConfirm,
// //       );

// //       result.fold(
// //         (failure) {
// //           if (_isBalanceError(failure)) {
// //             emit(
// //               OrderBalanceError(
// //                 'Your balance is not enough to complete this order. Please recharge your wallet.',
// //               ),
// //             );
// //           } else {
// //             emit(OrderError(failure));
// //           }
// //         },
// //         (responseData) {
// //           // Debug: طباعة الـ response لفهم البنية
// //           print('Order Response: $responseData');

// //           // Check if the request was successful based on status code or success indicators
// //           if (_isOrderSuccessful(responseData)) {
// //             final message = _extractSuccessMessage(responseData);
// //             emit(
// //               OrderSuccess(
// //                 message.isEmpty
// //                     ? 'Order placed successfully!'
// //                     : message,
// //               ),
// //             );
// //             Future.delayed(const Duration(milliseconds: 500), () => resetForm());
// //           } else {
// //             final errorMessage = _extractErrorMessage(responseData);
// //             if (_isBalanceError(errorMessage)) {
// //               emit(
// //                 OrderBalanceError(
// //                   'Your balance is not enough to complete this order. Please recharge your wallet.',
// //                 ),
// //               );
// //             } else {
// //               emit(
// //                 OrderError(
// //                   errorMessage.isEmpty ? 'Order failed' : errorMessage,
// //                 ),
// //               );
// //             }
// //           }
// //         },
// //       );
// //     } catch (e) {
// //       emit(OrderError('Unexpected error: $e'));
// //     }
// //   }

// //   // Helper method to check if order was successful
// //   bool _isOrderSuccessful(Map<String, dynamic> responseData) {
// //     // Check different success indicators
// //     if (responseData['success'] == true) return true;
// //     if (responseData['status'] == 'success') return true;
// //     if (responseData['status'] == 200) return true;
// //     if (responseData['data'] != null && responseData['data']['success'] == true) return true;
// //     if (responseData['data'] != null && responseData['data']['status'] == 'success') return true;

// //     // If no explicit success indicator, assume success if we got a response without errors
// //     // (since the API call succeeded and we're in the Right side of Either)
// //     return true;
// //   }

// //   // Helper method to extract success message from response data
// //   String _extractSuccessMessage(Map<String, dynamic> responseData) {
// //     // Try different possible success message keys
// //     if (responseData['data'] != null && responseData['data']['message'] != null) {
// //       return responseData['data']['message'].toString();
// //     }
// //     if (responseData['data'] != null && responseData['data']['msg'] != null) {
// //       return responseData['data']['msg'].toString();
// //     }
// //     if (responseData['message'] != null) {
// //       return responseData['message'].toString();
// //     }
// //     if (responseData['msg'] != null) {
// //       return responseData['msg'].toString();
// //     }
// //     if (responseData['success_message'] != null) {
// //       return responseData['success_message'].toString();
// //     }
// //     return 'Order placed successfully!';
// //   }

// //   // Helper method to extract error message from response data
// //   String _extractErrorMessage(Map<String, dynamic> responseData) {
// //     // Try different possible error message keys
// //     if (responseData['error'] != null) {
// //       return responseData['error'].toString();
// //     }
// //     if (responseData['error_message'] != null) {
// //       return responseData['error_message'].toString();
// //     }
// //     if (responseData['data'] != null && responseData['data']['error'] != null) {
// //       return responseData['data']['error'].toString();
// //     }
// //     if (responseData['errors'] != null) {
// //       return responseData['errors'].toString();
// //     }
// //     return 'Order failed';
// //   }

// //   // Helper method to detect balance errors
// //   bool _isBalanceError(String message) {
// //     final lowerMessage = message.toLowerCase();
// //     return lowerMessage.contains('balance') ||
// //         lowerMessage.contains('not enough') ||
// //         lowerMessage.contains('رصيد') ||
// //         lowerMessage.contains('غير كافي') ||
// //         lowerMessage.contains('insufficient');
// //   }

// //   // Reset form
// //   void resetForm() {
// //     selectedDate = null;
// //     selectedTime = null;
// //     selectedAddressId = null;
// //     selectedAddress = null;
// //     emit(OrderInitial());
// //   }

// //   // Refresh addresses
// //   Future<void> refreshAddresses() async {
// //     emit(OrderLoading());
// //     await loadAddresses();
// //     emit(OrderFormUpdated());
// //   }
// // }

// import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// import 'package:al_omda/features/account/data/repository/account_repository.dart';
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
//           emit(OrderFormUpdated());
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
//     // لم تعد هناك حاجة لهذه الدالة - يمكن حذفها أو تركها فارغة
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
//     // لم تعد هناك حاجة لهذا التحقق - الدفع عند الاستلام افتراضياً
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

//   // Check if payment method is selected
//   bool get isPaymentMethodSelected =>
//       true; // دائماً true لأن الدفع عند الاستلام افتراضي

//   // Check if form is valid
//   bool get isFormValid {
//     return validateDate(selectedDate) == null &&
//         validateTime(selectedTime) == null &&
//         validateAddress(selectedAddressId) == null;
//   }

//   // Get form validation status
//   Map<String, String?> get validationErrors {
//     return {
//       'date': validateDate(selectedDate),
//       'time': validateTime(selectedTime),
//       'address': validateAddress(selectedAddressId),
//     };
//   }

//   // Make order - updated to use the new simplified approach
//   Future<void> makeOrder({bool autoConfirm = true}) async {
//     // Validate form fields (no payment validation needed)
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

//       final result = await _orderRepository.makeOrder(
//         addressId: selectedAddressId!,
//         paymentId: 1, // الدفع عند الاستلام - ID ثابت
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         confirmOrder: autoConfirm,
//       );

//       result.fold(
//         (failure) {
//           if (_isBalanceError(failure)) {
//             emit(
//               OrderBalanceError(
//                 'Your balance is not enough to complete this order. Please recharge your wallet.',
//               ),
//             );
//           } else {
//             emit(OrderError(failure));
//           }
//         },
//         (responseData) {
//           // Debug: طباعة الـ response لفهم البنية
//           print('Order Response: $responseData');

//           // Check if the request was successful based on status code or success indicators
//           if (_isOrderSuccessful(responseData)) {
//             final message = _extractSuccessMessage(responseData);
//             emit(
//               OrderSuccess(
//                 message.isEmpty ? 'Order placed successfully!' : message,
//               ),
//             );
//             Future.delayed(
//               const Duration(milliseconds: 500),
//               () => resetForm(),
//             );
//           } else {
//             final errorMessage = _extractErrorMessage(responseData);
//             if (_isBalanceError(errorMessage)) {
//               emit(
//                 OrderBalanceError(
//                   'Your balance is not enough to complete this order. Please recharge your wallet.',
//                 ),
//               );
//             } else {
//               emit(
//                 OrderError(
//                   errorMessage.isEmpty ? 'Order failed' : errorMessage,
//                 ),
//               );
//             }
//           }
//         },
//       );
//     } catch (e) {
//       emit(OrderError('Unexpected error: $e'));
//     }
//   }

//   // Helper method to check if order was successful
//   bool _isOrderSuccessful(Map<String, dynamic> responseData) {
//     // First check if there's an error in the response
//     if (_hasError(responseData)) {
//       return false;
//     }

//     // Check different success indicators
//     if (responseData['success'] == true) return true;
//     if (responseData['status'] == 'success') return true;
//     if (responseData['status'] == 200) return true;
//     if (responseData['data'] != null && responseData['data']['success'] == true)
//       return true;
//     if (responseData['data'] != null &&
//         responseData['data']['status'] == 'success')
//       return true;

//     // If no explicit success indicator, but no error either, assume success
//     return true;
//   }

//   // Helper method to check if response contains an error
//   bool _hasError(Map<String, dynamic> responseData) {
//     // Check for various error indicators
//     if (responseData['error'] != null) return true;
//     if (responseData['errors'] != null) return true;
//     if (responseData['error_message'] != null) return true;
//     if (responseData['data'] != null && responseData['data']['error'] != null)
//       return true;
//     if (responseData['data'] != null && responseData['data']['errors'] != null)
//       return true;

//     return false;
//   }

//   // Helper method to extract success message from response data
//   String _extractSuccessMessage(Map<String, dynamic> responseData) {
//     // Try different possible success message keys
//     if (responseData['data'] != null &&
//         responseData['data']['message'] != null) {
//       return responseData['data']['message'].toString();
//     }
//     if (responseData['data'] != null && responseData['data']['msg'] != null) {
//       return responseData['data']['msg'].toString();
//     }
//     if (responseData['message'] != null) {
//       return responseData['message'].toString();
//     }
//     if (responseData['msg'] != null) {
//       return responseData['msg'].toString();
//     }
//     if (responseData['success_message'] != null) {
//       return responseData['success_message'].toString();
//     }
//     return 'Order placed successfully!';
//   }

//   // Helper method to extract error message from response data - FIXED
//   String _extractErrorMessage(Map<String, dynamic> responseData) {
//     // Try different possible error message keys in order of priority

//     // Check data.error first (this is what your API returns)
//     if (responseData['data'] != null && responseData['data']['error'] != null) {
//       return responseData['data']['error'].toString();
//     }

//     // Check data.errors
//     if (responseData['data'] != null &&
//         responseData['data']['errors'] != null) {
//       return responseData['data']['errors'].toString();
//     }

//     // Check direct error field
//     if (responseData['error'] != null) {
//       return responseData['error'].toString();
//     }

//     // Check error_message
//     if (responseData['error_message'] != null) {
//       return responseData['error_message'].toString();
//     }

//     // Check errors array/object
//     if (responseData['errors'] != null) {
//       final errors = responseData['errors'];
//       if (errors is List && errors.isNotEmpty) {
//         return errors.first.toString();
//       } else if (errors is Map) {
//         return errors.values.first.toString();
//       } else {
//         return errors.toString();
//       }
//     }

//     // Check data.message for error messages
//     if (responseData['data'] != null &&
//         responseData['data']['message'] != null) {
//       return responseData['data']['message'].toString();
//     }

//     // Check message field
//     if (responseData['message'] != null) {
//       return responseData['message'].toString();
//     }

//     return 'Order failed';
//   }

//   // Helper method to detect balance errors - ENHANCED
//   bool _isBalanceError(String message) {
//     final lowerMessage = message.toLowerCase();
//     return lowerMessage.contains('balance') ||
//         lowerMessage.contains('not enough') ||
//         lowerMessage.contains('balance not enough') ||
//         lowerMessage.contains('رصيد') ||
//         lowerMessage.contains('غير كافي') ||
//         lowerMessage.contains('insufficient');
//   }

//   // Reset form
//   void resetForm() {
//     selectedDate = null;
//     selectedTime = null;
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

// import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// import 'package:al_omda/features/account/data/repository/account_repository.dart';
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
//           emit(OrderFormUpdated());
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
//     // لم تعد هناك حاجة لهذه الدالة - يمكن حذفها أو تركها فارغة
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
//     // لم تعد هناك حاجة لهذا التحقق - الدفع عند الاستلام افتراضياً
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

//   // Check if payment method is selected
//   bool get isPaymentMethodSelected =>
//       true; // دائماً true لأن الدفع عند الاستلام افتراضي

//   // Check if form is valid
//   bool get isFormValid {
//     return validateDate(selectedDate) == null &&
//         validateTime(selectedTime) == null &&
//         validateAddress(selectedAddressId) == null;
//   }

//   // Get form validation status
//   Map<String, String?> get validationErrors {
//     return {
//       'date': validateDate(selectedDate),
//       'time': validateTime(selectedTime),
//       'address': validateAddress(selectedAddressId),
//     };
//   }

//   // Make order - updated to use the new simplified approach
//   Future<void> makeOrder({bool autoConfirm = true}) async {
//     // Validate form fields (no payment validation needed)
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

//       final result = await _orderRepository.makeOrder(
//         addressId: selectedAddressId!,
//         paymentId: 1, // الدفع عند الاستلام - ID ثابت
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         confirmOrder: autoConfirm,
//       );

//       result.fold(
//         (failure) {
//           print('Order failed with error: $failure');
//           if (_isBalanceError(failure)) {
//             emit(
//               OrderBalanceError(
//                 'Your balance is not enough to complete this order. Please recharge your wallet.',
//               ),
//             );
//           } else {
//             emit(OrderError(failure));
//           }
//         },
//         (responseData) {
//           // Debug: طباعة الـ response لفهم البنية
//           print('Order Response: $responseData');

//           // Check if the request was successful based on status code or success indicators
//           if (_isOrderSuccessful(responseData)) {
//             final message = _extractSuccessMessage(responseData);
//             emit(
//               OrderSuccess(
//                 message.isEmpty ? 'Order placed successfully!' : message,
//               ),
//             );
//             Future.delayed(
//               const Duration(milliseconds: 500),
//               () => resetForm(),
//             );
//           } else {
//             final errorMessage = _extractErrorMessage(responseData);
//             if (_isBalanceError(errorMessage)) {
//               emit(
//                 OrderBalanceError(
//                   'Your balance is not enough to complete this order. Please recharge your wallet.',
//                 ),
//               );
//             } else {
//               emit(
//                 OrderError(
//                   errorMessage.isEmpty ? 'Order failed' : errorMessage,
//                 ),
//               );
//             }
//           }
//         },
//       );
//     } catch (e) {
//       emit(OrderError('Unexpected error: $e'));
//     }
//   }

//   // Helper method to check if order was successful
//   bool _isOrderSuccessful(Map<String, dynamic> responseData) {
//     // First check if there's an error in the response
//     if (_hasError(responseData)) {
//       return false;
//     }

//     // Check different success indicators
//     if (responseData['success'] == true) return true;
//     if (responseData['status'] == 'success') return true;
//     if (responseData['status'] == 200) return true;
//     if (responseData['data'] != null && responseData['data']['success'] == true)
//       return true;
//     if (responseData['data'] != null &&
//         responseData['data']['status'] == 'success')
//       return true;

//     // If no explicit success indicator, but no error either, assume success
//     return true;
//   }

//   // Helper method to check if response contains an error
//   bool _hasError(Map<String, dynamic> responseData) {
//     // Check for various error indicators
//     if (responseData['error'] != null) return true;
//     if (responseData['errors'] != null) return true;
//     if (responseData['error_message'] != null) return true;
//     if (responseData['data'] != null && responseData['data']['error'] != null)
//       return true;
//     if (responseData['data'] != null && responseData['data']['errors'] != null)
//       return true;

//     return false;
//   }

//   // Helper method to extract success message from response data
//   String _extractSuccessMessage(Map<String, dynamic> responseData) {
//     // Try different possible success message keys
//     if (responseData['data'] != null &&
//         responseData['data']['message'] != null) {
//       return responseData['data']['message'].toString();
//     }
//     if (responseData['data'] != null && responseData['data']['msg'] != null) {
//       return responseData['data']['msg'].toString();
//     }
//     if (responseData['message'] != null) {
//       return responseData['message'].toString();
//     }
//     if (responseData['msg'] != null) {
//       return responseData['msg'].toString();
//     }
//     if (responseData['success_message'] != null) {
//       return responseData['success_message'].toString();
//     }
//     return 'Order placed successfully!';
//   }

//   // Helper method to extract error message from response data - FIXED
//   String _extractErrorMessage(Map<String, dynamic> responseData) {
//     // Try different possible error message keys in order of priority

//     // Check data.error first (this is what your API returns)
//     if (responseData['data'] != null && responseData['data']['error'] != null) {
//       return responseData['data']['error'].toString();
//     }

//     // Check data.errors
//     if (responseData['data'] != null &&
//         responseData['data']['errors'] != null) {
//       return responseData['data']['errors'].toString();
//     }

//     // Check direct error field
//     if (responseData['error'] != null) {
//       return responseData['error'].toString();
//     }

//     // Check error_message
//     if (responseData['error_message'] != null) {
//       return responseData['error_message'].toString();
//     }

//     // Check errors array/object
//     if (responseData['errors'] != null) {
//       final errors = responseData['errors'];
//       if (errors is List && errors.isNotEmpty) {
//         return errors.first.toString();
//       } else if (errors is Map) {
//         return errors.values.first.toString();
//       } else {
//         return errors.toString();
//       }
//     }

//     // Check data.message for error messages
//     if (responseData['data'] != null &&
//         responseData['data']['message'] != null) {
//       return responseData['data']['message'].toString();
//     }

//     // Check message field
//     if (responseData['message'] != null) {
//       return responseData['message'].toString();
//     }

//     return 'Order failed';
//   }

//   // Helper method to detect balance errors - ENHANCED
//   bool _isBalanceError(String message) {
//     final lowerMessage = message.toLowerCase();
//     return lowerMessage.contains('balance') ||
//         lowerMessage.contains('not enough') ||
//         lowerMessage.contains('balance not enough') ||
//         lowerMessage.contains('رصيد') ||
//         lowerMessage.contains('غير كافي') ||
//         lowerMessage.contains('insufficient');
//   }

//   // Reset form
//   void resetForm() {
//     selectedDate = null;
//     selectedTime = null;
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
