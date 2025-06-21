import 'package:al_omda/features/cart/presentation/widgets/product_item_in_cart.dart';
import 'package:al_omda/features/order/presentation/screens/make_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..getCartItems(),
      child: Scaffold(
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial || state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text("سلة التسوق فارغة", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                );
              }

              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  ...items.map((item) => ProductItemInCart(item: item)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final cubit = context.read<CartCubit>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: cubit,
                                child: const MakeOrderScreen(),
                              ),
                        ),
                      );
                    },
                    child: Text("Make Order"),
                  ),
                ],
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
