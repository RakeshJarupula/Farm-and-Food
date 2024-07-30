import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void showResponseDialog(BuildContext context, message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white.withOpacity(0.5),
            content: SizedBox(
              width: constraints.maxWidth * 0.5,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight * 0.8,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: _buildCardsFromMessage(message),
                  ),
                ),
              ),
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Got it!'),
              ),
            ],
          );
        },
      );
    },
  );
}

List<Widget> _buildCardsFromMessage(String message) {
  final sections = message.split('@');

  final colors = [
    const Color.fromARGB(200, 122, 187, 241),
    const Color.fromARGB(200, 142, 245, 142),
    const Color.fromARGB(200, 244, 235, 133),
    const Color.fromARGB(200, 248, 144, 166),
    const Color.fromARGB(200, 238, 201, 146),
    const Color.fromARGB(200, 236, 158, 246),
  ];

  return List<Widget>.generate(sections.length, (index) {
    if (sections[index].trim().isEmpty) return Container();
    return Card(
      color: colors[index % colors.length],
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MarkdownBody(
          data: sections[index],
          selectable: true,
        ),
      ),
    );
  });
}
