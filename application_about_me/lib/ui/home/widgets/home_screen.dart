import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/ui/add/view_model/description_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DescriptionViewModel>();
    final descriptions = viewModel.descriptions;
    final isLoading = viewModel.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Резюме')),
      body: isLoading? Center(child: CircularProgressIndicator()) : 
      descriptions.isEmpty
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
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
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
                          Builder(
                            builder: (context) {
                              return ElevatedButton(
                                onPressed: () =>
                                    _showMenu(context, description, viewModel),
                                child: Icon(Icons.menu),
                              );
                            },
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

  void _showMenu(BuildContext context, description, viewModel) {
    showPopover(
      context: context,
      backgroundColor: Colors.white,
      radius: 12,
      arrowHeight: 15,
      arrowWidth: 30,
      bodyBuilder: (popoverContext) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 5)],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () async {
              Navigator.of(popoverContext).pop();
              await viewModel.deleteDescription(description.id);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Видалити', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
