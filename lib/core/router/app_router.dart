import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/project/hungryy/presentation/pages/hungryy_detail_page.dart';
import '../../features/project/maxfashion/presentation/pages/maxfashion_detail_page.dart';

abstract final class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/case-study/hungryy',
        name: 'hungryy',
        builder: (context, state) => const HungryyDetailPage(),
      ),
      GoRoute(
        path: '/case-study/maxfashion',
        name: 'maxfashion',
        builder: (context, state) => const MaxfashionDetailPage(),
      ),
    ],
  );
}
