import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/routing/app_router.dart';
import 'package:application_about_me/ui/add/view_model/description_view_model.dart';
import 'package:application_about_me/data/repositories/description_repository.dart';
import 'package:application_about_me/data/services/github_service.dart';
import 'package:application_about_me/data/repositories/github_repository.dart';
import 'package:application_about_me/ui/github_info/view_model/github_view_model.dart';


void main() {
  final gitHubService = GitHubService();
  final descriptionRepository = DescriptionRepository();
  final gitHubRepository = GitHubRepository(gitHubService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DescriptionViewModel(descriptionRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => GitHubViewModel(gitHubRepository),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    ),
  );
}
