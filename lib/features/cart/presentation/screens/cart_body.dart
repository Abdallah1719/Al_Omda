// import 'package:al_omda/core/services/service_locator.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<CartCubit>()..getCartItems(),
//       child: Scaffold(
//         appBar: AppBar(title: Text("Cart")),
//         body: BlocBuilder<CartCubit, CartState>(
//           builder: (context, state) {
//             if (state is CartInitial) {
//               // 👇 جلب السلة أول مرة
//               BlocProvider.of<CartCubit>(context).getCartItems();
//               return Center(child: CircularProgressIndicator());
//             } else if (state is CartLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is CartLoaded) {
//               final items = state.items;

//               if (items.isEmpty) {
//                 return Center(child: Text("السلة فارغة"));
//               }

//               return ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return ListTile(
//                     leading: CachedNetworkImage(
//                       imageUrl: item.image,
//                       placeholder:
//                           (context, url) =>
//                               Center(child: CircularProgressIndicator()),
//                       errorWidget:
//                           (context, url, error) => Icon(
//                             Icons.broken_image,
//                             size: 40,
//                             color: Colors.grey,
//                           ),
//                       fit: BoxFit.cover,
//                     ),

//                     title: Text(item.title),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "${item.price} L.E x ${item.quantity} = ${item.price * item.quantity} L.E",
//                         ),
//                         SizedBox(height: 4),
//                         Text("Weight: ${item.weight} ${item.unitName}"),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.remove_circle, color: Colors.red),

//                       onPressed:
//                           () => BlocProvider.of<CartCubit>(
//                             context,
//                           ).removeFromCart(item.productId),
//                     ),
//                   );
//                 },
//               );
//             } else if (state is CartError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(state.message),
//                     SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       onPressed:
//                           () =>
//                               BlocProvider.of<CartCubit>(
//                                 context,
//                               ).getCartItems(),
//                       icon: Icon(Icons.refresh),
//                       label: Text("إعادة المحاولة"),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             return Center(child: Text("لا توجد بيانات"));
//           },
//         ),
//       ),
//     );
//   }
// }

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
      create: (context) => getIt<CartCubit>()..getCartItems(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text("Cart")),
            body: BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'إعادة المحاولة',
                        onPressed: () {
                          if (state is CartLoaded) {
                            context.read<CartCubit>().getCartItems();
                          }
                        },
                      ),
                    ),
                  );
                }
              },
              child: BlocBuilder<CartCubit, CartState>(
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
                            Text(
                              "سلة التسوق فارغة",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: item.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => CircularProgressIndicator(),
                              errorWidget:
                                  (context, url, error) =>
                                      Icon(Icons.shopping_bag),
                            ),
                            title: Text(item.title),
                            subtitle: Text(
                              "${item.price} L.E × ${item.quantity} = ${item.price * item.quantity} L.E",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed:
                                  () => context
                                      .read<CartCubit>()
                                      .removeFromCart(item.productId),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 60, color: Colors.red),
                        SizedBox(height: 20),
                        Text(
                          "حدث خطأ أثناء تحميل السلة",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed:
                              () => context.read<CartCubit>().getCartItems(),
                          child: Text("إعادة المحاولة"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
