// import 'package:al_omda/core/services/service_locator.dart';
// import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
// import 'package:al_omda/features/account/presentation/screens/edit_account_info_screen.dart';
// import 'package:al_omda/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AccountInfoScreen extends StatelessWidget {
//   const AccountInfoScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create:
//           (context) =>
//               getIt<AccountCubit>()
//                 ..getAccountInfo()
//                 ..updateAccountInfo,
//       child: Scaffold(
//         appBar: AppBar(title: Text(S.of(context).account_info)),
//         body: BlocBuilder<AccountCubit, AccountState>(
//           builder: (context, state) {
//             if (state is AccountLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is AccountInfoLoaded) {
//               final accountInfo = state.accountInfo;
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListView(
//                   children: [
//                     TextField(
//                       enabled: false,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).first_name,
//                         hintText: accountInfo.firstName,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       enabled: false,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).last_name,
//                         hintText: accountInfo.lastName,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     TextField(
//                       enabled: false,
//                       decoration: InputDecoration(
//                         labelText: S.of(context).email,
//                         hintText: accountInfo.email,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // الحصول على الـ cubit بالطريقة الصحيحة
//                         final cubit = context.read<AccountCubit>();

//                         // الانتقال لشاشة التعديل مع تمرير البيانات
//                         final result = await Navigator.push<bool>(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) => BlocProvider.value(
//                                   value: cubit,
//                                   child: EditAccountInfoScreen(
//                                     accountInfo:
//                                         accountInfo, // تمرير البيانات الحالية
//                                   ),
//                                 ),
//                           ),
//                         );

//                         // إذا تم التحديث بنجاح، أعد تحميل البيانات
//                         if (result == true) {
//                           cubit.getAccountInfo();
//                         }
//                       },
//                       child: Text(S.of(context).edit_info),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is AccountError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [Text(state.message), SizedBox(height: 16)],
//                 ),
//               );
//             } else {
//               return SizedBox.shrink();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:al_omda/features/account/presentation/screens/edit_account_info_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountCubit>()..getAccountInfo(), // إزالة ..updateAccountInfo
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).account_info)),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AccountInfoLoaded) {
              final accountInfo = state.accountInfo;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: S.of(context).first_name,
                        hintText: accountInfo.firstName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: S.of(context).last_name,
                        hintText: accountInfo.lastName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        hintText: accountInfo.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final cubit = context.read<AccountCubit>();

                        // الانتقال لشاشة التعديل
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: EditAccountInfoScreen(
                                accountInfo: accountInfo,
                              ),
                            ),
                          ),
                        );

                        // إعادة تحميل البيانات بعد التعديل
                        if (result == true) {
                          cubit.getAccountInfo();
                        }
                      },
                      child: Text(S.of(context).edit_info),
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
                      onPressed: () {
                        context.read<AccountCubit>().getAccountInfo();
                      },
                      child: Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}