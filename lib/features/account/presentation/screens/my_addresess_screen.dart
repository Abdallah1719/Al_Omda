import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';

class MyAddresessScreen extends StatelessWidget {
  const MyAddresessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountCubit>()..getMyAddresess(),
      child: Scaffold(
        appBar: AppBar(title: Text('My Addresess'), centerTitle: true),
        body: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            if (state is AccountLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MyAddressesLoaded) {
              final List<MyAddresessModel> addresses =
                  state.myAddresessList.addresses;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: addresses.length + 1,
                  itemBuilder: (context, index) {
                    if (index < addresses.length) {
                      final address = addresses[index];

                      return Card(
                        margin: EdgeInsets.only(bottom: 12),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            address.city,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(address.street),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[400]),
                            onPressed: () {
                              // TODO: استخدم Cubit لحذف هذا العنوان
                            },
                          ),
                        ),
                      );
                    } else {
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.add),
                        label: Text("إضافة عنوان جديد"),
                        onPressed: () {
                          // TODO: افتح صفحة إضافة عنوان جديد
                        },
                      );
                    }
                  },
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
                          () => context.read<AccountCubit>().getMyAddresess(),
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
