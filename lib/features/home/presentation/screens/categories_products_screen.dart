// // // import 'package:ecommerce_app/features/products/presentation/components/categories_listview.dart';
// // // import 'package:ecommerce_app/features/products/presentation/components/categories_product_grid_view.dart';
// // // import 'package:flutter/material.dart';

// // // class CategoriesProductsScreen extends StatelessWidget {
// // //   const CategoriesProductsScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('data', style: Theme.of(context).textTheme.headlineLarge),
// // //       ),
// // //       body: ListView(
// // //         children: [
// // //           SizedBox(height: 100),
// // //           Text(
// // //             " dadadddddaaaaaadadadadadddddddddddddddddddddddddddadadad",
// // //             style: Theme.of(context).textTheme.bodyMedium,
// // //           ),
// // //           Text('data', style: Theme.of(context).textTheme.headlineMedium),
// // //           CategoriesListView(),
// // //           Text('data', style: Theme.of(context).textTheme.headlineMedium),
// // //           CategoriesProductGridView(),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:al_omda/core/utils/enum.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// // import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';

// // class ProductsByCategoryScreen extends StatelessWidget {
// //   const ProductsByCategoryScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final categoryName = ModalRoute.of(context)?.settings.arguments as String;

// //     return BlocBuilder<HomeCubit, HomeState>(
// //       builder: (context, state) {
// //         // Start loading data when screen opens
// //         WidgetsBinding.instance.addPostFrameCallback((_) {
// //           context.read<HomeCubit>().getProductsByCategory(categoryName);
// //         });

// //         if (state.productsByCategoryState == RequestState.loading) {
// //           return Center(child: CircularProgressIndicator());
// //         }

// //         if (state.productsByCategoryState == RequestState.loaded) {
// //           return Scaffold(
// //             appBar: AppBar(title: Text(categoryName)),
// //             body: GridView.builder(
// //               padding: EdgeInsets.all(16),
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 crossAxisSpacing: 16,
// //                 mainAxisSpacing: 16,
// //               ),
// //               itemCount: state.productsByCategory.length,
// //               itemBuilder: (context, index) {
// //                 final product = state.productsByCategory[index];
// //                 return Card(
// //                   child: Column(
// //                     children: [
// //                       Image.network(product.image),
// //                       Text("${product.price} ${product.unitName}"),
// //                       Text("وزن: ${product.weight}"),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         }

// //         if (state.productsByCategoryState == RequestState.error) {
// //           return Center(child: Text(state.productsByCategoryMessage));
// //         }

// //         return Center(child: Text("لا يوجد بيانات"));
// //       },
// //     );
// //   }
// // }
// // products_by_category_screen.dart

// import 'package:al_omda/core/global_widgets/product_card%20copy.dart';
// import 'package:al_omda/core/utils/enum.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
// import 'package:al_omda/features/home/data/models/categories_products_model.dart';

// class ProductsByCategoryScreen extends StatelessWidget {
//   const ProductsByCategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // 🛠 استقبال اسم التصنيف من الشاشة السابقة
//     final categoryName = ModalRoute.of(context)?.settings.arguments as String;

//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         // 🚀 نبدأ التحميل بعد فتح الصفحة مباشرة
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           context.read<HomeCubit>().getProductsByCategory(categoryName);
//         });

//         return Scaffold(
//           appBar: AppBar(title: Text(categoryName)),
//           body:
//               state.productsByCategoryState == RequestState.loading
//                   ? Center(child: CircularProgressIndicator())
//                   : state.productsByCategoryState == RequestState.loaded
//                   ? GridView.builder(
//                     padding: EdgeInsets.all(16),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                     ),
//                     itemCount: state.productsByCategory.length,
//                     itemBuilder: (context, index) {
//                       final product = state.productsByCategory[index];
//                       return ProductCard(product); // ← ProductCard هنا
//                     },
//                   )
//                   : Center(
//                     child: Text(
//                       state.productsByCategoryState == RequestState.error
//                           ? state.productsByCategoryMessage
//                           : "لا توجد بيانات",
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//         );
//       },
//     );
//   }
// }

import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/core/global_widgets/product_card.dart';
import 'package:al_omda/features/home/data/models/categories_products_model.dart';
import 'package:al_omda/core/utils/enum.dart'; // RequestState enum

class ProductsByCategoryScreen extends StatelessWidget {
  final String categoryName;

  const ProductsByCategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // 🚀 جلب المنتجات عند بناء الشاشة
    BlocProvider.of<HomeCubit>(context).getProductsByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // 👇 حالة التحميل
          if (state.productsByCategoryState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 👇 حالة النجاح
          if (state.productsByCategoryState == RequestState.loaded) {
            final List<CategoriesProductsModel> products =
                state.productsByCategory;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard<CategoriesProductsModel>(products[index]);
                },
              ),
            );
          }

          // 👇 حالة الخطأ
          if (state.productsByCategoryState == RequestState.error) {
            return Center(child: Text(state.productsByCategoryMessage));
          }

          // 👇 حالة افتراضية
          return const Center(child: Text('حدث خطأ غير متوقع'));
        },
      ),
    );
  }
}
