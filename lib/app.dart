import 'package:al_omda/core/routes/app_router.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class AlOmda extends StatelessWidget {
  const AlOmda({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
