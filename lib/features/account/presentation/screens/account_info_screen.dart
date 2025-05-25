import 'package:flutter/material.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('data'),
          Text('data'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('data'), Text('data')],
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              hintText: 'أدخل بريدك الإلكتروني',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              hintText: 'أدخل بريدك الإلكتروني',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Row(
            children: [
              Text('data'),
              Container(
                width: double.infinity, // يجعل الزر يمتد لعرض الشاشة
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ), // الإطار - اللون والسمك
                  borderRadius: BorderRadius.circular(8), // زوايا دائرية
                ),
                child: Center(
                  child: Text(
                    'دخول',
                    style: TextStyle(
                      color: Colors.blue, // لون النص يطابق لون البوردر
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
