// import 'package:al_omda/features/products/data/models/products_model.dart';
// import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/products/presentation/widgets/product_card.dart';
// import 'package:al_omda/core/utils/enum.dart';

// class ProductsByCategoryScreen extends StatelessWidget {
//   final String categoryName;
//   const ProductsByCategoryScreen({super.key, required this.categoryName});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(categoryName), centerTitle: true),
//       body: BlocBuilder<ProductsCubit, ProductsState>(
//         builder: (context, state) {
//           if (state.productsByCategoryState == RequestState.loading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state.productsByCategoryState == RequestState.loaded) {
//             final List<ProductsModel> products =
//                 state.productsByCategory;

//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.65,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                 ),
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                    return ProductCard(product: products[index]);
//                 },
//               ),
//             );
//           }
//           if (state.productsByCategoryState == RequestState.error) {
//             return Center(child: Text(state.productsByCategoryMessage));
//           }
//           return const Center(child: Text('حدث خطأ غير متوقع'));
//         },
//       ),
//     );
//   }
// }

import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/products/presentation/widgets/product_card.dart';
import 'package:al_omda/core/utils/enum.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String categoryName;
  const ProductsByCategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.productsByCategoryState == RequestState.loading) {
            return const ProductsByCategoryShimmerLoading();
          }
          if (state.productsByCategoryState == RequestState.loaded) {
            final List<ProductsModel> products = state.productsByCategory;

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
                  return ProductCard(product: products[index]);
                },
              ),
            );
          }
          if (state.productsByCategoryState == RequestState.error) {
            return Center(child: Text(state.productsByCategoryMessage));
          }
          return const Center(child: Text('حدث خطأ غير متوقع'));
        },
      ),
    );
  }
}

class ProductsByCategoryShimmerLoading extends StatelessWidget {
  const ProductsByCategoryShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
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
        itemCount: 8, // Show 8 shimmer items
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image shimmer
                  Expanded(
                    flex: 3,
                    child: ShimmerWidget.rectangular(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Product title shimmer
                  ShimmerWidget.rectangular(width: double.infinity, height: 16),
                  SizedBox(height: 4),
                  // Product subtitle shimmer
                  ShimmerWidget.rectangular(width: 120, height: 14),
                  SizedBox(height: 8),
                  // Price shimmer
                  ShimmerWidget.rectangular(width: 80, height: 18),
                  SizedBox(height: 4),
                  // Rating and favorite shimmer
                  Row(
                    children: [
                      ShimmerWidget.rectangular(width: 60, height: 12),
                      Spacer(),
                      ShimmerWidget.circular(width: 24, height: 24),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
