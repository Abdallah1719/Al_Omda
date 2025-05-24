import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/presentation/components/categories_item.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/data/models/categories_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
                    // 👇 استخدم الويديجيت الجديد هنا
                    child: CategoryItem(category: category),
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
