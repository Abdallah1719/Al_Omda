import 'package:flutter/material.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

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
              width: double.infinity, // تأكد من أن الزر يستخدم العرض الكامل
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // مركز النصوص والأيقونات
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
              'Selected Date: 2025-05-04 Sun',
              style: TextStyle(fontSize: 16),
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
                Chip(
                  label: Text('Now - 60 min'),
                  backgroundColor: Colors.grey[200],
                  side: BorderSide(color: Colors.grey),
                ),
                Chip(
                  label: Text('5 - 6 PM'),
                  backgroundColor: Colors.grey[200],
                  side: BorderSide(color: Colors.grey),
                ),
                Chip(
                  label: Text('6 - 7 PM'),
                  backgroundColor: Colors.grey[200],
                  side: BorderSide(color: Colors.grey),
                ),
                Chip(
                  label: Text('7 - 8 PM'),
                  backgroundColor: Colors.grey[200],
                  side: BorderSide(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Select Time',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Bring Change For',
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

            // Coupon Code Section
            // SizedBox(height: 16),
            // Row(
            //   children: [
            //     Icon(Icons.attach_money, color: Colors.green),
            //     SizedBox(width: 8),
            //     Expanded(
            //       child: TextField(
            //         decoration: InputDecoration(
            //           labelText: 'Enter Coupon Code',
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 8),
            //     ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.green,
            //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       ),
            //       child: Text('APPLY', style: TextStyle(color: Colors.white)),
            //     ),
            //   ],
            // ),

            // // Notes Section
            // SizedBox(height: 16),
            // Row(
            //   children: [
            //     Icon(Icons.message, color: Colors.green),
            //     SizedBox(width: 8),
            //     Expanded(
            //       child: TextField(
            //         decoration: InputDecoration(
            //           labelText: 'notes',
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // // Payment Method Section
            // SizedBox(height: 16),
            // Row(
            //   children: [
            //     Checkbox(
            //       value: true,
            //       onChanged: (value) {},
            //       activeColor: Colors.green,
            //     ),
            //     Icon(Icons.attach_money, color: Colors.green),
            //     SizedBox(width: 8),
            //     Text('Cash on delivery', style: TextStyle(fontSize: 16)),
            //   ],
            // ),

            // Total Section
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
              width: double.infinity, // تأكد من أن الزر يستخدم العرض الكامل
              child: ElevatedButton(
                onPressed: () {},
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
}
