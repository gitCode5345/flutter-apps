import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Детальніше про мене"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          "- Я навчаюся в університеті \"ХПІ\"\n"
          "- Обожнюю програмувати та вивчати нові технології для створення цікавих додатків\n"
          "- Найкраще я знаю Python, але можливості Dart + Flutter, дуже дивують та зацікавлюють мене",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}