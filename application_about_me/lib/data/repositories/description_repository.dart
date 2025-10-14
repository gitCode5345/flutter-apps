import 'package:application_about_me/domain/models/description_model.dart';

class DescriptionRepository {
  final List<Description> _description = [
    Description(
      title: "Flutter розробник",
      text: "Flutter, Dart, Firebase, Git, Provider, GoRouter.",
    ),
  ];

  List<Description> getAllDescriptions() => List.unmodifiable(_description);

  void addDescription(Description description) {
    _description.add(description);
  }
}
