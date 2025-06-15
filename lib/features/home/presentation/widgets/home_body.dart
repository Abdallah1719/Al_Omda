import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/presentation/screens/categories_screen.dart';
import 'package:al_omda/features/home/presentation/widgets/categories_listview.dart';
import 'package:al_omda/features/home/presentation/widgets/home_slider.dart';
import 'package:al_omda/features/home/presentation/widgets/home_titles.dart';
import 'package:al_omda/features/home/presentation/widgets/top_rated_products_gridview.dart';
import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              S.of(context).working_hours,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        HomeSlider(),
        VerticalSpace(2),
        HomeTitles(
          text: S.of(context).categories,
          buttonText: S.of(context).viewAll,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create:
                          (context) => getIt<HomeCubit>()..getHomeCategories(),
                      child: const CategoriesScreen(),
                    ),
              ),
            );
          },
        ),
        VerticalSpace(2),
        CategoriesListView(),
        HomeTitles(
          text: S.of(context).popularProducts,
          buttonText: S.of(context).shopNow,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductsScreen()),
            );
          },
        ),
        TopRatedProductsGridView(),
      ],
    );
  }
}
