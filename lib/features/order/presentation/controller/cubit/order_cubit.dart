// // // import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
// // // import 'package:al_omda/features/account/data/repository/account_repository.dart';
// // // import 'package:al_omda/features/order/data/models/order_model.dart';
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
// // //           print('Failed to load addresses: $failure');
// // //           emit(OrderError('Failed to load addresses: $failure'));
// // //         },
// // //         (addresses) {
// // //           availableAddresses = addresses;
// // //           print('Loaded ${addresses.length} addresses');

// // //           // Set first address as default if none selected
// // //           if (selectedAddressId == null && addresses.isNotEmpty) {
// // //             selectedAddressId = addresses.first.id;
// // //             selectedAddress = addresses.first;
// // //           }
// // //         },
// // //       );
// // //     } catch (e) {
// // //       print('Error loading addresses: $e');
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

// // //     try {
// // //       // Extract date part from formatted string (YYYY-MM-DD Day)
// // //       final datePart = date.split(' ').first;
// // //       final selectedDateTime = DateTime.parse(datePart);
// // //       final today = DateTime.now();
// // //       final todayDateOnly = DateTime(today.year, today.month, today.day);

// // //       if (selectedDateTime.isBefore(todayDateOnly)) {
// // //         return 'Shipping date must be today or later';
// // //       }

// // //       return null;
// // //     } catch (e) {
// // //       return 'Invalid date format';
// // //     }
// // //   }

// // //   String? validateTime(String? time) {
// // //     if (time == null || time.isEmpty) {
// // //       return 'Please select shipping time';
// // //     }
// // //     return null;
// // //   }

// // //   String? validatePaymentMethod(String? paymentMethod) {
// // //     // if (paymentMethod == null || paymentMethod.isEmpty) {
// // //     //   return 'Please select payment method';
// // //     // }
// // //     return null;
// // //   }

// // //   String? validateAddress(int? addressId) {
// // //     if (addressId == null) {
// // //       return 'Please select delivery address';
// // //     }

// // //     // Check if address exists in available addresses
// // //     final addressExists = availableAddresses.any(
// // //       (address) => address.id == addressId,
// // //     );
// // //     if (!addressExists) {
// // //       return 'Selected address is not valid';
// // //     }

// // //     return null;
// // //   }

// // //   // Check if form is valid
// // //   bool get isFormValid {
// // //     return validateDate(selectedDate) == null &&
// // //         validateTime(selectedTime) == null &&
// // //         validatePaymentMethod(selectedPaymentMethod) == null &&
// // //         validateAddress(selectedAddressId) == null &&
// // //         availableAddresses.isNotEmpty;
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

// // //   // Make order
// // //   Future<void> makeOrder() async {
// // //     print('Making order with data:');
// // //     print('Date: $selectedDate');
// // //     print('Time: $selectedTime');
// // //     print('Payment: $selectedPaymentMethod');
// // //     print('Address: $selectedAddressId (${selectedAddress?.street})');
// // //     print('Form Valid: $isFormValid');
// // //     print('Available addresses: ${availableAddresses.length}');

// // //     // Ensure addresses are loaded
// // //     if (availableAddresses.isEmpty) {
// // //       await loadAddresses();
// // //     }

// // //     if (!isFormValid) {
// // //       final errors = validationErrors;
// // //       final errorMessages = errors.entries
// // //           .where((entry) => entry.value != null)
// // //           .map((entry) => entry.value!)
// // //           .join(', ');

// // //       print('Form validation failed: $errorMessages');
// // //       emit(OrderError('Please fix the following errors: $errorMessages'));
// // //       return;
// // //     }

// // //     emit(OrderLoading());

// // //     try {
// // //       // Extract date part for API (YYYY-MM-DD)
// // //       final datePart = selectedDate!.split(' ').first;

// // //       final request = OrderRequestModel(
// // //         paymentId: int.parse(selectedPaymentMethod!),
// // //         shippingDay: datePart,
// // //         shippingTime: selectedTime!,
// // //         addressId: selectedAddressId!,
// // //       );

// // //       print('Sending request: ${request.toJson()}');

// // //       final result = await _orderRepository.makeOrder(request);

// // //       result.fold(
// // //         (failure) {
// // //           print('Order failed: $failure');
// // //           emit(OrderError(failure));
// // //         },
// // //         (response) {
// // //           print('Order response: ${response.success}, ${response.message}');
// // //           if (response.success) {
// // //             emit(
// // //               OrderSuccess(
// // //                 response.message.isEmpty
// // //                     ? 'Order placed successfully!'
// // //                     : response.message,
// // //               ),
// // //             );
// // //             // Reset form after successful order
// // //             Future.delayed(const Duration(milliseconds: 500), () {
// // //               resetForm();
// // //             });
// // //           } else {
// // //             emit(
// // //               OrderError(
// // //                 response.message.isEmpty ? 'Order failed' : response.message,
// // //               ),
// // //             );
// // //           }
// // //         },
// // //       );
// // //     } catch (e) {
// // //       print('Unexpected error: $e');
// // //       emit(OrderError('Unexpected error: $e'));
// // //     }
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
// // import 'package:al_omda/features/order/data/models/order_model.dart';
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
// //   String? selectedPaymentMethod;
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

// //     // Set default payment method to "Cash on Delivery" (assuming ID = 1)
// //     // You can change this ID based on your payment methods data
// //     selectedPaymentMethod =
// //         "1"; // Change this to match your "Cash on Delivery" ID

// //     emit(OrderFormUpdated());
// //   }

// //   // Load available addresses
// //   Future<void> loadAddresses() async {
// //     try {
// //       final result = await _addressRepository.getMyAddresess();

// //       result.fold(
// //         (failure) {
// //           print('Failed to load addresses: $failure');
// //           emit(OrderError('Failed to load addresses: $failure'));
// //         },
// //         (addresses) {
// //           availableAddresses = addresses;
// //           print('Loaded ${addresses.length} addresses');

// //           // Set first address as default if none selected
// //           if (selectedAddressId == null && addresses.isNotEmpty) {
// //             selectedAddressId = addresses.first.id;
// //             selectedAddress = addresses.first;
// //           }
// //         },
// //       );
// //     } catch (e) {
// //       print('Error loading addresses: $e');
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
// //     selectedPaymentMethod = paymentMethodId;
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

// //     try {
// //       // Extract date part from formatted string (YYYY-MM-DD Day)
// //       final datePart = date.split(' ').first;
// //       final selectedDateTime = DateTime.parse(datePart);
// //       final today = DateTime.now();
// //       final todayDateOnly = DateTime(today.year, today.month, today.day);

// //       if (selectedDateTime.isBefore(todayDateOnly)) {
// //         return 'Shipping date must be today or later';
// //       }

// //       return null;
// //     } catch (e) {
// //       return 'Invalid date format';
// //     }
// //   }

// //   String? validateTime(String? time) {
// //     if (time == null || time.isEmpty) {
// //       return 'Please select shipping time';
// //     }
// //     return null;
// //   }

// //   String? validatePaymentMethod(String? paymentMethod) {
// //     // Payment method validation is now optional since we set a default
// //     // You can uncomment this if you want to make it required
// //     // if (paymentMethod == null || paymentMethod.isEmpty) {
// //     //   return 'Please select payment method';
// //     // }
// //     return null;
// //   }

// //   String? validateAddress(int? addressId) {
// //     if (addressId == null) {
// //       return 'Please select delivery address';
// //     }

// //     // Check if address exists in available addresses
// //     final addressExists = availableAddresses.any(
// //       (address) => address.id == addressId,
// //     );
// //     if (!addressExists) {
// //       return 'Selected address is not valid';
// //     }

// //     return null;
// //   }

// //   // Check if form is valid
// //   bool get isFormValid {
// //     return validateDate(selectedDate) == null &&
// //         validateTime(selectedTime) == null &&
// //         validatePaymentMethod(selectedPaymentMethod) == null &&
// //         validateAddress(selectedAddressId) == null &&
// //         availableAddresses.isNotEmpty;
// //   }

// //   // Get form validation status
// //   Map<String, String?> get validationErrors {
// //     return {
// //       'date': validateDate(selectedDate),
// //       'time': validateTime(selectedTime),
// //       'payment': validatePaymentMethod(selectedPaymentMethod),
// //       'address': validateAddress(selectedAddressId),
// //     };
// //   }

// //   // Make order
// //   Future<void> makeOrder() async {
// //     print('Making order with data:');
// //     print('Date: $selectedDate');
// //     print('Time: $selectedTime');
// //     print('Payment: $selectedPaymentMethod');
// //     print('Address: $selectedAddressId (${selectedAddress?.street})');
// //     print('Form Valid: $isFormValid');
// //     print('Available addresses: ${availableAddresses.length}');

// //     // Ensure addresses are loaded
// //     if (availableAddresses.isEmpty) {
// //       await loadAddresses();
// //     }

// //     if (!isFormValid) {
// //       final errors = validationErrors;
// //       final errorMessages = errors.entries
// //           .where((entry) => entry.value != null)
// //           .map((entry) => entry.value!)
// //           .join(', ');

// //       print('Form validation failed: $errorMessages');
// //       emit(OrderError('Please fix the following errors: $errorMessages'));
// //       return;
// //     }

// //     emit(OrderLoading());

// //     try {
// //       // Extract date part for API (YYYY-MM-DD)
// //       final datePart = selectedDate!.split(' ').first;

// //       final request = OrderRequestModel(
// //         paymentId: int.parse(selectedPaymentMethod!),
// //         shippingDay: datePart,
// //         shippingTime: selectedTime!,
// //         addressId: selectedAddressId!,
// //       );

// //       print('Sending request: ${request.toJson()}');

// //       final result = await _orderRepository.makeOrder(request);

// //       result.fold(
// //         (failure) {
// //           print('Order failed: $failure');
// //           emit(OrderError(failure));
// //         },
// //         (response) {
// //           print('Order response: ${response.success}, ${response.message}');
// //           if (response.success) {
// //             emit(
// //               OrderSuccess(
// //                 response.message.isEmpty
// //                     ? 'Order placed successfully!'
// //                     : response.message,
// //               ),
// //             );
// //             // Reset form after successful order
// //             Future.delayed(const Duration(milliseconds: 500), () {
// //               resetForm();
// //             });
// //           } else {
// //             emit(
// //               OrderError(
// //                 response.message.isEmpty ? 'Order failed' : response.message,
// //               ),
// //             );
// //           }
// //         },
// //       );
// //     } catch (e) {
// //       print('Unexpected error: $e');
// //       emit(OrderError('Unexpected error: $e'));
// //     }
// //   }

// //   // Reset form
// //   void resetForm() {
// //     selectedDate = null;
// //     selectedTime = null;
// //     selectedPaymentMethod =
// //         "1"; // Reset to default payment method instead of null
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

//     // Set default payment method to "Cash on Delivery" (assuming ID = 1)
//     // You can change this ID based on your payment methods data
//     selectedPaymentMethod =
//         "53"; // Change this to match your "Cash on Delivery" ID

//     emit(OrderFormUpdated());
//   }

//   // Load available addresses
//   Future<void> loadAddresses() async {
//     try {
//       final result = await _addressRepository.getMyAddresess();

//       result.fold(
//         (failure) {
//           print('Failed to load addresses: $failure');
//           emit(OrderError('Failed to load addresses: $failure'));
//         },
//         (addresses) {
//           availableAddresses = addresses;
//           print('Loaded ${addresses.length} addresses');

//           // Set first address as default if none selected
//           if (selectedAddressId == null && addresses.isNotEmpty) {
//             selectedAddressId = addresses.first.id;
//             selectedAddress = addresses.first;
//           }
//         },
//       );
//     } catch (e) {
//       print('Error loading addresses: $e');
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

//     try {
//       // Extract date part from formatted string (YYYY-MM-DD Day)
//       final datePart = date.split(' ').first;
//       final selectedDateTime = DateTime.parse(datePart);
//       final today = DateTime.now();
//       final todayDateOnly = DateTime(today.year, today.month, today.day);

//       if (selectedDateTime.isBefore(todayDateOnly)) {
//         return 'Shipping date must be today or later';
//       }

//       return null;
//     } catch (e) {
//       return 'Invalid date format';
//     }
//   }

//   String? validateTime(String? time) {
//     if (time == null || time.isEmpty) {
//       return 'Please select shipping time';
//     }
//     return null;
//   }

//   String? validatePaymentMethod(String? paymentMethod) {
//     // Payment method validation is now optional since we set a default
//     // You can uncomment this if you want to make it required
//     // if (paymentMethod == null || paymentMethod.isEmpty) {
//     //   return 'Please select payment method';
//     // }
//     return null;
//   }

//   String? validateAddress(int? addressId) {
//     if (addressId == null) {
//       return 'Please select delivery address';
//     }

//     // Check if address exists in available addresses
//     final addressExists = availableAddresses.any(
//       (address) => address.id == addressId,
//     );
//     if (!addressExists) {
//       return 'Selected address is not valid';
//     }

//     return null;
//   }

//   // Check if form is valid
//   bool get isFormValid {
//     return validateDate(selectedDate) == null &&
//         validateTime(selectedTime) == null &&
//         validatePaymentMethod(selectedPaymentMethod) == null &&
//         validateAddress(selectedAddressId) == null &&
//         availableAddresses.isNotEmpty;
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

//   // Make order - UPDATED METHOD
//   Future<void> makeOrder({bool autoConfirm = true}) async {
//     print('Making order with data:');
//     print('Date: $selectedDate');
//     print('Time: $selectedTime');
//     print('Payment: $selectedPaymentMethod');
//     print('Address: $selectedAddressId (${selectedAddress?.street})');
//     print('Form Valid: $isFormValid');
//     print('Available addresses: ${availableAddresses.length}');
//     print('Auto Confirm: $autoConfirm');

//     // Ensure addresses are loaded
//     if (availableAddresses.isEmpty) {
//       await loadAddresses();
//     }

//     if (!isFormValid) {
//       final errors = validationErrors;
//       final errorMessages = errors.entries
//           .where((entry) => entry.value != null)
//           .map((entry) => entry.value!)
//           .join(', ');

//       print('Form validation failed: $errorMessages');
//       emit(OrderError('Please fix the following errors: $errorMessages'));
//       return;
//     }

//     emit(OrderLoading());

//     try {
//       // Extract date part for API (YYYY-MM-DD)
//       final datePart = selectedDate!.split(' ').first;

//       final request = OrderRequestModel(
//         paymentId: int.parse(selectedPaymentMethod!),
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         addressId: selectedAddressId!,
//         confirmOrder: autoConfirm, // Add confirmation parameter
//       );

//       print('Sending request: ${request.toJson()}');

//       final result = await _orderRepository.makeOrder(request);

//       result.fold(
//         (failure) {
//           print('Order failed: $failure');

//           // Check if failure message indicates confirmation needed
//           if (failure.toLowerCase().contains('balance') ||
//               failure.toLowerCase().contains('confirm') ||
//               failure.toLowerCase().contains('رصيد')) {
//             print('Balance confirmation needed, retrying with confirmation...');
//             // Retry with confirmation
//             _retryOrderWithConfirmation();
//           } else {
//             emit(OrderError(failure));
//           }
//         },
//         (response) {
//           print('Order response: ${response.success}, ${response.message}');

//           if (response.success) {
//             emit(
//               OrderSuccess(
//                 response.message.isEmpty
//                     ? 'Order placed successfully!'
//                     : response.message,
//               ),
//             );
//             // Reset form after successful order
//             Future.delayed(const Duration(milliseconds: 500), () {
//               resetForm();
//             });
//           } else {
//             // Check if response indicates confirmation needed
//             if (response.requiresConfirmation == true ||
//                 response.message.toLowerCase().contains('balance') ||
//                 response.message.toLowerCase().contains('confirm') ||
//                 response.message.toLowerCase().contains('رصيد')) {
//               print('Balance confirmation needed from response, retrying...');
//               _retryOrderWithConfirmation();
//             } else {
//               emit(
//                 OrderError(
//                   response.message.isEmpty ? 'Order failed' : response.message,
//                 ),
//               );
//             }
//           }
//         },
//       );
//     } catch (e) {
//       print('Unexpected error: $e');
//       emit(OrderError('Unexpected error: $e'));
//     }
//   }

//   // Helper method to retry order with explicit confirmation - NEW METHOD
//   Future<void> _retryOrderWithConfirmation() async {
//     try {
//       print('Retrying order with explicit confirmation...');

//       final datePart = selectedDate!.split(' ').first;

//       final confirmedRequest = OrderRequestModel(
//         paymentId: int.parse(selectedPaymentMethod!),
//         shippingDay: datePart,
//         shippingTime: selectedTime!,
//         addressId: selectedAddressId!,
//         confirmOrder: true, // Explicit confirmation
//       );

//       print('Sending confirmed request: ${confirmedRequest.toJson()}');

//       final result = await _orderRepository.makeOrder(confirmedRequest);

//       result.fold(
//         (failure) {
//           print('Confirmed order failed: $failure');
//           emit(OrderError(failure));
//         },
//         (response) {
//           print(
//             'Confirmed order response: ${response.success}, ${response.message}',
//           );

//           if (response.success) {
//             emit(
//               OrderSuccess(
//                 response.message.isEmpty
//                     ? 'Order placed successfully!'
//                     : response.message,
//               ),
//             );
//             // Reset form after successful order
//             Future.delayed(const Duration(milliseconds: 500), () {
//               resetForm();
//             });
//           } else {
//             emit(
//               OrderError(
//                 response.message.isEmpty ? 'Order failed' : response.message,
//               ),
//             );
//           }
//         },
//       );
//     } catch (e) {
//       print('Unexpected error in retry: $e');
//       emit(OrderError('Unexpected error: $e'));
//     }
//   }

//   // Reset form
//   void resetForm() {
//     selectedDate = null;
//     selectedTime = null;
//     selectedPaymentMethod =
//         "1"; // Reset to default payment method instead of null
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

    // Set default payment method to "Cash on Delivery" (assuming ID = 1)
    // You can change this ID based on your payment methods data
    selectedPaymentMethod =
        "1"; // Change this to match your "Cash on Delivery" ID

    emit(OrderFormUpdated());
  }

  // Load available addresses
  Future<void> loadAddresses() async {
    try {
      final result = await _addressRepository.getMyAddresess();

      result.fold(
        (failure) {
          print('Failed to load addresses: $failure');
          emit(OrderError('Failed to load addresses: $failure'));
        },
        (addresses) {
          availableAddresses = addresses;
          print('Loaded ${addresses.length} addresses');

          // Set first address as default if none selected
          if (selectedAddressId == null && addresses.isNotEmpty) {
            selectedAddressId = addresses.first.id;
            selectedAddress = addresses.first;
          }
        },
      );
    } catch (e) {
      print('Error loading addresses: $e');
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
    // Payment method validation is now optional since we set a default
    // You can uncomment this if you want to make it required
    // if (paymentMethod == null || paymentMethod.isEmpty) {
    //   return 'Please select payment method';
    // }
    return null;
  }

  String? validateAddress(int? addressId) {
    if (addressId == null) {
      return 'Please select delivery address';
    }

    // Check if address exists in available addresses
    final addressExists = availableAddresses.any(
      (address) => address.id == addressId,
    );
    if (!addressExists) {
      return 'Selected address is not valid';
    }

    return null;
  }

  // Check if form is valid
  bool get isFormValid {
    return validateDate(selectedDate) == null &&
        validateTime(selectedTime) == null &&
        validatePaymentMethod(selectedPaymentMethod) == null &&
        validateAddress(selectedAddressId) == null &&
        availableAddresses.isNotEmpty;
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

  // Make order - UPDATED METHOD
  Future<void> makeOrder({bool autoConfirm = true}) async {
    print('Making order with data:');
    print('Date: $selectedDate');
    print('Time: $selectedTime');
    print('Payment: $selectedPaymentMethod');
    print('Address: $selectedAddressId (${selectedAddress?.street})');
    print('Form Valid: $isFormValid');
    print('Available addresses: ${availableAddresses.length}');
    print('Auto Confirm: $autoConfirm');

    // Ensure addresses are loaded
    if (availableAddresses.isEmpty) {
      await loadAddresses();
    }

    if (!isFormValid) {
      final errors = validationErrors;
      final errorMessages = errors.entries
          .where((entry) => entry.value != null)
          .map((entry) => entry.value!)
          .join(', ');

      print('Form validation failed: $errorMessages');
      emit(OrderError('Please fix the following errors: $errorMessages'));
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
        confirmOrder: autoConfirm,
        // Add zero amount for cash on delivery
      );

      print('Sending request: ${request.toJson()}');

      final result = await _orderRepository.makeOrder(request);

      result.fold(
        (failure) {
          print('Order failed: $failure');

          // Check if failure message indicates confirmation needed
          if (failure.toLowerCase().contains('balance') ||
              failure.toLowerCase().contains('confirm') ||
              failure.toLowerCase().contains('رصيد')) {
            print('Balance confirmation needed, retrying with confirmation...');
            // Retry with confirmation
            _retryOrderWithConfirmation();
          } else {
            emit(OrderError(failure));
          }
        },
        (response) {
          print('Order response: ${response.success}, ${response.message}');

          if (response.success) {
            emit(
              OrderSuccess(
                response.message.isEmpty
                    ? 'Order placed successfully!'
                    : response.message,
              ),
            );
            // Reset form after successful order
            Future.delayed(const Duration(milliseconds: 500), () {
              resetForm();
            });
          } else {
            // Check if response indicates confirmation needed
            if (response.requiresConfirmation == true ||
                response.message.toLowerCase().contains('balance') ||
                response.message.toLowerCase().contains('confirm') ||
                response.message.toLowerCase().contains('رصيد')) {
              print('Balance confirmation needed from response, retrying...');
              _retryOrderWithConfirmation();
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
      print('Unexpected error: $e');
      emit(OrderError('Unexpected error: $e'));
    }
  }

  // Helper method to retry order with explicit confirmation - NEW METHOD
  Future<void> _retryOrderWithConfirmation() async {
    try {
      print('Retrying order with explicit confirmation...');

      final datePart = selectedDate!.split(' ').first;

      final confirmedRequest = OrderRequestModel(
        paymentId: int.parse(selectedPaymentMethod!),
        shippingDay: datePart,
        shippingTime: selectedTime!,
        addressId: selectedAddressId!,
        confirmOrder: true,
      );

      print('Sending confirmed request: ${confirmedRequest.toJson()}');

      final result = await _orderRepository.makeOrder(confirmedRequest);

      result.fold(
        (failure) {
          print('Confirmed order failed: $failure');
          emit(OrderError(failure));
        },
        (response) {
          print(
            'Confirmed order response: ${response.success}, ${response.message}',
          );

          if (response.success) {
            emit(
              OrderSuccess(
                response.message.isEmpty
                    ? 'Order placed successfully!'
                    : response.message,
              ),
            );
            // Reset form after successful order
            Future.delayed(const Duration(milliseconds: 500), () {
              resetForm();
            });
          } else {
            emit(
              OrderError(
                response.message.isEmpty ? 'Order failed' : response.message,
              ),
            );
          }
        },
      );
    } catch (e) {
      print('Unexpected error in retry: $e');
      emit(OrderError('Unexpected error: $e'));
    }
  }

  // Reset form
  void resetForm() {
    selectedDate = null;
    selectedTime = null;
    selectedPaymentMethod =
        "52"; // Reset to default payment method instead of null
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
