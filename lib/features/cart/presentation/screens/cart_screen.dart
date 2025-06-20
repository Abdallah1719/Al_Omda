import 'package:al_omda/features/order/presentation/screens/make_order_screen.dart';
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
                                  (_, _) => CircularProgressIndicator(),
                              errorWidget:
                                  (_, _, _) => Icon(Icons.shopping_bag),
                            ),
                            title: Text(item.title),
                            subtitle: Text(
                              "${item.price} L.E × ${item.quantity} = ${(item.price * item.quantity)} L.E",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {},
                              // () => cubit.removeFromCart(item.productId),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final cubit =
                              context.read<CartCubit>(); // ← نقل القراءة هنا
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
                          // RoutesMethods.pushNavigate(
                          //   context,
                          //   RoutesConstances.makeOrderPath,
                          // );
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
