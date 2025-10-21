import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/ui/add/view_model/description_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DescriptionViewModel>();
    final descriptions = viewModel.descriptions;

    return Scaffold(
      appBar: AppBar(title: const Text('Резюме')),
      body: descriptions.isEmpty
          ? const Center(child: Text('Немає жодного опису'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: descriptions.length,
              itemBuilder: (context, index) {
                final description = descriptions[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    context.pushNamed('details', extra: description);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            description.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
