import 'package:application_about_me/domain/models/description_model.dart';

class DescriptionRepository {
  final List<Description> _description = [];

  List<Description> getAllDescriptions() => List.unmodifiable(_description);

  void addDescription(Description description) {
    _description.add(description);
  }

  void updateDescription(Description oldDescription, Description newDescription) {
    final index = _description.indexOf(oldDescription);
    if (index != -1) {
      _description[index] = newDescription;
    }
  }
}
