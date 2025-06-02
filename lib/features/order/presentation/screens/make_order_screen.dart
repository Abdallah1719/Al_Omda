// import 'package:flutter/material.dart';

// class MakeOrderScreen extends StatefulWidget {
//   const MakeOrderScreen({super.key});

//   @override
//   State<MakeOrderScreen> createState() => _MakeOrderScreenState();
// }

// class _MakeOrderScreenState extends State<MakeOrderScreen> {
//   String? selectedDate;

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
//                 Chip(
//                   label: Text('Now - 60 min'),
//                   backgroundColor: Colors.grey[200],
//                   side: BorderSide(color: Colors.grey),
//                 ),
//                 Chip(
//                   label: Text('5 - 6 PM'),
//                   backgroundColor: Colors.grey[200],
//                   side: BorderSide(color: Colors.grey),
//                 ),
//                 Chip(
//                   label: Text('6 - 7 PM'),
//                   backgroundColor: Colors.grey[200],
//                   side: BorderSide(color: Colors.grey),
//                 ),
//                 Chip(
//                   label: Text('7 - 8 PM'),
//                   backgroundColor: Colors.grey[200],
//                   side: BorderSide(color: Colors.grey),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Select Time',
//               style: TextStyle(color: Colors.red, fontSize: 16),
//             ),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 labelText: 'Bring Change For',
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
//                 onPressed: () {},
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

import 'package:flutter/material.dart';

class MakeOrderScreen extends StatefulWidget {
  const MakeOrderScreen({super.key});

  @override
  State<MakeOrderScreen> createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  String? selectedDate;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check out Information'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            Text(
              'Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'new cairo\nRehab-city\nbbbnhgh',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 18),
                Text('Or', style: TextStyle(fontSize: 16)),
                Icon(Icons.add, size: 18),
                Text(
                  'Add New Address',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'make sure this address is correct.',
              style: TextStyle(fontSize: 14, color: Colors.green),
            ),

            // Delivery Fee Section
            SizedBox(height: 16),
            Text(
              'Delivery Fee:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('20 L.E', style: TextStyle(fontSize: 16)),

            // Shipping Date Section
            SizedBox(height: 16),
            Text(
              'Select Shipping Day',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${_getDayOfWeek(pickedDate)}";

                    setState(() {
                      selectedDate = formattedDate;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Row(
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
            SizedBox(height: 8),
            Text(
              selectedDate ?? 'No Date Selected',
              style: TextStyle(
                fontSize: 16,
                color: selectedDate != null ? Colors.black : Colors.red,
              ),
            ),

            // Shipping Time Section
            SizedBox(height: 16),
            Text(
              'Shipping Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTimeChip('Now - 60 min'),
                _buildTimeChip('5 - 6 PM'),
                _buildTimeChip('6 - 7 PM'),
                _buildTimeChip('7 - 8 PM'),
              ],
            ),
            SizedBox(height: 8),
            if (selectedTime == null)
              Text(
                'Select Time',
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            else
              Text(
                'Selected Time: $selectedTime',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

            // Shipping Time Dropdown (if needed later)
            SizedBox(height: 16),
            Text('Bring Change For', style: TextStyle(fontSize: 16)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items:
                  ['Option 1', 'Option 2'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {},
            ),

            // Totals Section
            SizedBox(height: 16),
            Text('TOTAL : 49 L.E', style: TextStyle(fontSize: 16)),
            Text('Discount Value: : 0 L.E', style: TextStyle(fontSize: 16)),
            Text('Delivery Fee: 20 L.E', style: TextStyle(fontSize: 16)),
            Text(
              'Total + Delivery Fee: : 69 L.E',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),

            // Order Button
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select date and time')),
                    );
                  } else {
                    // TODO: Submit order
                    print(
                      "Order Confirmed with Date: $selectedDate and Time: $selectedTime",
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Make Your Order',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get day of week
  String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Build Chip for time selection
  Widget _buildTimeChip(String time) {
    return ActionChip(
      label: Text(time),
      backgroundColor:
          selectedTime == time
              ? Colors.green.withOpacity(0.3)
              : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        setState(() {
          selectedTime = time;
        });
      },
    );
  }
}
