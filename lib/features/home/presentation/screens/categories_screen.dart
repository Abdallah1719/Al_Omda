import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/products/presentation/screens/products-by_categories_screen.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeCategories(),
      child: Scaffold(
        appBar: AppBar(title: Text('التصنيفات'), centerTitle: true),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.categoriesState == RequestState.loading) {
              return const CategoriesGridShimmerLoading();
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
                  final categoriesCubit = BlocProvider.of<HomeCubit>(context);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BlocProvider.value(
                                value: categoriesCubit,
                                child: ProductsByCategoryScreen(
                                  categoryName: category.slug,
                                ),
                              ),
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
            }
            return Center(child: Text("لا توجد بيانات"));
          },
        ),
      ),
    );
  }
}

class CategoriesGridShimmerLoading extends StatelessWidget {
  const CategoriesGridShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
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
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Category icon/image shimmer
                ShimmerWidget.circular(height: 60, width: 60),
                SizedBox(height: 12),
                // Category name shimmer
                ShimmerWidget.rectangular(height: 16, width: 100),
                SizedBox(height: 6),
                // Category subtitle shimmer
                ShimmerWidget.rectangular(height: 12, width: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}
