import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final matchedItem = state.productsInCart.firstWhereOrNull(
            (item) => item.id == product.id,
          );
          final isInCart = matchedItem != null;
          final quantity = matchedItem?.quantity ?? 0;
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
                        context.read<ProductsCubit>().addProductToCart(
                          product.id,
                          quantity - 1,
                        );
                      } else {
                        context.read<ProductsCubit>().removeProductFromCart(
                          product.id,
                        );
                      }
                    },
                    icon: Icon(Icons.remove, color: Colors.red),
                  ),
                  Text('$quantity'),
                  IconButton(
                    onPressed: () {
                      context.read<ProductsCubit>().addProductToCart(
                        product.id,
                        quantity + 1,
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.green),
                  ),
                ],
              )
              : ElevatedButton.icon(
                onPressed: () {
                  context.read<ProductsCubit>().addProductToCart(product.id, 1);
                },
                label: Text("Add to Cart"),
                icon: Icon(Icons.shopping_cart),
              );
        },
      ),
    );
  }
}

extension ListExtensions<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
