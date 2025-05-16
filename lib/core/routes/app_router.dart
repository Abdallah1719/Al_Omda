import 'package:al_omda/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [GoRoute(path: "/", builder: (context, state) => SplashScreen())],
);
