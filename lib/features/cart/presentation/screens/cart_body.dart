// // import 'package:al_omda/core/services/service_locator.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

// // class CartScreen extends StatelessWidget {
// //   const CartScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(
// //       create: (context) => getIt<CartCubit>()..getCartItems(),
// //       child: Builder(
// //         builder: (context) {
// //           return Scaffold(
// //             appBar: AppBar(title: Text("Cart")),
// //             body: BlocListener<CartCubit, CartState>(
// //               listener: (context, state) {
// //                 if (state is CartError) {
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(
// //                       content: Text(state.message),
// //                       duration: Duration(seconds: 3),
// //                       action: SnackBarAction(
// //                         label: 'إعادة المحاولة',
// //                         onPressed: () {
// //                           if (state is CartLoaded) {
// //                             context.read<CartCubit>().getCartItems();
// //                           }
// //                         },
// //                       ),
// //                     ),
// //                   );
// //                 }
// //               },
// //               child: BlocBuilder<CartCubit, CartState>(
// //                 builder: (context, state) {
// //                   if (state is CartInitial || state is CartLoading) {
// //                     return Center(child: CircularProgressIndicator());
// //                   } else if (state is CartLoaded) {
// //                     final items = state.items;

// //                     if (items.isEmpty) {
// //                       return Center(
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               Icons.shopping_cart_outlined,
// //                               size: 80,
// //                               color: Colors.grey,
// //                             ),
// //                             SizedBox(height: 20),
// //                             Text(
// //                               "سلة التسوق فارغة",
// //                               style: TextStyle(fontSize: 18),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }

// //                     return ListView.builder(
// //                       itemCount: items.length,
// //                       itemBuilder: (context, index) {
// //                         final item = items[index];
// //                         return Card(
// //                           margin: EdgeInsets.symmetric(
// //                             vertical: 8,
// //                             horizontal: 16,
// //                           ),
// //                           child: ListTile(
// //                             leading: CachedNetworkImage(
// //                               imageUrl: item.image,
// //                               width: 60,
// //                               height: 60,
// //                               fit: BoxFit.cover,
// //                               placeholder:
// //                                   (context, url) => CircularProgressIndicator(),
// //                               errorWidget:
// //                                   (context, url, error) =>
// //                                       Icon(Icons.shopping_bag),
// //                             ),
// //                             title: Text(item.title),
// //                             subtitle: Text(
// //                               "${item.price} L.E × ${item.quantity} = ${item.price * item.quantity} L.E",
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                             trailing: IconButton(
// //                               icon: Icon(Icons.delete, color: Colors.red),
// //                               onPressed:
// //                                   () => context
// //                                       .read<CartCubit>()
// //                                       .removeFromCart(item.productId),
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   }
// //                   return Center(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(Icons.error_outline, size: 60, color: Colors.red),
// //                         SizedBox(height: 20),
// //                         Text(
// //                           "حدث خطأ أثناء تحميل السلة",
// //                           style: TextStyle(fontSize: 18),
// //                         ),
// //                         SizedBox(height: 10),
// //                         ElevatedButton(
// //                           onPressed:
// //                               () => context.read<CartCubit>().getCartItems(),
// //                           child: Text("إعادة المحاولة"),
// //                         ),
// //                       ],
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/core/services/service_locator.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<CartCubit>()..getCartItems(),
//       child: Builder(
//         builder: (context) {
//           final cubit = context.read<CartCubit>();

//           return Scaffold(
//             appBar: AppBar(title: Text("سلة التسوق")),
//             body: BlocListener<CartCubit, CartState>(
//               listener: (context, state) {
//                 if (state is CartError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(state.message),
//                       duration: Duration(seconds: 3),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               child: BlocBuilder<CartCubit, CartState>(
//                 builder: (context, state) {
//                   if (state is CartInitial || state is CartLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state is CartLoaded) {
//                     final items = state.items;

//                     if (items.isEmpty) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.shopping_cart_outlined,
//                                 size: 80, color: Colors.grey),
//                             SizedBox(height: 20),
//                             Text(
//                               "سلة التسوق فارغة",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ],
//                         ),
//                       );
//                     }

//                     return ListView(
//                       padding: EdgeInsets.all(16),
//                       children: [
//                         // --- عرض المنتجات ---
//                         ...items.map((item) => Card(
//                               margin: EdgeInsets.symmetric(vertical: 8),
//                               child: ListTile(
//                                 leading: CachedNetworkImage(
//                                   imageUrl: item.image,
//                                   width: 60,
//                                   height: 60,
//                                   fit: BoxFit.cover,
//                                   placeholder: (_, __) =>
//                                       CircularProgressIndicator(),
//                                   errorWidget: (_, __, ___) =>
//                                       Icon(Icons.shopping_bag),
//                                 ),
//                                 title: Text(item.title),
//                                 subtitle: Text(
//                                   "${item.price} L.E × ${item.quantity} = ${(item.price * item.quantity)} L.E",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 trailing: IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () =>
//                                       cubit.removeFromCart(item.productId),
//                                 ),
//                               ),
//                             )),
//                         SizedBox(height: 20),

//                         // --- حقول إدخال التاريخ والوقت ---
//                         _buildOrderForm(cubit),
//                       ],
//                     );
//                   }

//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error_outline,
//                             size: 60, color: Colors.red),
//                         SizedBox(height: 20),
//                         Text(
//                           "حدث خطأ أثناء تحميل السلة",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         SizedBox(height: 10),
//                         ElevatedButton(
//                           onPressed: () => cubit.getCartItems(),
//                           child: Text("إعادة المحاولة"),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // --- بناء حقول الطلب ---
//   Widget _buildOrderForm(CartCubit cubit) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: cubit.dateController,
//           readOnly: true,
//          onTap: () => _selectDate(context.read<CartCubit>()),
//           decoration: InputDecoration(
//             labelText: "اختر التاريخ",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 15),
//         TextFormField(
//           controller: cubit.timeController,
//           readOnly: true,
//           onTap: () => _selectTime(context),
//           decoration: InputDecoration(
//             labelText: "اختر الوقت",
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 20),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed: cubit.canMakeOrder()
//                 ? () {
//                     cubit.placeOrder(
//                       paymentId: 1, // يمكنك تغييرها لاحقًا عبر dropdown
//                       addressId: 1, // يمكنك تغييرها لاحقًا عبر dropdown
//                     );
//                   }
//                 : null,
//             icon: Icon(Icons.check_circle),
//             label: Text("تأكيد الطلب"),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(vertical: 14),
//               textStyle: TextStyle(fontSize: 16),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2024),
//     lastDate: DateTime(2026),
//   );
//   if (picked != null) {
//     final cubit = context.read<CartCubit>();
//     cubit.updateDate("${picked.toLocal()}".split(' ')[0]);
//   }
// }

// Future<void> _selectTime(BuildContext context) async {
//   final TimeOfDay? picked = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay.now(),
//   );
//   if (picked != null) {
//     final cubit = context.read<CartCubit>();
//     cubit.updateTime(picked.format(context));
//   }
// }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:al_omda/core/services/service_locator.dart';
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
          final cubit = context.read<CartCubit>();

          return Scaffold(
            appBar: AppBar(title: Text("سلة التسوق")),
            body: BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
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

                    return ListView(
                      padding: EdgeInsets.all(16),
                      children: [
                        // --- عرض المنتجات ---
                        ...items.map(
                          (item) => Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: item.image,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder:
                                    (_, __) => CircularProgressIndicator(),
                                errorWidget:
                                    (_, __, ___) => Icon(Icons.shopping_bag),
                              ),
                              title: Text(item.title),
                              subtitle: Text(
                                "${item.price} L.E × ${item.quantity} = ${(item.price * item.quantity)} L.E",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed:
                                    () => cubit.removeFromCart(item.productId),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // --- حقول إدخال التاريخ والوقت ---
                        _buildOrderForm(context, cubit),
                      ],
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
                          onPressed: () => cubit.getCartItems(),
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

  // --- بناء حقول الطلب ---
  Widget _buildOrderForm(BuildContext context, CartCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: cubit.dateController,
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(labelText: "اختر التاريخ"),
          onChanged: (_) {
            cubit.canMakeOrder(); // لتحديث حالة الزر
          },
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: cubit.timeController,
          readOnly: true,
          onTap: () => _selectTime(context),
          decoration: InputDecoration(labelText: "اختر الوقت"),
          onChanged: (_) {
            cubit.canMakeOrder(); // لتحديث حالة الزر
          },
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                cubit.canMakeOrder()
                    ? () {
                      cubit.placeOrder(paymentId: 1, addressId: 1);
                    }
                    : null,
            icon: Icon(Icons.check_circle),
            label: Text("تأكيد الطلب"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      final cubit = context.read<CartCubit>();
      cubit.updateDate("${picked.toLocal()}".split(' ')[0]);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final cubit = context.read<CartCubit>();
      cubit.updateTime(picked.format(context));
    }
  }
}
