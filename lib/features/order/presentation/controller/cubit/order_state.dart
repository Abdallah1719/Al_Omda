
// part of 'order_cubit.dart';

// abstract class OrderState extends Equatable {
//   const OrderState();

//   @override
//   List<Object?> get props => [];
// }

// class OrderInitial extends OrderState {}

// class OrderLoading extends OrderState {}

// class OrderSuccess extends OrderState {
//   final String message;
  
//   const OrderSuccess({required this.message});
  
//   @override
//   List<Object?> get props => [message];
// }

// class OrderError extends OrderState {
//   final String error;
  
//   const OrderError({required this.error});
  
//   @override
//   List<Object?> get props => [error];
// }

// // Additional states للـ UI interactions
// class OrderFormUpdated extends OrderState {
//   final String? selectedDate;
//   final String? selectedTime;
//   final String? selectedPaymentMethod;
//   final int? selectedAddressId;
//   final bool isFormValid;
  
//   const OrderFormUpdated({
//     this.selectedDate,
//     this.selectedTime,
//     this.selectedPaymentMethod,
//     this.selectedAddressId,
//     required this.isFormValid,
//   });
  
//   @override
//   List<Object?> get props => [
//     selectedDate,
//     selectedTime,
//     selectedPaymentMethod,
//     selectedAddressId,
//     isFormValid,
//   ];
// }

// //==============================================================
// order_state.dart
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderFormUpdated extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final String message;
  OrderSuccess(this.message);
}

class OrderError extends OrderState {
  final String error;
  OrderError(this.error);
}