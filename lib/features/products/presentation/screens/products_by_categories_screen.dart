import 'package:al_omda/core/global_widgets/products_shimmer_loading.dart';
import 'package:al_omda/core/services/service_locator.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  getIt<ProductsCubit>()..getProductsByCategories(categoryName),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(categoryName)),
        body: BlocBuilder<ProductsCubit, ProductsState>(
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
            if (state.productsByCategoryNameState == RequestState.error) {
              return Center(child: Text(state.productsByCategoryNameMessage));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
