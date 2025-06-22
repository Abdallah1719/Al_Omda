import 'package:al_omda/features/cart/presentation/widgets/cart_summary_widgets.dart';
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
        appBar: AppBar(title: Text("سلة التسوق")),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial || state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final cartModel = state.cartModel;

              if (cartModel.isEmpty) {
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

              return Column(
                children: [
                  // قائمة المنتجات
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: cartModel.items.length,
                      itemBuilder: (context, index) {
                        return ProductItemInCart(item: cartModel.items[index]);
                      },
                    ),
                  ),

                  // الملخص الإجمالي
                  CartSummaryWidget(summary: cartModel.summary),

                  // زر الطلب
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
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
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "إتمام الطلب",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red),
                    SizedBox(height: 20),
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().getCartItems(),
                      child: Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
