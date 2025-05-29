import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF35E298), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
            child: SizedBox(
              height: 150,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl:
                      product.image.isNotEmpty
                          ? product.image
                          : 'https://via.placeholder.com/300 ',
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(),
                  errorWidget:
                      (context, url, error) =>
                          Icon(Icons.error, size: 50, color: Colors.red),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                bool isInCart = false;
                int quantity = 0;

                if (state is CartLoaded) {
                  final matchedItems =
                      state.items
                          .where((cartItem) => cartItem.productId == product.id)
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
                              BlocProvider.of<CartCubit>(
                                context,
                              ).updateQuantity(product.id, quantity - 1);
                            } else {
                              BlocProvider.of<CartCubit>(
                                context,
                              ).removeFromCart(product.id);
                            }
                          },
                          icon: Icon(Icons.remove, color: Colors.red),
                        ),
                        Text('$quantity'),
                        IconButton(
                          onPressed:
                              () => BlocProvider.of<CartCubit>(
                                context,
                              ).updateQuantity(product.id, quantity + 1),
                          icon: Icon(Icons.add, color: Colors.green),
                        ),
                      ],
                    )
                    : ElevatedButton.icon(
                      onPressed:
                          () => BlocProvider.of<CartCubit>(
                            context,
                          ).addToCart(product.id),
                      label: Text("Add to Cart"),
                      icon: Icon(Icons.shopping_cart),
                    );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF35E298), width: 1),
                color: const Color(0xFF35E298),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: SizeConfig.defaultSize! * 12,
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Text(
                        '${product.price} L.E',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.weight,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.unitName,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
