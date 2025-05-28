import 'package:al_omda/features/products/data/models/products_by_categories_model.dart';
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
            return const Center(child: CircularProgressIndicator());
          }
          if (state.productsByCategoryState == RequestState.loaded) {
            final List<ProductsModel> products =
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
