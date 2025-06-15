import 'package:al_omda/features/products/presentation/widgets/add_to_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
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
          AddToCartButton(product: product),
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
