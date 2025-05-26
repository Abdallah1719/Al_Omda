import 'package:al_omda/app.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();
  runApp(const AlOmda());
  // print('Token from cache: ${getIt<CacheHelper>().getData(key: "token")}');
}
