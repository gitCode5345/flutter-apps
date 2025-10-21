import 'package:flutter/foundation.dart';
import 'package:application_about_me/domain/models/github_user_model.dart';
import 'package:application_about_me/data/repositories/github_repository.dart';

enum GitHubLoadingState { initial, loading, loaded, error }

class GitHubViewModel extends ChangeNotifier {
  final GitHubRepository _repository;

  GitHubViewModel(this._repository) {
    fetchUser();
  }

  GitHubUser? _user;
  GitHubLoadingState _state = GitHubLoadingState.initial;
  String? _errorMessage;

  GitHubUser? get user => _user;
  GitHubLoadingState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUser() async {
    if (_state == GitHubLoadingState.loading) return;

    _state = GitHubLoadingState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _repository.getUserData();
      _state = GitHubLoadingState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = GitHubLoadingState.error;
    } finally {
      notifyListeners();
    }
  }
}