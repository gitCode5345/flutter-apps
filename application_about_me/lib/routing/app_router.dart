import 'package:go_router/go_router.dart';

import 'package:application_about_me/ui/screens/home_screen.dart';
import 'package:application_about_me/ui/screens/details_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
);
