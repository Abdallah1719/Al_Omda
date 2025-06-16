import 'package:al_omda/core/services/service_locator.dart';

import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<AccountCubit>()..getOrders(),
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state is AccountError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is AccountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyOrdersLoaded) {
              final orders = state.myOrdersList.orders;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    title: Text('Invoice Number: ${order.id}'),
                    subtitle: Text(order.date),
                    trailing: Text(
                      order.status,
                      style: TextStyle(
                        color:
                            order.status == 'paid' ? Colors.green : Colors.red,
                      ),
                    ),
                  );
                },
              );
            } else if (state is AccountError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => context.read<AccountCubit>().getOrders(),
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              );
            } else {
              // حالة افتراضية إذا لم يتم العثور على حالة مناسبة
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ),
    );
  }
}
