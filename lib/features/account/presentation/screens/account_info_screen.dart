import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:al_omda/features/account/presentation/screens/edit_account_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('معلومات الحساب')),
      body: BlocProvider(
        create:
            (context) =>
                getIt<AccountCubit>()
                  ..getAccountInfo()
                  ..navigateToEditScreen(),
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

                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'first name',
                        hintText: account.firstName,
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
                        labelText: 'last name',
                        hintText: account.lastName,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
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

                    ElevatedButton(
                      onPressed: () {
                        // اقرأ الـ Cubit أولًا
                        final cubit = context.read<AccountCubit>();

                        // غير الحالة إن احتاج
                        cubit.navigateToEditScreen();

                        // افتح الشاشة مع توريث الـ Cubit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BlocProvider.value(
                                  value:
                                      cubit, // استخدم المتغير اللي قرأناه فوق
                                  child: EditAccountInfoScreen(),
                                ),
                          ),
                        );
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
                  children: [Text(state.message), SizedBox(height: 16)],
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
