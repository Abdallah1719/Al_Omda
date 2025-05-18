import 'package:al_omda/app.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  runApp(const AlOmda());
}
