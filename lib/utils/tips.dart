import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:farm_and_food/api/gemini_service.dart';

Future<String?> getHealthTip() async {
  const String textPartFood = '''Generate food health tip in just one sentence. Be specific and concise. Nothing else. Start the output with "Tip:" ''';
  final response = await geminiModel.generateContent([Content.text(textPartFood)]);
  return response.text;
}

Future<String?> getFarmTip() async {
  const String textPartFarm = '''Generate farm tip in just one sentence. Be specific and concise. Nothing else.. Start the output with "Tip:" ''';
  final response = await geminiModel.generateContent([Content.text(textPartFarm)]);
  return response.text;
}
