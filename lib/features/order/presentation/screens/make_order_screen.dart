

// import 'package:flutter/material.dart';

// class MakeOrderScreen extends StatefulWidget {
//   const MakeOrderScreen({super.key});

//   @override
//   State<MakeOrderScreen> createState() => _MakeOrderScreenState();
// }

// class _MakeOrderScreenState extends State<MakeOrderScreen> {
//   String? selectedDate;
//   String? selectedTime;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Check out Information'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Address Section
//             Text(
//               'Address',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'new cairo\nRehab-city\nbbbnhgh',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward_ios, size: 18),
//                 Text('Or', style: TextStyle(fontSize: 16)),
//                 Icon(Icons.add, size: 18),
//                 Text(
//                   'Add New Address',
//                   style: TextStyle(fontSize: 16, color: Colors.green),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4),
//             Text(
//               'make sure this address is correct.',
//               style: TextStyle(fontSize: 14, color: Colors.green),
//             ),

//             // Delivery Fee Section
//             SizedBox(height: 16),
//             Text(
//               'Delivery Fee:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text('20 L.E', style: TextStyle(fontSize: 16)),

//             // Shipping Date Section
//             SizedBox(height: 16),
//             Text(
//               'Select Shipping Day',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   final DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2030),
//                   );
//                   if (pickedDate != null) {
//                     String formattedDate =
//                         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${_getDayOfWeek(pickedDate)}";

//                     setState(() {
//                       selectedDate = formattedDate;
//                     });
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                 ),
//                 child: Row(
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
//             SizedBox(height: 8),
//             Text(
//               selectedDate ?? 'No Date Selected',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: selectedDate != null ? Colors.black : Colors.red,
//               ),
//             ),

//             // Shipping Time Section
//             SizedBox(height: 16),
//             Text(
//               'Shipping Time',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 _buildTimeChip('Now - 60 min'),
//                 _buildTimeChip('5 - 6 PM'),
//                 _buildTimeChip('6 - 7 PM'),
//                 _buildTimeChip('7 - 8 PM'),
//               ],
//             ),
//             SizedBox(height: 8),
//             if (selectedTime == null)
//               Text(
//                 'Select Time',
//                 style: TextStyle(color: Colors.red, fontSize: 16),
//               )
//             else
//               Text(
//                 'Selected Time: $selectedTime',
//                 style: TextStyle(fontSize: 16, color: Colors.black),
//               ),

//             // Shipping Time Dropdown (if needed later)
//             SizedBox(height: 16),
//             Text('Bring Change For', style: TextStyle(fontSize: 16)),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               items:
//                   ['Option 1', 'Option 2'].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//               onChanged: (value) {},
//             ),

//             // Totals Section
//             SizedBox(height: 16),
//             Text('TOTAL : 49 L.E', style: TextStyle(fontSize: 16)),
//             Text('Discount Value: : 0 L.E', style: TextStyle(fontSize: 16)),
//             Text('Delivery Fee: 20 L.E', style: TextStyle(fontSize: 16)),
//             Text(
//               'Total + Delivery Fee: : 69 L.E',
//               style: TextStyle(fontSize: 18, color: Colors.green),
//             ),

//             // Order Button
//             SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (selectedDate == null || selectedTime == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Please select date and time')),
//                     );
//                   } else {
//                     // TODO: Submit order
//                     print(
//                       "Order Confirmed with Date: $selectedDate and Time: $selectedTime",
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Make Your Order',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper function to get day of week
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

//   // Build Chip for time selection
//   Widget _buildTimeChip(String time) {
//     return ActionChip(
//       label: Text(time),
//       backgroundColor:
//           selectedTime == time
//               ? Colors.green.withOpacity(0.3)
//               : Colors.grey[200],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       onPressed: () {
//         setState(() {
//           selectedTime = time;
//         });
//       },
//     );
//   }
// }


import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/order/presentation/cubit/order_cubit.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(),
      child: const MakeOrderView(),
    );
  }
}

class MakeOrderView extends StatelessWidget {
  const MakeOrderView({super.key});

  // بيانات وهمية - في التطبيق الحقيقي هتيجي من state management أو API
  static const int currentAddressId = 1;
  static const String currentAddress = 'new cairo\nRehab-city\nbbbnhgh';
  static const double deliveryFee = 20.0;
  static const double totalAmount = 49.0;
  static const double discountValue = 0.0;

  // Payment methods
  static const List<Map<String, dynamic>> paymentMethods = [
    {'id': 1, 'name': 'Cash on Delivery', 'icon': Icons.money},
    {'id': 2, 'name': 'Credit Card', 'icon': Icons.credit_card},
    {'id': 3, 'name': 'Mobile Wallet', 'icon': Icons.phone_android},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out Information'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is OrderSuccess) {
            _showSuccessDialog(context, state.message);
          }
        },
        builder: (context, state) {
          final cubit = context.read<OrderCubit>();
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddressSection(context, cubit),
                const SizedBox(height: 16),
                _buildDeliveryFeeSection(),
                const SizedBox(height: 16),
                _buildShippingDateSection(context, cubit),
                const SizedBox(height: 16),
                _buildShippingTimeSection(context, cubit),
                const SizedBox(height: 16),
                _buildPaymentMethodSection(context, cubit),
                const SizedBox(height: 16),
                _buildTotalsSection(),
                const SizedBox(height: 24),
                _buildOrderButton(context, cubit, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context, OrderCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  currentAddress,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _showAddressOptions(context),
                    child: const Row(
                      children: [
                        Icon(Icons.edit, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Change',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _addNewAddress(context),
                    child: const Row(
                      children: [
                        Icon(Icons.add, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Add New',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Make sure this address is correct.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDeliveryFeeSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Fee:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '${deliveryFee} L.E',
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
      ],
    );
  }

  Widget _buildShippingDateSection(BuildContext context, OrderCubit cubit) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedDate = cubit.selectedDate;
        final dateError = cubit.validateDate(selectedDate);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Shipping Day',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectShippingDate(context, cubit),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Select Shipping Date',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dateError == null ? Colors.green.shade50 : Colors.red.shade50,
                border: Border.all(
                  color: dateError == null ? Colors.green : Colors.red,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate ?? 'No Date Selected',
                style: TextStyle(
                  fontSize: 16,
                  color: dateError == null ? Colors.green.shade700 : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (dateError != null) ...[
              const SizedBox(height: 4),
              Text(
                dateError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildShippingTimeSection(BuildContext context, OrderCubit cubit) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedTime = cubit.selectedTime;
        final timeError = cubit.validateTime(selectedTime);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTimeChip(context, cubit, 'Now - 60 min'),
                _buildTimeChip(context, cubit, '5 - 6 PM'),
                _buildTimeChip(context, cubit, '6 - 7 PM'),
                _buildTimeChip(context, cubit, '7 - 8 PM'),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: timeError == null ? Colors.green.shade50 : Colors.red.shade50,
                border: Border.all(
                  color: timeError == null ? Colors.green : Colors.red,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedTime != null 
                    ? 'Selected Time: $selectedTime' 
                    : 'Please Select Time',
                style: TextStyle(
                  fontSize: 16,
                  color: timeError == null ? Colors.green.shade700 : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (timeError != null) ...[
              const SizedBox(height: 4),
              Text(
                timeError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context, OrderCubit cubit) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedPaymentMethod = cubit.selectedPaymentMethod;
        final paymentError = cubit.validatePaymentMethod(selectedPaymentMethod);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...paymentMethods.map((method) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: RadioListTile<String>(
                title: Row(
                  children: [
                    Icon(method['icon'], size: 20),
                    const SizedBox(width: 8),
                    Text(method['name']),
                  ],
                ),
                value: method['id'].toString(),
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  if (value != null) {
                    cubit.updatePaymentMethod(value);
                  }
                },
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: selectedPaymentMethod == method['id'].toString() 
                        ? Colors.green 
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            )).toList(),
            if (paymentError != null) ...[
              const SizedBox(height: 4),
              Text(
                paymentError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTotalsSection() {
    const double finalTotal = totalAmount + deliveryFee - discountValue;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildTotalRow('Subtotal:', '${totalAmount.toStringAsFixed(0)} L.E'),
          _buildTotalRow('Discount:', '-${discountValue.toStringAsFixed(0)} L.E'),
          _buildTotalRow('Delivery Fee:', '${deliveryFee.toStringAsFixed(0)} L.E'),
          const Divider(thickness: 1),
          _buildTotalRow(
            'Total:', 
            '${finalTotal.toStringAsFixed(0)} L.E',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderButton(BuildContext context, OrderCubit cubit, OrderState state) {
    final isLoading = state is OrderLoading;
    final isFormValid = cubit.isFormValid;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : () {
          // Set address first (in real app, this would be set earlier)
          cubit.updateSelectedAddress(currentAddressId);
          cubit.makeOrder();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isFormValid ? Colors.green : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Make Your Order',
                style: TextStyle(
                  color: isFormValid ? Colors.white : Colors.grey.shade600,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }

  Widget _buildTimeChip(BuildContext context, OrderCubit cubit, String time) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final isSelected = cubit.selectedTime == time;
        
        return ActionChip(
          label: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          backgroundColor: isSelected ? Colors.green : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
            cubit.updateSelectedTime(time);
          },
        );
      },
    );
  }

  Future<void> _selectShippingDate(BuildContext context, OrderCubit cubit) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    
    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${_getDayOfWeek(pickedDate)}";

      cubit.updateSelectedDate(formattedDate);
    }
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('تم تأكيد الطلب'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to previous screen
            },
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showAddressOptions(BuildContext context) {
    // Navigate to address selection screen
    print('Navigate to address selection');
  }

  void _addNewAddress(BuildContext context) {
    // Navigate to add new address screen
    print('Navigate to add new address');
  }

  String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}