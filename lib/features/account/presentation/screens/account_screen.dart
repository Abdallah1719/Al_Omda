import 'package:al_omda/core/routes/routes_constances.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:al_omda/features/account/presentation/screens/account_info_screen.dart';
import 'package:al_omda/features/account/presentation/widgets/country_dialog.dart';
import 'package:al_omda/features/account/presentation/widgets/custom_list_tile.dart';
import 'package:al_omda/features/account/presentation/widgets/language_dialog.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Accountscreen extends StatelessWidget {
  const Accountscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<AccountCubit>()
                ..getAccountInfo()
                ..navigateToEditScreen(),
      child: Column(
        children: [
          VerticalSpace(3),
          CustomAccountTile(
            title: S.of(context).account_info,
            icon: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create:
                            (context) =>
                                getIt<AccountCubit>()..getAccountInfo(),
                        child: const AccountInfoScreen(),
                      ),
                ),
              );
              // RoutesMethods.pushNavigate(
              //   context,
              //   RoutesConstances.accountInfoPath,
              // );
            },
          ),
          CustomAccountTile(
            title: S.of(context).my_addresess,
            icon: Icons.location_on,
            onTap: () {
              RoutesMethods.pushNavigate(
                context,
                RoutesConstances.myAddresessPath,
              );
            },
          ),
          CustomAccountTile(
            title: S.of(context).myorders,
            icon: Icons.shopping_bag,
            onTap: () {
              RoutesMethods.pushNavigate(
                context,
                RoutesConstances.myOrdersPath,
              );
            },
          ),
          CustomAccountTile(
            title: S.of(context).language,
            icon: Icons.language,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ChangeLanguageDialog(),
              );
            },
          ),
          CustomAccountTile(
            title: S.of(context).country,
            icon: Icons.flag,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CountryDialog(),
              );
            },
          ),
          CustomAccountTile(
            title: S.of(context).contact_us,
            icon: Icons.phone,
            onTap: () {
              // navigate to contact us
            },
          ),
          CustomAccountTile(
            title: S.of(context).about_us_terms,
            icon: Icons.info,
            onTap: () {
              // navigate to about/terms/privacy
            },
          ),
          CustomAccountTile(
            title: S.of(context).log_in,
            icon: Icons.login,
            onTap: () {
              // navigate to login screen
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.phone, color: Colors.green),
                  onPressed: () {},
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.blue),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Center(
              child: Text(
                'version 01.00',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
