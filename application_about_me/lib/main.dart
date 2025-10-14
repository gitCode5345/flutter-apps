import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/routing/app_router.dart';
import 'package:application_about_me/ui/core/view_model/description_view_model.dart';
import 'package:application_about_me/data/repositories/description_repository.dart';

void main() {
  final descriptionRepository = DescriptionRepository();

  runApp(
    ChangeNotifierProvider(
      create: (_) => DescriptionViewModel(descriptionRepository),
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    ),
  );
}
