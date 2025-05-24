import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/categories/data/models/categories_model.dart';
import 'package:al_omda/features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'package:al_omda/features/categories/presentation/widgets/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state.categoriesState == RequestState.loading) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.categoriesState == RequestState.loaded) {
          final List<CategoriesModel> categories = state.categories;

          return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: 0.3,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {},
            ),
            items:
                categories.map<Widget>((category) {
                  return GestureDetector(
                    onTap: () {},

                    child: CategoryItem(category: category),
                  );
                }).toList(),
          );
        }

        if (state.categoriesState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.categoriesMessage)),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
