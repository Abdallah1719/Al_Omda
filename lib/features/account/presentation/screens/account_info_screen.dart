// import 'package:flutter/material.dart';

// class AccountInfoScreen extends StatelessWidget {
//   const AccountInfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         children: [
//           Text('data'),
//           Text('data'),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [Text('data'), Text('data')],
//           ),
//           TextField(
//             enabled: false,
//             decoration: InputDecoration(
//               labelText: 'البريد الإلكتروني',
//               hintText: 'أدخل بريدك الإلكتروني',

//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             enabled: false,
//             decoration: InputDecoration(
//               labelText: 'البريد الإلكتروني',
//               hintText: 'أدخل بريدك الإلكتروني',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             enabled: false,
//             decoration: InputDecoration(
//               labelText: 'كلمة المرور',
//               hintText: 'أدخل كلمة المرور',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           SizedBox(height: 20),
//           TextField(
//             enabled: false,
//             decoration: InputDecoration(
//               labelText: 'كلمة المرور',
//               hintText: 'أدخل كلمة المرور',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('data'),
//               Text('data'),
//               // Container(
//               //   width: double.infinity, // يجعل الزر يمتد لعرض الشاشة
//               //   height: 50,
//               //   decoration: BoxDecoration(
//               //     border: Border.all(
//               //       color: Colors.blue,
//               //       width: 2,
//               //     ), // الإطار - اللون والسمك
//               //     borderRadius: BorderRadius.circular(8), // زوايا دائرية
//               //   ),
//               //   child: Center(
//               //     child: Text(
//               //       'دخول',
//               //       style: TextStyle(
//               //         color: Colors.blue, // لون النص يطابق لون البوردر
//               //         fontSize: 18,
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('معلومات الحساب')),
      body: BlocProvider(
        create: (context) => getIt<AccountCubit>()..getAccountInfo(),
        child: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AccountSuccess) {
              final account = state.account;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    // --- الاسم ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("الاسم الأول:"), Text(account.firstName)],
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("الاسم الأخير:"), Text(account.lastName)],
                    ),

                    SizedBox(height: 20),

                    // --- البريد الإلكتروني ---
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني',
                        hintText: account.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    SizedBox(height: 20),

                    // --- كلمة المرور (مثال ثابت لأنشوف الشكل فقط) ---
                    TextField(
                      enabled: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'كلمة المرور',
                        hintText: '••••••••',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),

                    SizedBox(height: 20),

                    // --- زر تعديل / تحديث ---
                    ElevatedButton(
                      onPressed: () {
                        // يمكنك هنا التوجيه لشاشة تعديل البيانات
                      },
                      child: Text("تعديل المعلومات"),
                    ),
                  ],
                ),
              );
            } else if (state is AccountError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          () => context.read<AccountCubit>().getAccountInfo(),
                      child: Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
