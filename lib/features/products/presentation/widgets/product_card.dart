// // // // // // // import 'package:al_omda/core/utils/size_config.dart';
// // // // // // // import 'package:al_omda/features/products/data/models/products_model.dart';
// // // // // // // import 'package:al_omda/generated/l10n.dart';
// // // // // // // import 'package:cached_network_image/cached_network_image.dart';
// // // // // // // import 'package:flutter/material.dart';

// // // // // // // ProductsModel getProductData(dynamic item) {
// // // // // // //   return ProductsModel(
// // // // // // //     title: item.title,
// // // // // // //     price: item.price,
// // // // // // //     image: item.image,
// // // // // // //     weight: item.weight,
// // // // // // //     unitName: item.unitName,
// // // // // // //   );
// // // // // // // }

// // // // // // // class ProductCard<T> extends StatelessWidget {
// // // // // // //   final T item;

// // // // // // //   const ProductCard(this.item, {super.key});

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final data = getProductData(item);

// // // // // // //     return Container(
// // // // // // //       decoration: BoxDecoration(
// // // // // // //         borderRadius: BorderRadius.circular(12),
// // // // // // //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // // // //       ),
// // // // // // //       child: Column(
// // // // // // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // // // //         children: [
// // // // // // //           // الصورة
// // // // // // //           ClipRRect(
// // // // // // //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// // // // // // //             child: SizedBox(
// // // // // // //               height: 150,
// // // // // // //               child: Center(
// // // // // // //                 child: CachedNetworkImage(
// // // // // // //                   imageUrl:
// // // // // // //                       data.image.isNotEmpty
// // // // // // //                           ? data.image
// // // // // // //                           : 'https://via.placeholder.com/300 ',
// // // // // // //                   fit: BoxFit.contain,
// // // // // // //                   placeholder: (context, url) => Container(),
// // // // // // //                   errorWidget:
// // // // // // //                       (context, url, error) =>
// // // // // // //                           Icon(Icons.error, size: 50, color: Colors.red),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ),

// // // // // // //           // زر الإضافة للسلة
// // // // // // //           Padding(
// // // // // // //             padding: const EdgeInsets.all(12),
// // // // // // //             child: ElevatedButton.icon(
// // // // // // //               onPressed: () {},
// // // // // // //               style: ElevatedButton.styleFrom(
// // // // // // //                 backgroundColor: const Color(0xFF35E298),
// // // // // // //                 shape: RoundedRectangleBorder(
// // // // // // //                   borderRadius: BorderRadius.circular(8),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               icon: Icon(Icons.shopping_cart, size: 18),
// // // // // // //               label: Text(S.of(context).addToCart),
// // // // // // //             ),
// // // // // // //           ),

// // // // // // //           // اسم المنتج والسعر
// // // // // // //           Expanded(
// // // // // // //             child: Container(
// // // // // // //               padding: const EdgeInsets.symmetric(horizontal: 8),
// // // // // // //               decoration: BoxDecoration(
// // // // // // //                 borderRadius: BorderRadius.circular(12),
// // // // // // //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // // // //                 color: const Color(0xFF35E298),
// // // // // // //               ),
// // // // // // //               child: Column(
// // // // // // //                 children: [
// // // // // // //                   Row(
// // // // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // // //                     children: [
// // // // // // //                       SizedBox(
// // // // // // //                         width: SizeConfig.defaultSize! * 12,
// // // // // // //                         child: Text(
// // // // // // //                           data.title,
// // // // // // //                           style: TextStyle(
// // // // // // //                             fontSize: 14,
// // // // // // //                             fontWeight: FontWeight.bold,
// // // // // // //                           ),
// // // // // // //                           overflow: TextOverflow.ellipsis,
// // // // // // //                           maxLines: 1,
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                       Text(
// // // // // // //                         '${data.price} L.E',
// // // // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                   Row(
// // // // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //                     children: [
// // // // // // //                       Text(
// // // // // // //                         data.weight,
// // // // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // // // //                       ),
// // // // // // //                       const SizedBox(width: 4),
// // // // // // //                       Text(
// // // // // // //                         data.unitName,
// // // // // // //                         style: TextStyle(fontSize: 12, color: Colors.black),
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // // import 'package:al_omda/core/utils/size_config.dart';
// // // // // // import 'package:al_omda/features/products/data/models/products_model.dart';
// // // // // // import 'package:al_omda/generated/l10n.dart';
// // // // // // import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';

// // // // // // class ProductCard extends StatefulWidget {
// // // // // //   final ProductsModel product;

// // // // // //   const ProductCard({super.key, required this.product});

// // // // // //   @override
// // // // // //   State<ProductCard> createState() => _ProductCardState();
// // // // // // }

// // // // // // class _ProductCardState extends State<ProductCard> {
// // // // // //   late ProductsModel product;
// // // // // //   late int quantity;
// // // // // //   late bool isInCart;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     product = widget.product;
// // // // // //     quantity = product.cartQuantity > 0 ? product.cartQuantity : 1;
// // // // // //     isInCart = product.cart;
// // // // // //     super.initState();
// // // // // //   }

// // // // // //   void _addToCart() {
// // // // // //     setState(() {
// // // // // //       isInCart = true;
// // // // // //       quantity = 1;
// // // // // //     });

// // // // // //     // يمكنك استدعاء API أو إرسال للـ Bloc لإضافة المنتج للسلة
// // // // // //     print("Added to cart: ${product.title}, Quantity: $quantity");
// // // // // //   }

// // // // // //   void _updateQuantity(int newQuantity) {
// // // // // //     if (newQuantity < 1) return;
// // // // // //     setState(() {
// // // // // //       quantity = newQuantity;
// // // // // //     });
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Container(
// // // // // //       decoration: BoxDecoration(
// // // // // //         borderRadius: BorderRadius.circular(12),
// // // // // //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // // //         children: [
// // // // // //           // الصورة
// // // // // //           ClipRRect(
// // // // // //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// // // // // //             child: SizedBox(
// // // // // //               height: 150,
// // // // // //               child: Center(
// // // // // //                 child: CachedNetworkImage(
// // // // // //                   imageUrl: product.image.isNotEmpty
// // // // // //                       ? product.image
// // // // // //                       : 'https://via.placeholder.com/300 ',
// // // // // //                   fit: BoxFit.contain,
// // // // // //                   placeholder: (context, url) => Container(),
// // // // // //                   errorWidget: (context, url, error) =>
// // // // // //                       Icon(Icons.error, size: 50, color: Colors.red),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),

// // // // // //           // زر الإضافة أو العداد
// // // // // //           Padding(
// // // // // //             padding: const EdgeInsets.all(12),
// // // // // //             child: !product.inStock
// // // // // //                 ? Text(
// // // // // //                     "Out of stock",
// // // // // //                     style: TextStyle(color: Colors.red),
// // // // // //                     textAlign: TextAlign.center,
// // // // // //                   )
// // // // // //                 : isInCart
// // // // // //                     ? Row(
// // // // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                         children: [
// // // // // //                           IconButton(
// // // // // //                             onPressed: () => _updateQuantity(quantity - 1),
// // // // // //                             icon: Icon(Icons.remove, color: Colors.red),
// // // // // //                           ),
// // // // // //                           Text('$quantity'),
// // // // // //                           IconButton(
// // // // // //                             onPressed: () => _updateQuantity(quantity + 1),
// // // // // //                             icon: Icon(Icons.add, color: Colors.green),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       )
// // // // // //                     : ElevatedButton.icon(
// // // // // //                         onPressed: _addToCart,
// // // // // //                         style: ElevatedButton.styleFrom(
// // // // // //                           backgroundColor: const Color(0xFF35E298),
// // // // // //                           shape: RoundedRectangleBorder(
// // // // // //                             borderRadius: BorderRadius.circular(8),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                         icon: Icon(Icons.shopping_cart, size: 18),
// // // // // //                         label: Text(S.of(context).addToCart),
// // // // // //                       ),
// // // // // //           ),

// // // // // //           // اسم المنتج والسعر
// // // // // //           Expanded(
// // // // // //             child: Container(
// // // // // //               padding: const EdgeInsets.symmetric(horizontal: 8),
// // // // // //               decoration: BoxDecoration(
// // // // // //                 borderRadius: BorderRadius.circular(12),
// // // // // //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // // //                 color: const Color(0xFF35E298),
// // // // // //               ),
// // // // // //               child: Column(
// // // // // //                 children: [
// // // // // //                   Row(
// // // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                     children: [
// // // // // //                       SizedBox(
// // // // // //                         width: SizeConfig.defaultSize! * 12,
// // // // // //                         child: Text(
// // // // // //                           product.title,
// // // // // //                           style: TextStyle(
// // // // // //                             fontSize: 14,
// // // // // //                             fontWeight: FontWeight.bold,
// // // // // //                           ),
// // // // // //                           overflow: TextOverflow.ellipsis,
// // // // // //                           maxLines: 1,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       Text(
// // // // // //                         '${product.price} L.E',
// // // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                   Row(
// // // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                     children: [
// // // // // //                       Text(
// // // // // //                         product.weight,
// // // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // // //                       ),
// // // // // //                       const SizedBox(width: 4),
// // // // // //                       Text(
// // // // // //                         product.unitName,
// // // // // //                         style: TextStyle(fontSize: 12, color: Colors.black),
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:al_omda/features/cart/data/repository/cart_repository.dart';
// // // // // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // import 'package:al_omda/core/utils/size_config.dart';
// // // // // import 'package:al_omda/features/products/data/models/products_model.dart';
// // // // // import 'package:al_omda/features/products/presentation/controller/cart_cubit.dart';
// // // // // import 'package:al_omda/generated/l10n.dart';

// // // // // class ProductCard extends StatefulWidget {
// // // // //   final ProductsModel product;

// // // // //   const ProductCard({super.key, required this.product});

// // // // //   @override
// // // // //   State<ProductCard> createState() => _ProductCardState();
// // // // // }

// // // // // class _ProductCardState extends State<ProductCard> {
// // // // //   late ProductsModel product;
// // // // //   late int quantity;
// // // // //   late bool isInCart;

// // // // //   @override
// // // // //   void initState() {
// // // // //     product = widget.product;
// // // // //     quantity = product.cartQuantity > 0 ? product.cartQuantity : 1;
// // // // //     isInCart = product.cart;
// // // // //     super.initState();
// // // // //   }

// // // // //   void _addToCart(BuildContext context) async {
// // // // //     final cartCubit = BlocProvider.of<CartCubit>(context);
// // // // //     cartCubit.addToCart(product.id);

// // // // //     setState(() {
// // // // //       product = product.copyWith(cart: true, cartQuantity: 1);
// // // // //     });

// // // // //     // 👇 إرسال الطلبية للـ API
// // // // //     final result = await CartRepository.addToCart(product.id);

// // // // //     result.fold(
// // // // //       (error) {
// // // // //         // 👇 في حال فشل الاتصال، رجع الحالة القديمة
// // // // //         cartCubit.updateQuantity(product.id, 0);
// // // // //         setState(() {
// // // // //           product = product.copyWith(cart: false, cartQuantity: 0);
// // // // //         });
// // // // //       },
// // // // //       (_) {
// // // // //         // 👇 يمكن إعادة تحميل المنتجات من الـ API هنا
// // // // //         // BlocProvider.of<ProductsCubit>(context).getMostRecentProducts();
// // // // //       },
// // // // //     );
// // // // //   }

// // // // //   void _updateQuantity(BuildContext context, int newQuantity) {
// // // // //     final cartCubit = BlocProvider.of<CartCubit>(context);
// // // // //     if (newQuantity < 1) return;

// // // // //     cartCubit.updateQuantity(product.id, newQuantity);

// // // // //     setState(() {
// // // // //       product = product.copyWith(cartQuantity: newQuantity);
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final cartCubit = BlocProvider.of<CartCubit>(context);
// // // // //     final isInCart = cartCubit.isInCart(product.id);
// // // // //     final quantity = cartCubit.getQuantity(product.id);

// // // // //     return Container(
// // // // //       decoration: BoxDecoration(
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // //         children: [
// // // // //           // الصورة
// // // // //           ClipRRect(
// // // // //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// // // // //             child: SizedBox(
// // // // //               height: 150,
// // // // //               child: Center(
// // // // //                 child: CachedNetworkImage(
// // // // //                   imageUrl: product.image.isNotEmpty
// // // // //                       ? product.image
// // // // //                       : 'https://via.placeholder.com/300 ',
// // // // //                   fit: BoxFit.contain,
// // // // //                   placeholder: (context, url) => Container(),
// // // // //                   errorWidget: (context, url, error) =>
// // // // //                       Icon(Icons.error, size: 50, color: Colors.red),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),

// // // // //           // زر الإضافة أو العداد
// // // // //           Padding(
// // // // //             padding: const EdgeInsets.all(12),
// // // // //             child: !product.inStock
// // // // //                 ? Text(
// // // // //                     "Out of stock",
// // // // //                     style: TextStyle(color: Colors.red),
// // // // //                     textAlign: TextAlign.center,
// // // // //                   )
// // // // //                 : isInCart
// // // // //                     ? Row(
// // // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // // //                         children: [
// // // // //                           IconButton(
// // // // //                             onPressed: () =>
// // // // //                                 _updateQuantity(context, quantity - 1),
// // // // //                             icon: Icon(Icons.remove, color: Colors.red),
// // // // //                           ),
// // // // //                           Text('$quantity'),
// // // // //                           IconButton(
// // // // //                             onPressed: () =>
// // // // //                                 _updateQuantity(context, quantity + 1),
// // // // //                             icon: Icon(Icons.add, color: Colors.green),
// // // // //                           ),
// // // // //                         ],
// // // // //                       )
// // // // //                     : ElevatedButton.icon(
// // // // //                         onPressed: () => _addToCart(context),
// // // // //                         style: ElevatedButton.styleFrom(
// // // // //                           backgroundColor: const Color(0xFF35E298),
// // // // //                           shape: RoundedRectangleBorder(
// // // // //                             borderRadius: BorderRadius.circular(8),
// // // // //                           ),
// // // // //                         ),
// // // // //                         icon: Icon(Icons.shopping_cart, size: 18),
// // // // //                         label: Text(S.of(context).addToCart),
// // // // //                       ),
// // // // //           ),

// // // // //           // اسم المنتج والسعر
// // // // //           Expanded(
// // // // //             child: Container(
// // // // //               padding: const EdgeInsets.symmetric(horizontal: 8),
// // // // //               decoration: BoxDecoration(
// // // // //                 borderRadius: BorderRadius.circular(12),
// // // // //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // // //                 color: const Color(0xFF35E298),
// // // // //               ),
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                     children: [
// // // // //                       SizedBox(
// // // // //                         width: SizeConfig.defaultSize! * 12,
// // // // //                         child: Text(
// // // // //                           product.title,
// // // // //                           style: TextStyle(
// // // // //                             fontSize: 14,
// // // // //                             fontWeight: FontWeight.bold,
// // // // //                           ),
// // // // //                           overflow: TextOverflow.ellipsis,
// // // // //                           maxLines: 1,
// // // // //                         ),
// // // // //                       ),
// // // // //                       Text(
// // // // //                         '${product.price} L.E',
// // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                   Row(
// // // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                     children: [
// // // // //                       Text(
// // // // //                         product.weight,
// // // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // // //                       ),
// // // // //                       const SizedBox(width: 4),
// // // // //                       Text(
// // // // //                         product.unitName,
// // // // //                         style: TextStyle(fontSize: 12, color: Colors.black),
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // import 'package:cached_network_image/cached_network_image.dart';
// // // // import 'package:al_omda/core/utils/size_config.dart';
// // // // import 'package:al_omda/features/products/data/models/products_model.dart';
// // // // import 'package:al_omda/features/cart/data/repository/cart_repository.dart';
// // // // import 'package:al_omda/core/api/api_methods.dart';
// // // // import 'package:dartz/dartz.dart';
// // // // import 'package:al_omda/generated/l10n.dart';

// // // // class ProductCard extends StatefulWidget {
// // // //   final ProductsModel product;

// // // //   const ProductCard({super.key, required this.product});

// // // //   @override
// // // //   State<ProductCard> createState() => _ProductCardState();
// // // // }

// // // // class _ProductCardState extends State<ProductCard> {
// // // //   late ProductsModel product;
// // // //   late int quantity;
// // // //   late bool isInCart;

// // // //   @override
// // // //   void initState() {
// // // //     product = widget.product;
// // // //     quantity = product.cartQuantity > 0 ? product.cartQuantity : 1;
// // // //     isInCart = product.cart;
// // // //     super.initState();
// // // //   }

// // // //   void _addToCart(BuildContext context) async {
// // // //     final cartCubit = BlocProvider.of<CartCubit>(context);

// // // //     cartCubit.addToCart(product.id);

// // // //     setState(() {
// // // //       product = product.copyWith(cart: true, cartQuantity: 1);
// // // //     });

// // // //     // 👇 إنشاء instance من CartRepository
// // // //     final cartRepo = CartRepository(api: ApiMethods());

// // // //     // 👇 استدعاء الدالة العادية
// // // //     final Either<String, bool> result = await cartRepo.addToCart(product.id);

// // // //     result.fold(
// // // //       (error) {
// // // //         cartCubit.updateQuantity(product.id, 0);
// // // //         setState(() {
// // // //           product = product.copyWith(cart: false, cartQuantity: 0);
// // // //         });

// // // //         // 👇 عرض رسالة خطأ (اختياري)
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(error)),
// // // //         );
// // // //       },
// // // //       (_) {
// // // //         // 👇 يمكنك هنا إعادة تحميل المنتجات من الـ API إذا أردت
// // // //         // مثال:
// // // //         // BlocProvider.of<ProductsCubit>(context).getMostRecentProducts();

// // // //         // 👇 أو فقط إظهار رسالة نجاح
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Added to cart successfully')),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _updateQuantity(BuildContext context, int newQuantity) {
// // // //     final cartCubit = BlocProvider.of<CartCubit>(context);
// // // //     if (newQuantity < 1) return;

// // // //     cartCubit.updateQuantity(product.id, newQuantity);

// // // //     setState(() {
// // // //       product = product.copyWith(cartQuantity: newQuantity);
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final cartCubit = BlocProvider.of<CartCubit>(context);
// // // //     final bool isInCart = cartCubit.isInCart(product.id);
// // // //     final int quantity = cartCubit.getQuantity(product.id);

// // // //     return Container(
// // // //       decoration: BoxDecoration(
// // // //         borderRadius: BorderRadius.circular(12),
// // // //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // // //         children: [
// // // //           // الصورة
// // // //           ClipRRect(
// // // //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// // // //             child: SizedBox(
// // // //               height: 150,
// // // //               child: Center(
// // // //                 child: CachedNetworkImage(
// // // //                   imageUrl: product.image.isNotEmpty
// // // //                       ? product.image
// // // //                       : 'https://via.placeholder.com/300 ',
// // // //                   fit: BoxFit.contain,
// // // //                   placeholder: (context, url) => Container(),
// // // //                   errorWidget: (context, url, error) =>
// // // //                       Icon(Icons.error, size: 50, color: Colors.red),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),

// // // //           // زر الإضافة أو العداد
// // // //           Padding(
// // // //             padding: const EdgeInsets.all(12),
// // // //             child: !product.inStock
// // // //                 ? Text(
// // // //                     "Out of stock",
// // // //                     style: TextStyle(color: Colors.red),
// // // //                     textAlign: TextAlign.center,
// // // //                   )
// // // //                 : isInCart
// // // //                     ? Row(
// // // //                         mainAxisAlignment: MainAxisAlignment.center,
// // // //                         children: [
// // // //                           IconButton(
// // // //                             onPressed: () =>
// // // //                                 _updateQuantity(context, quantity - 1),
// // // //                             icon: Icon(Icons.remove, color: Colors.red),
// // // //                           ),
// // // //                           Text('$quantity'),
// // // //                           IconButton(
// // // //                             onPressed: () =>
// // // //                                 _updateQuantity(context, quantity + 1),
// // // //                             icon: Icon(Icons.add, color: Colors.green),
// // // //                           ),
// // // //                         ],
// // // //                       )
// // // //                     : ElevatedButton.icon(
// // // //                         onPressed: () => _addToCart(context),
// // // //                         style: ElevatedButton.styleFrom(
// // // //                           backgroundColor: const Color(0xFF35E298),
// // // //                           shape: RoundedRectangleBorder(
// // // //                             borderRadius: BorderRadius.circular(8),
// // // //                           ),
// // // //                         ),
// // // //                         icon: Icon(Icons.shopping_cart, size: 18),
// // // //                         label: Text(S.of(context).addToCart),
// // // //                       ),
// // // //           ),

// // // //           // اسم المنتج والسعر
// // // //           Expanded(
// // // //             child: Container(
// // // //               padding: const EdgeInsets.symmetric(horizontal: 8),
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(12),
// // // //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// // // //                 color: const Color(0xFF35E298),
// // // //               ),
// // // //               child: Column(
// // // //                 children: [
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                     children: [
// // // //                       SizedBox(
// // // //                         width: SizeConfig.defaultSize! * 12,
// // // //                         child: Text(
// // // //                           product.title,
// // // //                           style: TextStyle(
// // // //                             fontSize: 14,
// // // //                             fontWeight: FontWeight.bold,
// // // //                           ),
// // // //                           overflow: TextOverflow.ellipsis,
// // // //                           maxLines: 1,
// // // //                         ),
// // // //                       ),
// // // //                       Text(
// // // //                         '${product.price} L.E',
// // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                     children: [
// // // //                       Text(
// // // //                         product.weight,
// // // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // // //                       ),
// // // //                       const SizedBox(width: 4),
// // // //                       Text(
// // // //                         product.unitName,
// // // //                         style: TextStyle(fontSize: 12, color: Colors.black),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:al_omda/core/api/dio_methods.dart';
// // // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// // // import 'package:dio/dio.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:cached_network_image/cached_network_image.dart';

// // // import 'package:al_omda/core/utils/size_config.dart';
// // // import 'package:al_omda/features/products/data/models/products_model.dart';

// // // import 'package:al_omda/features/cart/data/repository/cart_repository.dart';

// // // import 'package:al_omda/generated/l10n.dart';

// // // class ProductCard extends StatelessWidget {
// // //   final ProductsModel product;

// // //   const ProductCard({super.key, required this.product});

// // //   Future<void> _addToCart(BuildContext context, int productId) async {
// // //     final cartRepo = CartRepository(api: DioMethods(Dio()));
// // //     final result = await cartRepo.addToCart(productId);

// // //     result.fold(
// // //       (error) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(error)),
// // //         );
// // //       },
// // //       (_) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Added to cart successfully')),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final cartCubit = context.read<CartCubit>();
// // //     final bool isInCart = cartCubit.isInCart(product.id);
// // //     final int quantity = cartCubit.getQuantity(product.id);

// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // //         children: [
// // //           // الصورة
// // //           ClipRRect(
// // //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// // //             child: SizedBox(
// // //               height: 150,
// // //               child: Center(
// // //                 child: CachedNetworkImage(
// // //                   imageUrl: product.image.isNotEmpty
// // //                       ? product.image
// // //                       : 'https://via.placeholder.com/300 ',
// // //                   fit: BoxFit.contain,
// // //                   placeholder: (context, url) => Container(),
// // //                   errorWidget: (context, url, error) =>
// // //                       Icon(Icons.error, size: 50, color: Colors.red),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           // زر الإضافة أو العداد
// // //           Padding(
// // //             padding: const EdgeInsets.all(12),
// // //             child: !product.inStock
// // //                 ? Text(
// // //                     "Out of stock",
// // //                     style: TextStyle(color: Colors.red),
// // //                     textAlign: TextAlign.center,
// // //                   )
// // //                 : isInCart
// // //                     ? Row(
// // //                         mainAxisAlignment: MainAxisAlignment.center,
// // //                         children: [
// // //                           IconButton(
// // //                             onPressed: () =>
// // //                                 cartCubit.updateQuantity(product.id, quantity - 1),
// // //                             icon: Icon(Icons.remove, color: Colors.red),
// // //                           ),
// // //                           Text('$quantity'),
// // //                           IconButton(
// // //                             onPressed: () =>
// // //                                 cartCubit.updateQuantity(product.id, quantity + 1),
// // //                             icon: Icon(Icons.add, color: Colors.green),
// // //                           ),
// // //                         ],
// // //                       )
// // //                     : ElevatedButton.icon(
// // //                         onPressed: () {
// // //                           cartCubit.addToCart(product.id);
// // //                           _addToCart(context, product.id);
// // //                         },
// // //                         style: ElevatedButton.styleFrom(
// // //                           backgroundColor: const Color(0xFF35E298),
// // //                           shape: RoundedRectangleBorder(
// // //                             borderRadius: BorderRadius.circular(8),
// // //                           ),
// // //                         ),
// // //                         icon: Icon(Icons.shopping_cart, size: 18),
// // //                         label: Text(S.of(context).addToCart),
// // //                       ),
// // //           ),

// // //           // اسم المنتج والسعر
// // //           Expanded(
// // //             child: Container(
// // //               padding: const EdgeInsets.symmetric(horizontal: 8),
// // //               decoration: BoxDecoration(
// // //                 borderRadius: BorderRadius.circular(12),
// // //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// // //                 color: const Color(0xFF35E298),
// // //               ),
// // //               child: Column(
// // //                 children: [
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       SizedBox(
// // //                         width: SizeConfig.defaultSize! * 12,
// // //                         child: Text(
// // //                           product.title,
// // //                           style: TextStyle(
// // //                             fontSize: 14,
// // //                             fontWeight: FontWeight.bold,
// // //                           ),
// // //                           overflow: TextOverflow.ellipsis,
// // //                           maxLines: 1,
// // //                         ),
// // //                       ),
// // //                       Text(
// // //                         '${product.price} L.E',
// // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.center,
// // //                     children: [
// // //                       Text(
// // //                         product.weight,
// // //                         style: TextStyle(fontSize: 14, color: Colors.black),
// // //                       ),
// // //                       const SizedBox(width: 4),
// // //                       Text(
// // //                         product.unitName,
// // //                         style: TextStyle(fontSize: 12, color: Colors.black),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:cached_network_image/cached_network_image.dart';

// // import 'package:al_omda/core/utils/size_config.dart';
// // import 'package:al_omda/features/products/data/models/products_model.dart';
// // import 'package:al_omda/features/cart/presentation/controller/cart_cubit.dart';
// // import 'package:al_omda/features/cart/data/repository/cart_repository.dart';
// // import 'package:al_omda/core/api/api_methods.dart';
// // import 'package:dartz/dartz.dart';
// // import 'package:al_omda/generated/l10n.dart';

// // class ProductCard extends StatefulWidget {
// //   final ProductsModel product;

// //   const ProductCard({super.key, required this.product});

// //   @override
// //   State<ProductCard> createState() => _ProductCardState();
// // }

// // class _ProductCardState extends State<ProductCard> {
// //   late ProductsModel product;
// //   late int quantity;
// //   late bool isInCart;

// //   @override
// //   void initState() {
// //     product = widget.product;
// //     quantity = product.cartQuantity > 0 ? product.cartQuantity : 1;
// //     isInCart = product.cart;
// //     super.initState();
// //   }

// //   void _addToCart(BuildContext context) async {
// //     final cartCubit = BlocProvider.of<CartCubit>(context);
// //     cartCubit.addToCart(product.id);

// //     setState(() {
// //       product = product.copyWith(cart: true, cartQuantity: 1);
// //     });

// //     final result = await CartRepository(api: ApiMethods()).addToCart(product.id);

// //     result.fold(
// //       (error) {
// //         cartCubit.updateQuantity(product.id, 0);
// //         setState(() {
// //           product = product.copyWith(cart: false, cartQuantity: 0);
// //         });

// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(error)),
// //         );
// //       },
// //       (_) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Added to cart successfully')),
// //         );

// //         // 👇 اختياري: إعادة تحميل المنتجات من الـ API
// //         // BlocProvider.of<ProductsCubit>(context).getMostRecentProducts();
// //       },
// //     );
// //   }

// //   void _updateQuantity(BuildContext context, int newQuantity) {
// //     final cartCubit = BlocProvider.of<CartCubit>(context);
// //     if (newQuantity < 1) return;

// //     cartCubit.updateQuantity(product.id, newQuantity);

// //     setState(() {
// //       product = product.copyWith(cartQuantity: newQuantity);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final cartCubit = BlocProvider.of<CartCubit>(context);
// //     final bool isInCart = cartCubit.isInCart(product.id);
// //     final int quantity = cartCubit.getQuantity(product.id);

// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(color: const Color(0xFF35E298), width: 1),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.stretch,
// //         children: [
// //           // الصورة
// //           ClipRRect(
// //             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
// //             child: SizedBox(
// //               height: 150,
// //               child: Center(
// //                 child: CachedNetworkImage(
// //                   imageUrl: product.image.isNotEmpty
// //                       ? product.image
// //                       : 'https://via.placeholder.com/300 ',
// //                   fit: BoxFit.contain,
// //                   placeholder: (context, url) => Container(),
// //                   errorWidget: (context, url, error) =>
// //                       Icon(Icons.error, size: 50, color: Colors.red),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // زر الإضافة أو العداد
// //           Padding(
// //             padding: const EdgeInsets.all(12),
// //             child: !product.inStock
// //                 ? Text(
// //                     "Out of stock",
// //                     style: TextStyle(color: Colors.red),
// //                     textAlign: TextAlign.center,
// //                   )
// //                 : isInCart
// //                     ? Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           IconButton(
// //                             onPressed: () =>
// //                                 _updateQuantity(context, quantity - 1),
// //                             icon: Icon(Icons.remove, color: Colors.red),
// //                           ),
// //                           Text('$quantity'),
// //                           IconButton(
// //                             onPressed: () =>
// //                                 _updateQuantity(context, quantity + 1),
// //                             icon: Icon(Icons.add, color: Colors.green),
// //                           ),
// //                         ],
// //                       )
// //                     : ElevatedButton.icon(
// //                         onPressed: () => _addToCart(context),
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: const Color(0xFF35E298),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                         icon: Icon(Icons.shopping_cart, size: 18),
// //                         label: Text(S.of(context).addToCart),
// //                       ),
// //           ),

// //           // اسم المنتج والسعر
// //           Expanded(
// //             child: Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 8),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(color: const Color(0xFF35E298), width: 1),
// //                 color: const Color(0xFF35E298),
// //               ),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       SizedBox(
// //                         width: SizeConfig.defaultSize! * 12,
// //                         child: Text(
// //                           product.title,
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                           maxLines: 1,
// //                         ),
// //                       ),
// //                       Text(
// //                         '${product.price} L.E',
// //                         style: TextStyle(fontSize: 14, color: Colors.black),
// //                       ),
// //                     ],
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         product.weight,
// //                         style: TextStyle(fontSize: 14, color: Colors.black),
// //                       ),
// //                       const SizedBox(width: 4),
// //                       Text(
// //                         product.unitName,
// //                         style: TextStyle(fontSize: 12, color: Colors.black),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:al_omda/core/utils/size_config.dart';
// import 'package:al_omda/features/products/data/models/products_model.dart';
// import 'package:al_omda/generated/l10n.dart';

// class ProductCard extends StatelessWidget {
//   final ProductsModel product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final cartCubit = BlocProvider.of<CartCubit>(context);

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFF35E298), width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // الصورة
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
//             child: SizedBox(
//               height: 150,
//               child: Center(
//                 child: CachedNetworkImage(
//                   imageUrl: product.image.isNotEmpty
//                       ? product.image
//                       : 'https://via.placeholder.com/300 ',
//                   fit: BoxFit.contain,
//                   placeholder: (context, url) => Container(),
//                   errorWidget: (context, url, error) =>
//                       Icon(Icons.error, size: 50, color: Colors.red),
//                 ),
//               ),
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: !product.inStock
//                 ? Text(
//                     "Out of stock",
//                     style: TextStyle(color: Colors.red),
//                     textAlign: TextAlign.center,
//                   )
//                 : BlocBuilder<CartCubit, CartState>(
//                     builder: (context, state) {
//                       bool isInCart = false;
//                       int quantity = 0;

//                       if (state is CartLoaded) {
//                         final item = state.items
//                             .firstWhere((item) => item.productId == product.id, orElse: () => null);
//                         isInCart = item != null;
//                         quantity = item?.quantity ?? 0;
//                       }

//                       return isInCart
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                   onPressed: () => cartCubit.updateQuantity(product.id, quantity - 1),
//                                   icon: Icon(Icons.remove, color: Colors.red),
//                                 ),
//                                 Text('$quantity'),
//                                 IconButton(
//                                   onPressed: () => cartCubit.updateQuantity(product.id, quantity + 1),
//                                   icon: Icon(Icons.add, color: Colors.green),
//                                 ),
//                               ],
//                             )
//                           : ElevatedButton.icon(
//                               onPressed: () => cartCubit.addToCart(product.id),
//                               label: Text(S.of(context).addToCart),
//                               icon: Icon(Icons.shopping_cart),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF35E298),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                             );
//                     },
//                   ),
//           ),

//           // اسم المنتج والسعر
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: const Color(0xFF35E298), width: 1),
//                 color: const Color(0xFF35E298),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: SizeConfig.defaultSize! * 12,
//                         child: Text(
//                           product.title,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                           style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Text('${product.price} L.E'),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(product.weight, style: TextStyle(fontSize: 14)),
//                       const SizedBox(width: 4),
//                       Text(product.unitName, style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/cart/domain/entities/cart.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';

import 'package:al_omda/generated/l10n.dart';

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
          // الصورة
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

          // زر الإضافة أو العداد
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

          // اسم المنتج والسعر
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
