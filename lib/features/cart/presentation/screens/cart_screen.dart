import 'package:al_omda/core/routes/routes_constances.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
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
            body: BlocConsumer<CartCubit, CartState>(
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
                      ...items.map(
                        (item) => Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: item.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.fill,
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
                      ElevatedButton(
                        onPressed: () {
                          RoutesMethods.pushNavigate(
                            context,
                            RoutesConstances.makeOrderPath,
                          );
                        },
                        child: Text("Make Order"),
                      ),
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
          );
        },
      ),
    );
  }
}
//   Widget _buildOrderForm(BuildContext context, CartCubit cubit) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: cubit.dateController,
//           readOnly: true,
//           onTap: () => _selectDate(context),
//           decoration: InputDecoration(labelText: "اختر التاريخ"),
//           onChanged: (_) {
//             cubit.canMakeOrder();
//           },
//         ),
//         SizedBox(height: 15),
//         TextFormField(
//           controller: cubit.timeController,
//           readOnly: true,
//           onTap: () => _selectTime(context),
//           decoration: InputDecoration(labelText: "اختر الوقت"),
//           onChanged: (_) {
//             cubit.canMakeOrder();
//           },
//         ),
//         SizedBox(height: 20),
//         SizedBox(
//           width: double.infinity,
//           child: ElevatedButton.icon(
//             onPressed:
//                 cubit.canMakeOrder()
//                     ? () {
//                       cubit.placeOrder(paymentId: 1, addressId: 1);
//                     }
//                     : null,
//             icon: Icon(Icons.check_circle),
//             label: Text("تأكيد الطلب"),
//             style: ElevatedButton.styleFrom(
//               padding: EdgeInsets.symmetric(vertical: 14),
//               textStyle: TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2026),
//     );
//     if (picked != null) {
//       final cubit = context.read<CartCubit>();
//       cubit.updateDate("${picked.toLocal()}".split(' ')[0]);
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       final cubit = context.read<CartCubit>();
//       cubit.updateTime(picked.format(context));
//     }
//   }
// }
