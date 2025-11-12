import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:application_about_me/domain/models/github_user_model.dart';
import 'package:application_about_me/ui/github_info/view_model/github_view_model.dart';
import 'package:application_about_me/ui/github_info/widgets/github_info_screen.dart';

@GenerateMocks([GitHubViewModel])
import 'github_screen_test.mocks.dart'; 

void main() {
  late MockGitHubViewModel mockViewModel;

  final mockUser = GitHubUser(
    login: 'gitCode5345',
    id: 12345,
    avatarUrl: 'http://example.com/avatar.png',
    htmlUrl: 'http://example.com',
    name: 'Test User',
    bio: 'Test Bio',
    publicRepos: 10,
    followers: 20,
    following: 30,
  );

  setUp(() {
    mockViewModel = MockGitHubViewModel();
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GitHubViewModel>.value(
          value: mockViewModel,
        ),
      ],
      child: const MaterialApp(
        home: GitHubScreen(),
      ),
    );
  }

  testWidgets('GitHubScreen показує індикатор під час завантаження (Loading State)',
      (WidgetTester tester) async {
    
    when(mockViewModel.state).thenReturn(GitHubLoadingState.loading);
    when(mockViewModel.user).thenReturn(null);
    when(mockViewModel.errorMessage).thenReturn(null);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Test User'), findsNothing);
  });

  testWidgets('GitHubScreen показує дані (Loaded State)',
      (WidgetTester tester) async {
    
    mockNetworkImagesFor(() async {
      when(mockViewModel.state).thenReturn(GitHubLoadingState.loaded);
      when(mockViewModel.user).thenReturn(mockUser);
      when(mockViewModel.errorMessage).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); 

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('@gitCode5345'), findsOneWidget);
      expect(find.text('Test Bio'), findsOneWidget);
      expect(find.text('Репозиторії'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });
  });

  testWidgets('GitHubScreen показує помилку (Error State)',
      (WidgetTester tester) async {
    
    when(mockViewModel.state).thenReturn(GitHubLoadingState.error);
    when(mockViewModel.user).thenReturn(null);
    when(mockViewModel.errorMessage).thenReturn('Щось пішло не так');

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    expect(find.text('Помилка завантаження даних!'), findsOneWidget);
    expect(find.text('Щось пішло не так'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Спробувати ще'), findsOneWidget);
  });
}
