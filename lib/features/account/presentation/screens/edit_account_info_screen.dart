// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';

// // class EditAccountInfoScreen extends StatelessWidget {
// //   const EditAccountInfoScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final cubit = BlocProvider.of<AccountCubit>(context);
// //     return BlocBuilder<AccountCubit, AccountState>(
// //       builder: (context, state) {
// //         if (state is AccountEditing) {
// //           final firstNameCtrl = state.firstNameController;
// //           final lastNameCtrl = state.lastNameController;
// //           final emailCtrl = state.emailController;

// //           return Scaffold(
// //             appBar: AppBar(title: Text("تعديل المعلومات")),
// //             body: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: ListView(
// //                 children: [
// //                   TextField(
// //                     controller: firstNameCtrl,
// //                     decoration: InputDecoration(labelText: "الاسم الأول"),
// //                   ),
// //                   SizedBox(height: 16),

// //                   TextField(
// //                     controller: lastNameCtrl,
// //                     decoration: InputDecoration(labelText: "الاسم الأخير"),
// //                   ),
// //                   SizedBox(height: 16),

// //                   TextField(
// //                     controller: emailCtrl,
// //                     decoration: InputDecoration(labelText: "البريد الإلكتروني"),
// //                   ),

// //                   SizedBox(height: 32),

// //                   ElevatedButton(
// //                     onPressed: () {
// //                       cubit.updateProfileInfo(
// //                         firstNameController: firstNameCtrl,
// //                         lastNameController: lastNameCtrl,
// //                         emailController: emailCtrl,
// //                       );
// //                       Navigator.pop(
// //                         context,
// //                       ); // رجوع للصفحة الرئيسية بعد التحديث
// //                     },
// //                     child: Text("حفظ التعديلات"),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }
// //         return Container(); // أو صفحة Loading إن احتجت
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';

// class EditAccountInfoScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>(); // <-- Form Key

//   EditAccountInfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<AccountCubit>(context);
//     return BlocBuilder<AccountCubit, AccountState>(
//       builder: (context, state) {
//         if (state is AccountEditing) {
//           final firstNameCtrl = state.firstNameController;
//           final lastNameCtrl = state.lastNameController;
//           final emailCtrl = state.emailController;

//           return Scaffold(
//             appBar: AppBar(title: Text("تعديل المعلومات")),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     TextFormField(
//                       controller: firstNameCtrl,
//                       decoration: InputDecoration(labelText: "الاسم الأول"),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "الاسم الأول مطلوب";
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),

//                     TextFormField(
//                       controller: lastNameCtrl,
//                       decoration: InputDecoration(labelText: "الاسم الأخير"),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "الاسم الأخير مطلوب";
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),

//                     TextFormField(
//                       controller: emailCtrl,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         labelText: "البريد الإلكتروني",
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "البريد الإلكتروني مطلوب";
//                         } else if (!value.contains('@')) {
//                           return "البريد الإلكتروني غير صحيح";
//                         }
//                         return null;
//                       },
//                     ),

//                     SizedBox(height: 32),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           // طباعة القيم قبل الإرسال
//                           print("FirstName: ${firstNameCtrl.text}");
//                           print("LastName: ${lastNameCtrl.text}");
//                           print("email: ${emailCtrl.text}");

//                           // إرسال البيانات
//                           cubit.updateProfileInfo(
//                             firstNameController: firstNameCtrl,
//                             lastNameController: lastNameCtrl,
//                             emailController: emailCtrl,
//                           );

//                           Navigator.pop(context);
//                         }
//                       },
//                       child: Text("حفظ التعديلات"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         ); // Loading أو صفحة خطأ حسب الحاجة
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';

class EditAccountInfoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // <-- Form Key

  EditAccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AccountCubit>(context);
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        if (state is AccountEditing) {
          final firstNameCtrl = state.firstNameController;
          final lastNameCtrl = state.lastNameController;
          final emailCtrl = state.emailController;

          return Scaffold(
            appBar: AppBar(title: Text("تعديل المعلومات")),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: firstNameCtrl,
                      decoration: InputDecoration(labelText: "الاسم الأول"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الاسم الأول مطلوب";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: lastNameCtrl,
                      decoration: InputDecoration(labelText: "الاسم الأخير"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الاسم الأخير مطلوب";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "البريد الإلكتروني",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "البريد الإلكتروني مطلوب";
                        } else if (!value.contains('@')) {
                          return "البريد الإلكتروني غير صحيح";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // إرسال البيانات
                          cubit.updateProfileInfo(
                            firstNameController: firstNameCtrl,
                            lastNameController: lastNameCtrl,
                            emailController: emailCtrl,
                          );

                          // عرض رسالة نجاح
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("تم تحديث المعلومات بنجاح")),
                          );

                          // إعادة تحميل بيانات الحساب
                          cubit.getAccountInfo();

                          // العودة للصفحة السابقة
                          Navigator.pop(context);
                        }
                      },
                      child: Text("حفظ التعديلات"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // حالة التحميل
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
