import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItemInCart extends StatelessWidget {
  const ProductItemInCart({super.key, required this.item});
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: item.image,
          width: 60,
          height: 60,
          fit: BoxFit.fill,
          placeholder: (_, _) => CircularProgressIndicator(),
          errorWidget: (_, _, _) => Icon(Icons.shopping_bag),
        ),
        title: Text(item.title),
        subtitle: Text(
          "////${item.price} L.E × ${item.quantity} = ${(item.price * item.quantity)} L.E",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<CartCubit>().removeItemInstantly(item.productId);
          },
        ),
      ),
    );
  }
}
