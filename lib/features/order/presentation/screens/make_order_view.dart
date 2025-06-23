import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';

import '../widgets/address_section.dart';
import '../widgets/delivery_fee_section.dart';
import '../widgets/shipping_date_section.dart';
import '../widgets/shipping_time_section.dart';
import '../widgets/payment_method_section.dart';
import '../widgets/totals_section.dart';
import '../widgets/order_button.dart';

class MakeOrderView extends StatefulWidget {
  const MakeOrderView({super.key});

  @override
  State<MakeOrderView> createState() => _MakeOrderViewState();
}

class _MakeOrderViewState extends State<MakeOrderView> {
  // Static data
  static const double deliveryFee = 20.0;
  static const double discountValue = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartCubit = context.read<CartCubit>();
      if (cartCubit.state is! CartLoaded) {
        cartCubit.getCartItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check out Information'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          } 
          else if (state is OrderBalanceError) {
            _showBalanceErrorDialog(context, state.message);
          }
          else if (state is OrderSuccess) {
            _showSuccessDialog(context, state.message);
          }
        
        },
        builder: (context, state) {
          final cubit = context.read<OrderCubit>();

          if (state is OrderLoading && cubit.availableAddresses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              if (cartState is CartLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading cart items...'),
                    ],
                  ),
                );
              }

              if (cartState is CartError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 48, color: Colors.red),
                      SizedBox(height: 16),
                      Text('Error loading cart: ${cartState.message}'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed:
                            () => context.read<CartCubit>().getCartItems(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (cartState is CartLoaded &&
                  cartState.cartModel.items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text('Your cart is empty'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddressSection(cubit: cubit),
                    const SizedBox(height: 16),
                    const DeliveryFeeSection(),
                    const SizedBox(height: 16),
                    ShippingDateSection(cubit: cubit),
                    const SizedBox(height: 16),
                    ShippingTimeSection(cubit: cubit),
                    const SizedBox(height: 16),
                    PaymentMethodSection(cubit: cubit),
                    const SizedBox(height: 16),
                    const TotalsSection(),
                    const SizedBox(height: 24),
                    OrderButton(cubit: cubit, state: state),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text('تم تأكيد الطلب'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 8),
                const Text(
                  'سيتم مسح السلة تلقائياً',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<CartCubit>().getCartItems();
                  context.read<OrderCubit>().resetForm();
                  Navigator.of(context).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
    );
  }
}


  void _showBalanceErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Insufficient Balance'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          // يمكنك إضافة خيار للذهاب لشحن الرصيد هنا
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // انتقل لشاشة شحن الرصيد
              // Navigator.push(context, MaterialPageRoute(builder: (_) => AddBalanceScreen()));
            },
            child: const Text('Add Balance'),
          ),
        ],
      ),
    );
  }