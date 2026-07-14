import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/project/presentation/pages/project_detail_page.dart';

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
        path: '/project/vitaguard',
        name: 'vitaguard',
        builder: (context, state) => const ProjectDetailPage(),
      ),
    ],
  );
}
