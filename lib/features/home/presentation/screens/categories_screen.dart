import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_screen_shimmer_loading.dart';
import 'package:al_omda/features/products/presentation/screens/products-by_categories_screen.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_item.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).categories)),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.categoriesState == RequestState.loading) {
            return const CategoriesScreenShimmerLoading();
          }
          if (state.categoriesState == RequestState.loaded) {
            final List<HomeCategoriesModel> categories = state.categoriesList;
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = state.categoriesList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductsByCategoryScreen(
                              categoryName: category.slug,
                            ),
                        // ),
                      ),
                    );
                  },
                  child: CategoryItem(category: categories[index]),
                );
              },
            );
          }

          if (state.categoriesState == RequestState.error) {
            return Center(
              child: Text(
                state.categoriesMessage,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
