import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:application_about_me/data/services/github_service.dart';
import 'package:application_about_me/domain/models/github_user_model.dart';

@GenerateMocks([http.Client])
import 'github_service_test.mocks.dart';

void main() {
  late GitHubService service;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    service = GitHubService(client: mockClient);
  });

  final mockUserJson = jsonEncode({
    'login': 'testuser',
    'id': 1,
    'avatar_url': 'http://avatar.url',
    'html_url': 'http://github.url',
    'name': 'Test User',
    'bio': 'Test bio text',
    'public_repos': 5,
    'followers': 10,
    'following': 2
  });

  test('fetchUser: Успіх (200) - має парсити JSON та повертати GitHubUser', () async {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(mockUserJson, 200));

    final user = await service.fetchUser('testuser');

    expect(user, isA<GitHubUser>());
    expect(user.login, 'testuser');
    expect(user.name, 'Test User');
    expect(user.publicRepos, 5);
  });

  test('fetchUser: Помилка (404) - має кидати Exception', () async {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response('Not Found', 404));

    final call = service.fetchUser('testuser');

    expect(call, throwsA(isA<Exception>()));
  });
}
