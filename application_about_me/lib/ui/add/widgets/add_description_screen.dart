import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:application_about_me/domain/models/description_model.dart';
import 'package:application_about_me/ui/add/view_model/description_view_model.dart';

class AddDescriptionScreen extends StatefulWidget {
  final Description? description;

  const AddDescriptionScreen({super.key, this.description});

  @override
  State<AddDescriptionScreen> createState() => _AddDescriptionScreenState();
}

class _AddDescriptionScreenState extends State<AddDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.description != null) {
      _titleController.text = widget.description!.title;
      _textController.text = widget.description!.text;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _saveDescription() {
    if (_formKey.currentState!.validate()) {
      context.read<DescriptionViewModel>().addDescription(
        _titleController.text,
        _textController.text,
      );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.description != null ? 'Дублювати опис' : 'Додати опис';
    const buttonText = 'Додати';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                onPressed: _saveDescription,
                child: const Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
