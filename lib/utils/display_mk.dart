import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void showResponseDialog(BuildContext context, message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Results'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8, // Adjust width as needed
            child: MarkdownBody(data: message, selectable: true),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Got it'),
          ),
        ],
      );
    },
  );
}