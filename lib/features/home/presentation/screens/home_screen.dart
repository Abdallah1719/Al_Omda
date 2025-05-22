import 'package:al_omda/core/global_widgets/global_appbar.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/home/presentation/components/home_slider.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getHomeSliders(),

      child: Scaffold(
        appBar: GlobalAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ' S.of(context).home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'S.of(context).account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'S.of(context).cart',
            ),
          ],
        ),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  ' S.of(context).working_hours',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            HomeSlider(),
            VerticalSpace(2),
            // HomeTitles(
            //   text: S.of(context).categoriess,
            //   buttonText: S.of(context).viewAll,
            //   onTap: () {
            //     final homeBloc = BlocProvider.of<HomeBloc>(context);
            //     Navigator.pushNamed(
            //       context,
            //       AppRoutes.categoriesScreen,
            //       arguments: homeBloc,
            //     );
            //   },
            // ),
            // VerticalSpace(2),
            // CategoriesListView(),
            // HomeTitles(
            //   text: S.of(context).popularProducts,
            //   buttonText: S.of(context).shopNow,
            // ),
            // TopRatedProductGridView(),
          ],
        ),
      ),
    );
  }
}
