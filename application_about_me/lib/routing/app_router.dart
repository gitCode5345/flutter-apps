import 'package:go_router/go_router.dart';
import 'package:application_about_me/domain/models/description_model.dart';
import 'package:application_about_me/ui/add/widgets/add_description_screen.dart';
import 'package:application_about_me/ui/navigation_bar/widgets/navigation_bar_widget.dart';
import 'package:application_about_me/ui/details/widgets/details_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const MainNavigationWidget(), 
    ),
    GoRoute(
      path: '/details',
      name: 'details',
      builder: (context, state) {
        final description = state.extra as Description;
        return DetailsScreen(description: description);
      },
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      builder: (context, state) {
        final description = state.extra as Description?;
        return AddDescriptionScreen(description: description);
      },
    ),
  ],
);
