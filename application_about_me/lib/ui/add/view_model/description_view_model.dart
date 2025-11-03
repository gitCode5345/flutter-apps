import 'package:flutter/foundation.dart';
import 'package:application_about_me/domain/models/description_model.dart';
import 'package:application_about_me/data/repositories/description_repository.dart';

class DescriptionViewModel extends ChangeNotifier {
  final DescriptionRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DescriptionViewModel(this._repository) {
    loadDescriptions();
  }

  Future<void> loadDescriptions() async {
    _isLoading = true;
    notifyListeners();

    await _repository.loadDescriptions();

    _isLoading = false;
    notifyListeners();
  }

  List<Description> get descriptions => _repository.getAllDescriptions();

  Future<void> addDescription(String title, String text) async {
    await _repository.addDescription(title, text);
    notifyListeners();
  }
  
  Future<void> updateDescription(Description oldDescription, Description newDescription) async {
    await _repository.updateDescription(oldDescription, newDescription);
    notifyListeners();
  }

  Future<void> deleteDescription(int id) async {
    await _repository.deleteDescription(id);
    notifyListeners();
  }
}
