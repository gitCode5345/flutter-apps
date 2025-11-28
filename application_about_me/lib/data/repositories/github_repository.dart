import 'package:application_about_me/domain/models/github_user_model.dart';
import 'package:application_about_me/data/services/github_service.dart';

class GitHubRepository {
  final GitHubService _service;

  GitHubRepository(this._service);

  final String _defaultUsername = 'gitCode5345';

  Future<GitHubUser> getUserData() async {
    return await _service.fetchUser(_defaultUsername);
  }
}
