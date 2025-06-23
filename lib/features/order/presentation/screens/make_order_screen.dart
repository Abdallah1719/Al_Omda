// import 'package:al_omda/core/services/service_locator.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
// import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
// import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MakeOrderScreen extends StatelessWidget {
//   const MakeOrderScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => getIt<OrderCubit>()..initialize()),
//         // الحل الأساسي: استدعاء getCartItems عند إنشاء CartCubit
//         BlocProvider(create: (context) => getIt<CartCubit>()..getCartItems()),
//       ],
//       child: const MakeOrderView(),
//     );
//   }
// }

// class MakeOrderView extends StatefulWidget {
//   const MakeOrderView({super.key});

//   @override
//   State<MakeOrderView> createState() => _MakeOrderViewState();
// }

// class _MakeOrderViewState extends State<MakeOrderView> {
//   @override
//   void initState() {
//     super.initState();
//     // ضمان إضافي لجلب بيانات السلة
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final cartCubit = context.read<CartCubit>();
//       if (cartCubit.state is! CartLoaded) {
//         cartCubit.getCartItems();
//       }
//     });
//   }

//   // Static data
//   static const double deliveryFee = 20.0;
//   static const double discountValue = 0.0;

//   // Payment methods
//   static const List<Map<String, dynamic>> paymentMethods = [
//     {'id': 1, 'name': 'Cash on Delivery', 'icon': Icons.money},
//     {'id': 2, 'name': 'Credit Card', 'icon': Icons.credit_card},
//     {'id': 3, 'name': 'Mobile Wallet', 'icon': Icons.phone_android},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Check out Information'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: BlocConsumer<OrderCubit, OrderState>(
//         listener: (context, state) {
//           if (state is OrderError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error),
//                 backgroundColor: Colors.red,
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           } else if (state is OrderSuccess) {
//             _showSuccessDialog(context, state.message);
//           }
//         },
//         builder: (context, state) {
//           final cubit = context.read<OrderCubit>();

//           if (state is OrderLoading && cubit.availableAddresses.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return BlocBuilder<CartCubit, CartState>(
//             builder: (context, cartState) {
//               // إظهار loading للسلة
//               if (cartState is CartLoading) {
//                 return const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text('Loading cart items...'),
//                     ],
//                   ),
//                 );
//               }

//               // إظهار error للسلة
//               if (cartState is CartError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error, size: 48, color: Colors.red),
//                       SizedBox(height: 16),
//                       Text('Error loading cart: ${cartState.message}'),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed:
//                             () => context.read<CartCubit>().getCartItems(),
//                         child: Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               // إظهار empty cart
//               if (cartState is CartLoaded &&
//                   cartState.cartModel.items.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.shopping_cart_outlined,
//                         size: 48,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(height: 16),
//                       Text('Your cart is empty'),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: Text('Go Back'),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildAddressSection(context, cubit),
//                     const SizedBox(height: 16),
//                     _buildDeliveryFeeSection(),
//                     const SizedBox(height: 16),
//                     _buildShippingDateSection(context, cubit),
//                     const SizedBox(height: 16),
//                     _buildShippingTimeSection(context, cubit),
//                     const SizedBox(height: 16),
//                     _buildPaymentMethodSection(context, cubit),
//                     const SizedBox(height: 16),
//                     _buildTotalsSection(context),
//                     const SizedBox(height: 24),
//                     _buildOrderButton(context, cubit, state),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildAddressSection(BuildContext context, OrderCubit cubit) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Address',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: BlocBuilder<OrderCubit, OrderState>(
//                   builder: (context, state) {
//                     final addressText = cubit.selectedAddressText;
//                     final hasAddresses = cubit.availableAddresses.isNotEmpty;

//                     return Text(
//                       hasAddresses ? addressText : 'Loading addresses...',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: hasAddresses ? Colors.black : Colors.grey,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => _showAddressOptions(context, cubit),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.edit, size: 18, color: Colors.green),
//                         SizedBox(width: 4),
//                         Text(
//                           'Change',
//                           style: TextStyle(fontSize: 14, color: Colors.green),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   GestureDetector(
//                     onTap: () => _addNewAddress(context, cubit),
//                     child: const Row(
//                       children: [
//                         Icon(Icons.add, size: 18, color: Colors.green),
//                         SizedBox(width: 4),
//                         Text(
//                           'Add New',
//                           style: TextStyle(fontSize: 14, color: Colors.green),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 4),
//         const Text(
//           'Make sure this address is correct.',
//           style: TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//         // Show address validation error if exists
//         BlocBuilder<OrderCubit, OrderState>(
//           builder: (context, state) {
//             final addressError = cubit.validateAddress(cubit.selectedAddressId);
//             if (addressError != null) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Text(
//                   addressError,
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildDeliveryFeeSection() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Delivery Fee:',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           '$deliveryFee L.E',
//           style: TextStyle(fontSize: 16, color: Colors.green),
//         ),
//       ],
//     );
//   }

//   Widget _buildShippingDateSection(BuildContext context, OrderCubit cubit) {
//     return BlocBuilder<OrderCubit, OrderState>(
//       builder: (context, state) {
//         final selectedDate = cubit.selectedDate;
//         final dateError = cubit.validateDate(selectedDate);

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Select Shipping Day',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () => _selectShippingDate(context, cubit),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 16,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.calendar_today, color: Colors.white),
//                     SizedBox(width: 8),
//                     Text(
//                       'Select Shipping Date',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color:
//                     dateError == null
//                         ? Colors.green.shade50
//                         : Colors.red.shade50,
//                 border: Border.all(
//                   color: dateError == null ? Colors.green : Colors.red,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 selectedDate ?? 'No Date Selected',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: dateError == null ? Colors.green.shade700 : Colors.red,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             if (dateError != null) ...[
//               const SizedBox(height: 4),
//               Text(
//                 dateError,
//                 style: const TextStyle(color: Colors.red, fontSize: 12),
//               ),
//             ],
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildShippingTimeSection(BuildContext context, OrderCubit cubit) {
//     return BlocBuilder<OrderCubit, OrderState>(
//       builder: (context, state) {
//         final selectedTime = cubit.selectedTime;
//         final timeError = cubit.validateTime(selectedTime);

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Shipping Time',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _buildTimeChip(context, cubit, 'Now - 60 min'),
//                 _buildTimeChip(context, cubit, '5 - 6 PM'),
//                 _buildTimeChip(context, cubit, '6 - 7 PM'),
//                 _buildTimeChip(context, cubit, '7 - 8 PM'),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color:
//                     timeError == null
//                         ? Colors.green.shade50
//                         : Colors.red.shade50,
//                 border: Border.all(
//                   color: timeError == null ? Colors.green : Colors.red,
//                 ),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 selectedTime != null
//                     ? 'Selected Time: $selectedTime'
//                     : 'Please Select Time',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: timeError == null ? Colors.green.shade700 : Colors.red,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             if (timeError != null) ...[
//               const SizedBox(height: 4),
//               Text(
//                 timeError,
//                 style: const TextStyle(color: Colors.red, fontSize: 12),
//               ),
//             ],
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildPaymentMethodSection(BuildContext context, OrderCubit cubit) {
//     return BlocBuilder<OrderCubit, OrderState>(
//       builder: (context, state) {
//         final selectedPaymentMethod = cubit.selectedPaymentMethod;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Payment Method',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ...paymentMethods.map(
//               (method) => Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 child: RadioListTile<String>(
//                   title: Row(
//                     children: [
//                       Icon(method['icon'], size: 20),
//                       const SizedBox(width: 8),
//                       Text(method['name']),
//                     ],
//                   ),
//                   value: method['id'].toString(),
//                   groupValue: selectedPaymentMethod,
//                   onChanged: (value) {
//                     if (value != null) {
//                       cubit.updatePaymentMethod(value);
//                     }
//                   },
//                   activeColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     side: BorderSide(
//                       color:
//                           selectedPaymentMethod == method['id'].toString()
//                               ? Colors.green
//                               : Colors.grey.shade300,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTotalsSection(BuildContext context) {
//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, cartState) {
//         double subtotal = 0.0;
//         double finalTotal = 0.0;

//         if (cartState is CartLoaded) {
//           subtotal = cartState.cartModel.summary.total;
//           // حساب المجموع الأخير مع رسوم التوصيل
//           finalTotal = subtotal + deliveryFee - discountValue;
//         }

//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Column(
//             children: [
//               if (cartState is CartLoaded &&
//                   cartState.cartModel.items.isNotEmpty) ...[
//                 _buildCartItemsHeader(),
//                 const SizedBox(height: 8),
//                 ...cartState.cartModel.items.map(
//                   (item) => _buildCartItemRow(item),
//                 ),
//                 const SizedBox(height: 8),
//                 const Divider(thickness: 1),
//               ],
//               _buildTotalRow('Subtotal:', '${subtotal.toStringAsFixed(0)} L.E'),
//               if (discountValue > 0)
//                 _buildTotalRow(
//                   'Discount:',
//                   '-${discountValue.toStringAsFixed(0)} L.E',
//                 ),
//               _buildTotalRow(
//                 'Delivery Fee:',
//                 '${deliveryFee.toStringAsFixed(0)} L.E',
//               ),
//               const Divider(thickness: 1),
//               _buildTotalRow(
//                 'Total:',
//                 '${finalTotal.toStringAsFixed(0)} L.E',
//                 isTotal: true,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildCartItemsHeader() {
//     return const Row(
//       children: [
//         Icon(Icons.shopping_cart, size: 20, color: Colors.green),
//         SizedBox(width: 8),
//         Text(
//           'Order Items:',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//             color: Colors.green,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTotalRow(String label, String amount, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: isTotal ? 18 : 16,
//               fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               color: isTotal ? Colors.green : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderButton(
//     BuildContext context,
//     OrderCubit cubit,
//     OrderState state,
//   ) {
//     final isLoading = state is OrderLoading;

//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, cartState) {
//         final hasCartItems =
//             cartState is CartLoaded && cartState.cartModel.items.isNotEmpty;
//         final isFormValid = cubit.isFormValid;
//         final hasAddresses = cubit.availableAddresses.isNotEmpty;
//         final canOrder =
//             isFormValid && hasCartItems && hasAddresses && !isLoading;

//         return SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed:
//                 !canOrder
//                     ? null
//                     : () {
//                       cubit.makeOrder();
//                     },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: canOrder ? Colors.green : Colors.grey,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child:
//                 isLoading
//                     ? const SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       ),
//                     )
//                     : Text(
//                       !hasCartItems
//                           ? 'No Items in Cart'
//                           : !hasAddresses
//                           ? 'No Addresses Available'
//                           : !isFormValid
//                           ? 'Complete Order Info'
//                           : 'Make Your Order',
//                       style: TextStyle(
//                         color: canOrder ? Colors.white : Colors.grey.shade600,
//                         fontSize: 18,
//                       ),
//                     ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTimeChip(BuildContext context, OrderCubit cubit, String time) {
//     return BlocBuilder<OrderCubit, OrderState>(
//       builder: (context, state) {
//         final isSelected = cubit.selectedTime == time;

//         return ActionChip(
//           label: Text(
//             time,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
//             ),
//           ),
//           backgroundColor: isSelected ? Colors.green : Colors.grey[200],
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           onPressed: () {
//             cubit.updateSelectedTime(time);
//           },
//         );
//       },
//     );
//   }

//   Future<void> _selectShippingDate(
//     BuildContext context,
//     OrderCubit cubit,
//   ) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 30)),
//     );

//     if (pickedDate != null) {
//       String formattedDate =
//           "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${_getDayOfWeek(pickedDate)}";

//       cubit.updateSelectedDate(formattedDate);
//     }
//   }

//   void _showSuccessDialog(BuildContext context, String message) {
//     showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             title: const Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green, size: 28),
//                 SizedBox(width: 8),
//                 Text('تم تأكيد الطلب'),
//               ],
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(message),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'سيتم مسح السلة تلقائياً',
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close dialog
//                   context.read<CartCubit>().getCartItems(); // Refresh cart
//                   context.read<OrderCubit>().resetForm(); // Reset order form
//                   Navigator.of(context).pop(); // Go back to previous screen
//                 },
//                 child: const Text('موافق'),
//               ),
//             ],
//           ),
//     );
//   }

//   void _showAddressOptions(BuildContext context, OrderCubit cubit) {
//     if (cubit.availableAddresses.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No addresses available. Please add an address first.'),
//           backgroundColor: Colors.orange,
//         ),
//       );
//       return;
//     }

//     showModalBottomSheet<void>(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder:
//           (context) => Container(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Select Address',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 ...cubit.availableAddresses.map(
//                   (address) => Container(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     child: RadioListTile<int>(
//                       title: Text(
//                         '${address.street}\n${address.city}, ${address.id}',
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                       value: address.id,
//                       groupValue: cubit.selectedAddressId,
//                       onChanged: (value) {
//                         if (value != null) {
//                           cubit.updateSelectedAddress(value);
//                           Navigator.of(context).pop();
//                         }
//                       },
//                       activeColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         side: BorderSide(
//                           color:
//                               cubit.selectedAddressId == address.id
//                                   ? Colors.green
//                                   : Colors.grey.shade300,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         child: const Text('Cancel'),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           cubit.refreshAddresses();
//                           Navigator.of(context).pop();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                         ),
//                         child: const Text(
//                           'Refresh',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//     );
//   }

//   void _addNewAddress(BuildContext context, OrderCubit cubit) {
//     // TODO: Navigate to add address screen
//     // After adding new address, refresh the addresses list
//     showDialog<void>(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Add New Address'),
//             content: const Text(
//               'This feature will navigate to add address screen.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//     );
//   }

//   String _getDayOfWeek(DateTime date) {
//     switch (date.weekday) {
//       case 1:
//         return 'Mon';
//       case 2:
//         return 'Tue';
//       case 3:
//         return 'Wed';
//       case 4:
//         return 'Thu';
//       case 5:
//         return 'Fri';
//       case 6:
//         return 'Sat';
//       case 7:
//         return 'Sun';
//       default:
//         return '';
//     }
//   }
// }

// // استبدل دالة _buildCartItemRow بهذا الكود المحدث
// Widget _buildCartItemRow(dynamic item) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 2),
//     child: Row(
//       children: [
//         const SizedBox(width: 28),
//         Expanded(
//           child: Text(
//             // جرب هذه الخيارات حسب البنية الصحيحة لـ CartItemModel
//             '${_getProductName(item)} x${item.quantity ?? 0}',
//             style: const TextStyle(fontSize: 14, color: Colors.grey),
//           ),
//         ),
//         Text(
//           '${_getItemTotal(item).toStringAsFixed(0)} L.E',
//           style: const TextStyle(fontSize: 14, color: Colors.grey),
//         ),
//       ],
//     ),
//   );
// }

// // دالة مساعدة للحصول على اسم المنتج
// String _getProductName(dynamic item) {
//   try {
//     // طباعة بنية البيانات للتحقق (احذف هذا السطر بعد التحقق)
//     print('Item structure: ${item.toString()}');

//     // جرب هذه الخصائص المختلفة حسب البنية الصحيحة
//     if (item?.productName != null) return item.productName.toString();
//     if (item?.name != null) return item.name.toString();
//     if (item?.product?.name != null) return item.product.name.toString();
//     if (item?.title != null) return item.title.toString();

//     // إذا لم تجد أي من هذه الخصائص، استخدم قيمة افتراضية
//     return 'Product';
//   } catch (e) {
//     print('Error getting product name: $e');
//     return 'Product';
//   }
// }

// // دالة مساعدة لحساب إجمالي العنصر
// int _getItemTotal(dynamic item) {
//   final price = item.price ?? 0.0;
//   final quantity = item.quantity ?? 0;
//   return price * quantity;
// }
// ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
// ??????????????????????????????????????????????????????????????????????????????????????
// ??????????????????????????????????????????????????????????????????????????????????????????????
// ???????????????????????????????????????????????????????????????????????????????????
// ?????????????????????????????????????????????????????????????????????????????????????

import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:al_omda/features/order/presentation/screens/make_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OrderCubit>()..initialize()),
        BlocProvider(create: (context) => getIt<CartCubit>()..getCartItems()),
      ],
      child: const MakeOrderView(),
    );
  }
}
