import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/presentation/components/categories_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/home/data/models/categories_model.dart';

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
            // 👇 حالة التحميل
            if (state.categoriesState == RequestState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            // 👇 حالة النجاح
            if (state.categoriesState == RequestState.loaded) {
              final List<HomeCategoriesModel> categories = state.categories;

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
                  return GestureDetector(
                    onTap: () {},
                    child: CategoryItem(category: categories[index]),
                  );
                },
              );
            }

            // 👇 حالة الخطأ
            if (state.categoriesState == RequestState.error) {
              return Center(
                child: Text(
                  state.categoriesMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              );
            }

            // 👇 الحالة الافتراضية
            return Center(child: Text("لا توجد بيانات"));
          },
        ),
      ),
    );
  }
}
