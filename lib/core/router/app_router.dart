import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/project/presentation/pages/hungryy_detail_page.dart';
import '../../features/project/presentation/pages/vitaguard_detail_page.dart';

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
        path: '/project/:projectId',
        name: 'project',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId'] ?? '';
          return ProjectDetailPage(projectId: projectId);
        },
      ),
      GoRoute(
        path: '/case-study/hungryy',
        name: 'hungryy',
        builder: (context, state) => const HungryyDetailPage(),
      ),
    ],
  );
}
