import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/ui/github_info/view_model/github_view_model.dart';

class GitHubScreen extends StatelessWidget {
  const GitHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GitHubViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Профіль GitHub')),
      body: Center(
        child: _buildBody(viewModel),
      ),
    );
  }

  Widget _buildBody(GitHubViewModel viewModel) {
    switch (viewModel.state) {
      case GitHubLoadingState.initial:
      case GitHubLoadingState.loading:
        return const CircularProgressIndicator();
      case GitHubLoadingState.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Помилка завантаження даних!'),
            Text(viewModel.errorMessage ?? 'Невідома помилка.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.fetchUser, 
              child: const Text('Спробувати ще'),
            ),
          ],
        );
      case GitHubLoadingState.loaded:
        final user = viewModel.user!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(height: 16),
              Text(
                user.name ?? user.login,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (user.name != null) 
                Text(
                  '@${user.login}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              const SizedBox(height: 16),
              if (user.bio != null) 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    user.bio!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
              
              const SizedBox(height: 24),
              
              // НОВИЙ ВІДЖЕТ ДЛЯ СТАТИСТИКИ
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatsCard(
                    count: user.publicRepos,
                    label: 'Репозиторії',
                  ),
                  StatsCard(
                    count: user.followers,
                    label: 'Підписники',
                  ),
                  StatsCard(
                    count: user.following,
                    label: 'Підписки',
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              Text(
                'Посилання на профіль (неактивне):',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
              Text(
                user.htmlUrl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        );
    }
  }
}

class StatsCard extends StatelessWidget {
  final int count;
  final String label;

  const StatsCard({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent, // Для візуального акценту
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}