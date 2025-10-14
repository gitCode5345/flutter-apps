import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/domain/models/description_model.dart';
import 'package:application_about_me/ui/core/view_model/description_view_model.dart';

class AddDescriptionScreen extends StatefulWidget {
  const AddDescriptionScreen({super.key});

  @override
  State<AddDescriptionScreen> createState() => _AddDescriptionScreenState();
}

class _AddDescriptionScreenState extends State<AddDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Додати опис')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Назва'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Уведіть, будь ласка назву';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Опис'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Уведіть, будь ласка опис';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final description = Description(
                      title: _titleController.text,
                      text: _textController.text,
                    );

                    context.read<DescriptionViewModel>().addDescription(description);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Додати'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
