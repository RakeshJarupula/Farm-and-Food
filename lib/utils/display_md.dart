import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// void showResponseDialog(BuildContext context, message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Results'),
//         content: SingleChildScrollView(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8, 
//             child: MarkdownBody(data: message, selectable: true),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Got it'),
//           ),
//         ],
//       );
//     },
//   );
// }

void showResponseDialog(BuildContext context, message) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16)
              ),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildCardsFromMessage(message),
              ),
            ),
          );
        },
      );
    },
  );
}

List<Widget> _buildCardsFromMessage(message) {
  // Split the message into sections
  final sections = message.split('The ');

  // Define colors for the cards
  final colors = [
    Colors.blue[50],
    Colors.green[50],
    Colors.yellow[50],
    Colors.red[50],
    Colors.orange[50],
    Colors.purple[50],
  ];

  // Generate cards for each section
  return List<Widget>.generate(sections.length, (index) {
    if (sections[index].trim().isEmpty) return Container();
    return Card(
      color: colors[index % colors.length],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MarkdownBody(
          data: '## ' + sections[index],
          selectable: true,
        ),
      ),
    );
  });
}
