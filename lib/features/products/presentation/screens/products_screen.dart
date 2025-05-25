import 'package:al_omda/features/categories/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'package:al_omda/features/products/data/models/most_resent_products_model.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/core/global_widgets/product_card.dart';
import 'package:al_omda/core/utils/enum.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getMostRecentProducts();

    return Scaffold(
      appBar: AppBar(title: Text('Products'), centerTitle: true),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.productsState == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.productsState == RequestState.loaded) {
            final List<MostRecentProductsModel> products = state.products;

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
                  return ProductCard<MostRecentProductsModel>(products[index]);
                },
              ),
            );
          }
          if (state.productsState == RequestState.error) {
            return Center(child: Text(state.productsMessage));
          }
          return const Center(child: Text('حدث خطأ غير متوقع'));
        },
      ),
    );
  }
}
