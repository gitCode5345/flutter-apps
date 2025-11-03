import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/routing/app_router.dart';
import 'package:application_about_me/ui/add/view_model/description_view_model.dart';
import 'package:application_about_me/data/repositories/description_repository.dart';
import 'package:application_about_me/data/services/github_service.dart';
import 'package:application_about_me/data/repositories/github_repository.dart';
import 'package:application_about_me/ui/github_info/view_model/github_view_model.dart';
import 'package:application_about_me/data/services/theme_service.dart';
import 'package:application_about_me/ui/settings/view_model/theme_view_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final gitHubService = GitHubService();
  final descriptionRepository = DescriptionRepository();
  final gitHubRepository = GitHubRepository(gitHubService);
  final themeService = ThemeService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DescriptionViewModel(descriptionRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => GitHubViewModel(gitHubRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeViewModel(themeService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();

    return MaterialApp.router(
      routerConfig: appRouter,
      
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: themeViewModel.themeMode, 
    );
  }
}
