import 'package:al_omda/features/products/presentation/widgets/products_shimmer_loading.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:al_omda/features/products/presentation/widgets/product_card.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsByCategoryNameGridView extends StatelessWidget {
  const ProductsByCategoryNameGridView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.productsByCategoryNameState == RequestState.loading) {
          return const ProductsShimmerLoading();
        }
        if (state.productsByCategoryNameState == RequestState.loaded) {
          final List<ProductModel> products = state.productsByCategoryName;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
        if (state.productsByCategoryNameState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.productsByCategoryNameMessage)),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
