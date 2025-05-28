import 'package:al_omda/features/products/presentation/widgets/product_card.dart';
import 'package:al_omda/features/products/data/models/products_top_rated_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/core/utils/enum.dart';

class TopRatedProductGridView extends StatelessWidget {
  const TopRatedProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state.productsTopRatedState == RequestState.loading) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.productsTopRatedState == RequestState.loaded) {
          final List<ProductsTopRatedModel> products = state.productsTopRated;

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
                return ProductCard<ProductsTopRatedModel>(products[index]);
              },
            ),
          );
        }

        if (state.productsTopRatedState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.productsTopRatedMessage)),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
