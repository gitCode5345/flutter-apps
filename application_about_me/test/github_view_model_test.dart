import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:application_about_me/data/repositories/github_repository.dart';
import 'package:application_about_me/domain/models/github_user_model.dart';
import 'package:application_about_me/ui/github_info/view_model/github_view_model.dart';

@GenerateMocks([GitHubRepository])
import 'github_view_model_test.mocks.dart'; 

void main() {
  late GitHubViewModel viewModel;
  late MockGitHubRepository mockRepository;

  final mockUser = GitHubUser(
    login: 'gitCode5345', id: 12345, avatarUrl: '', htmlUrl: '',
    publicRepos: 1, followers: 1, following: 1,
    name: 'Test User', bio: 'Test Bio'
  );

  setUp(() {
    mockRepository = MockGitHubRepository();
  });

  test('fetchUser: Успішне завантаження (Loaded State)', () async {
    when(mockRepository.getUserData())
        .thenAnswer((_) async => mockUser);
    
    viewModel = GitHubViewModel(mockRepository);
    
    await Future.delayed(Duration.zero);

    verify(mockRepository.getUserData()).called(1);
    expect(viewModel.state, GitHubLoadingState.loaded);
    expect(viewModel.user, mockUser);
    expect(viewModel.errorMessage, isNull);
  });

  test('fetchUser: Помилка завантаження (Error State)', () async {
    final errorMessage = 'Failed to load';
    when(mockRepository.getUserData())
        .thenThrow(Exception(errorMessage));

    viewModel = GitHubViewModel(mockRepository);
    
    await Future.delayed(Duration.zero);

    verify(mockRepository.getUserData()).called(1);
    expect(viewModel.state, GitHubLoadingState.error);
    expect(viewModel.user, isNull);
    expect(viewModel.errorMessage, isNotNull);
  });
}
