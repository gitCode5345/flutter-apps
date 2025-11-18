import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:application_about_me/data/repositories/github_repository.dart';
import 'package:application_about_me/data/services/github_service.dart';
import 'package:application_about_me/domain/models/github_user_model.dart';

@GenerateMocks([GitHubService])
import 'github_repository_test.mocks.dart';

void main() {
  late GitHubRepository repository;
  late MockGitHubService mockService;
  late GitHubUser mockUser;

  setUp(() {
    mockService = MockGitHubService();
    repository = GitHubRepository(mockService);

    mockUser = GitHubUser(
      login: 'gitCode5345', id: 1, avatarUrl: '', htmlUrl: '',
      publicRepos: 1, followers: 1, following: 1
    );
  });

  test('getUserData має викликати service.fetchUser з правильним defaultUsername', () async {
    when(mockService.fetchUser(any))
      .thenAnswer((_) async => mockUser);

    await repository.getUserData();

    verify(mockService.fetchUser('gitCode5345')).called(1);
  });
}
