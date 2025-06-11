// import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
// import 'package:al_omda/core/utils/enum.dart';
// import 'package:al_omda/features/home/data/models/home_categories_model.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
// import 'package:al_omda/features/home/presentation/widgets/categories_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class CategoriesListView extends StatelessWidget {
//   const CategoriesListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state.categoriesState == RequestState.loading) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state.categoriesState == RequestState.loaded) {
//           final List<HomeCategoriesModel> categories = state.categories;

//           return CarouselSlider(
//             options: CarouselOptions(
//               height: 200.0,
//               viewportFraction: 0.4,
//               enableInfiniteScroll: false,
//               padEnds: false,
//               initialPage: 0,

//               onPageChanged: (index, reason) {},
//             ),
//             items:
//                 categories.map<Widget>((category) {
//                   return GestureDetector(
//                     onTap: () {},

//                     child: CategoryItem(category: category),
//                   );
//                 }).toList(),
//           );
//         }

//         if (state.categoriesState == RequestState.error) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: Text(state.categoriesMessage)),
//           );
//         }

//         return SizedBox.shrink();
//       },
//     );
//   }
// }

// class ShimmerLoading extends StatelessWidget {
//   const ShimmerLoading({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//      CarouselSlider(
//             options: CarouselOptions(
//               height: 200.0,
//               viewportFraction: 0.4,
//               enableInfiniteScroll: false,
//               padEnds: false,
//               initialPage: 0,
//               onPageChanged: (index, reason) {},
//             ),
//         items: (context, index) => const Column(
//           children: [
//             ShimmerWidget.circular(
//               height: 100,
//               width: 100,
//             ),
//             SizedBox(height: 8),
//             ShimmerWidget.rectangular(
//               height: 15,
//               width: 120,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_item.dart';
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
          final List<HomeCategoriesModel> categories = state.categories;

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

class CategoriesShimmerLoading extends StatelessWidget {
  const CategoriesShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 0.4,
        enableInfiniteScroll: false,
        padEnds: false,
        initialPage: 0,
        onPageChanged: (index, reason) {},
      ),
      items: List.generate(
        5,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerWidget.circular(height: 100, width: 100),
              SizedBox(height: 12),
              ShimmerWidget.rectangular(height: 15, width: 120),
              SizedBox(height: 8),
              ShimmerWidget.rectangular(height: 12, width: 80),
            ],
          ),
        ),
      ),
    );
  }
}
