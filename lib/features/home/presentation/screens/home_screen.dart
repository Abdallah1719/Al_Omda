import 'package:al_omda/core/global_widgets/global_appbar.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/categories/presentation/controller/cubit/categories_cubit.dart';
import 'package:al_omda/features/categories/presentation/widgets/categories_listview.dart';
import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
import 'package:al_omda/features/home/presentation/components/cart_body.dart';
import 'package:al_omda/features/home/presentation/components/home_body.dart';
import 'package:al_omda/features/home/presentation/components/home_slider.dart';
import 'package:al_omda/features/home/presentation/components/home_titles.dart';
import 'package:al_omda/features/home/presentation/components/top_rated_products_gridview.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeBody(), Accountscreen(), CartBody()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  getIt<HomeCubit>()
                    ..getHomeSliders()
                    ..getHomeProductsTopRated(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoriesCubit>()..getCategories(),
        ),
      ],
      child: Scaffold(
        appBar: GlobalAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).home,
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: S.of(context).account,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: S.of(context).cart,
            ),
          ],
        ),

        body: _screens[_currentIndex],
      ),
    );
  }
}
