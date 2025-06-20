import 'package:al_omda/core/global_widgets/global_appbar.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
import 'package:al_omda/features/cart/presentation/screens/cart_screen.dart';
import 'package:al_omda/features/home/presentation/widgets/home_body.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late HomeCubit _homeCubit;
  late ProductsCubit _productsCubit;

  final List<Widget> _screens = [HomeBody(), Accountscreen(), CartScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _productsCubit = getIt<ProductsCubit>();
    
    // Initial data load
    _loadData();
  }

  void _loadData() {
    _homeCubit.getHomeSliderItems();
    _homeCubit.getHomeCategories();
    _productsCubit.getHomeProductsTopRated();
  }

  @override
  void dispose() {
    // Only dispose if they are not singletons in service locator
    // If they are registered as singletons, don't dispose them
    // _homeCubit.close();
    // _productsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _productsCubit),
      ],
      child: BlocListener<LocaleCubit, String>(
        listener: (context, locale) {
          // Reload data when language changes
          _loadData();
        },
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
      ),
    );
  }
}