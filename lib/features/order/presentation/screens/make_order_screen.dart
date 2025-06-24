import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:al_omda/features/order/presentation/widgets/address_section.dart';
import 'package:al_omda/features/order/presentation/widgets/delivery_fee_section.dart';
import 'package:al_omda/features/order/presentation/widgets/order_button.dart';
import 'package:al_omda/features/order/presentation/widgets/payment_method_section.dart';
import 'package:al_omda/features/order/presentation/widgets/shipping_date_section.dart';
import 'package:al_omda/features/order/presentation/widgets/shipping_time_section.dart';
import 'package:al_omda/features/order/presentation/widgets/totals_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeOrderScreen extends StatelessWidget {
  const MakeOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<OrderCubit>()..initialize()),
        BlocProvider(create: (context) => getIt<CartCubit>()..getCartItems()),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Check out Information')),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<OrderCubit>();

            if (state is OrderLoading && cubit.availableAddresses.isEmpty) {
              return const Center(child: CircularProgressIndicator());
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
        ),
      ),
    );
  }
}
