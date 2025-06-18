import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..addToCart,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            bool isInCart = false;
            int quantity = 0;

            if ( state.productsByCategoryNameState == RequestState.loaded) {
            
              // final matchedItems =
              //     state.productsInCart
              //         .where((productsInCart) => productsInCart.productId == product.id)
              //         .toList();
              final matchedItems = state.productsInCart
    .where((item) => item.productId == product.id)
    .toList();

              isInCart = matchedItems.isNotEmpty;
              quantity =
                  matchedItems.isNotEmpty ? matchedItems.first.quantity : 0;
            }

            return !product.inStock
                ? Text(
                  "Out of stock",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                )
                : isInCart
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          getIt<ProductsCubit>().addToCart(
                            product.id,
                            quantity - 1,
                          );
                        } else {
                          getIt<CartCubit>().removeFromCart(product.id);
                        }
                      },
                      icon: Icon(Icons.remove, color: Colors.red),
                    ),
                    Text('$quantity'),
                    IconButton(
                      onPressed:
                          () => BlocProvider.of<ProductsCubit>(
                            context,
                          ).addToCart(product.id, quantity + 1),
                      icon: Icon(Icons.add, color: Colors.green),
                    ),
                  ],
                )
                : ElevatedButton.icon(
                  onPressed:
                      () => BlocProvider.of<ProductsCubit>(
                        context,
                      ).addToCart(product.id, quantity + 1),
                  label: Text("Add to Cart"),
                  icon: Icon(Icons.shopping_cart),
                );
          },
        ),
      ),
    );
  }
}
