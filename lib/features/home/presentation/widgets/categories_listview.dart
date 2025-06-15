import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_item.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.categoriesState == RequestState.loading) {
          return const CategoriesShimmerLoading();
        }

        if (state.categoriesState == RequestState.loaded) {
          final List<HomeCategoriesModel> categories = state.categoriesList;

          return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              viewportFraction: 0.4,
              enableInfiniteScroll: false,
              padEnds: false,
              initialPage: 0,
              onPageChanged: (index, reason) {},
            ),
            items:
                categories.map<Widget>((category) {
                  return CategoryItem(category: category);
                }).toList(),
          );
        }

        if (state.categoriesState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                (state.categoriesMessage.isEmpty)
                    ? "Something went wrong"
                    : state.categoriesMessage,
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
