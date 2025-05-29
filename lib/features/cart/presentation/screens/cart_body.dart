
import 'package:al_omda/core/services/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Cart")),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              // 👇 جلب السلة أول مرة
              BlocProvider.of<CartCubit>(context).getCartItems();
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              final items = state.items;

              if (items.isEmpty) {
                return Center(child: Text("السلة فارغة"));
              }

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: item.image,
                      placeholder:
                          (context, url) =>
                              Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          ),
                      fit: BoxFit.cover,
                    ),

                    title: Text(item.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.price} L.E x ${item.quantity} = ${item.price * item.quantity} L.E",
                        ),
                        SizedBox(height: 4),
                        Text("Weight: ${item.weight} ${item.unitName}"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),

                      onPressed:
                          () => BlocProvider.of<CartCubit>(
                            context,
                          ).removeFromCart(item.productId),
                    ),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed:
                          () =>
                              BlocProvider.of<CartCubit>(
                                context,
                              ).getCartItems(),
                      icon: Icon(Icons.refresh),
                      label: Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            }
            return Center(child: Text("لا توجد بيانات"));
          },
        ),
      ),
    );
  }
}
