import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:al_omda/features/account/presentation/screens/edit_account_info_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).account_info)),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AccountSuccess) {
            final account = state.accountInfo;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).first_name),
                      Text(account.firstName),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).last_name),
                      Text(account.lastName),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: S.of(context).first_name,
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
                      labelText: S.of(context).last_name,
                      hintText: account.lastName,
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
                      final cubit = context.read<AccountCubit>();
                      cubit.navigateToEditScreen();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: cubit,
                                child: EditAccountInfoScreen(),
                              ),
                        ),
                      );
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
                children: [Text(state.message), SizedBox(height: 16)],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
