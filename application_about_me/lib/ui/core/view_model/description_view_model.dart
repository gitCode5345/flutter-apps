import 'package:flutter/foundation.dart';
import 'package:application_about_me/domain/models/description_model.dart';
import 'package:application_about_me/data/repositories/description_repository.dart';

class DescriptionViewModel extends ChangeNotifier {
  final DescriptionRepository _repository;

  DescriptionViewModel(this._repository);

  List<Description> get descriptions => _repository.getAllDescriptions();

  void addDescription(Description description) {
    _repository.addDescription(description);
    notifyListeners();
  }
}
