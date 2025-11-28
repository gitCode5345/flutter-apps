import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application_about_me/domain/models/github_user_model.dart';

class GitHubService {
  final String _baseUrl = 'https://api.github.com/users/';
  final http.Client _client;

  GitHubService({http.Client? client}) : _client = client ?? http.Client();

  Future<GitHubUser> fetchUser(String username) async {
    final response = await _client.get(Uri.parse('$_baseUrl$username'));

    if (response.statusCode == 200) {
      return GitHubUser.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load GitHub user: ${response.statusCode}');
    }
  }
}
