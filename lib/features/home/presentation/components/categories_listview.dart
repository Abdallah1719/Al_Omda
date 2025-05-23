// import 'package:al_omda/features/home/data/models/categories_model.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class CategoriesListView extends StatelessWidget {
//   const CategoriesListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state is HomeInitial) {
//           return const SizedBox.shrink();
//         }

//         if (state is HomeCategoriesLodding) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state is HomeCategoriesSucsess) {
//           return CarouselSlider(
//             options: CarouselOptions(
//               height: 200.0,
//               viewportFraction: 0.3,
//               enableInfiniteScroll: false,
//               onPageChanged: (index, reason) {},
//             ),
//             items:
//                 state.homeCategories.map((category) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Navigator.pushNamed(
//                       //   context,
//                       //   '/categoriesDetailsScreen', // استبدل بمسارك الصحيح
//                       //   arguments: category,
//                       // );
//                     },
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ClipOval(
//                           child: CachedNetworkImage(
//                             imageUrl: category.icon,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                             placeholder:
//                                 (context, url) =>
//                                     Center(child: CircularProgressIndicator()),
//                             errorWidget:
//                                 (context, url, error) => Icon(Icons.error),
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           category.name,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyLarge,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//           );
//         }

//         if (state is HomeCategoriesFailure) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: Text(state.errorMassage)),
//           );
//         }

//         return SizedBox.shrink(); // حالة افتراضية
//       },
//     );
//   }
// }

import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/data/models/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        // 👇 حالة التحميل
        if (state.categoriesState == RequestState.loading) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 👇 حالة النجاح
        if (state.categoriesState == RequestState.loaded) {
          final List<HomeCategoriesModel> categories = state.categories;

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
                    onTap: () {
                      // يمكنك هنا تمرير بيانات الفئة إلى الشاشة التالية
                      // Navigator.pushNamed(context, '/categoriesDetails', arguments: category);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: category.icon,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            placeholder:
                                (_, url) =>
                                    Center(child: CircularProgressIndicator()),
                            errorWidget:
                                (_, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          category.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
          );
        }

        // 👇 حالة الخطأ
        if (state.categoriesState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.categoriesMessage)),
          );
        }

        // 👇 حالة افتراضية (مثلًا: initial)
        return SizedBox.shrink();
      },
    );
  }
}
