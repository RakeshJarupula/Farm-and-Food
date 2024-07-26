import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:farm_and_food/api/gemini_service.dart';

Future<String?> getHealthTip() async {
  try {
  final response = await geminiModel.generateContent(
    [Content.text('Generate a random healthy food tip in just one sentence. Be specific. start the response with Tip: ')]
    );
  return response.text;
  } catch (e) {
    return '';
  }
}

Future<String?> getFarmTip() async {
  try {
    final response = await geminiModel.generateContent(
    [Content.text('Generate a random crop/garden tip in just one sentence. Be specific. start the response with Tip: ')]
    );
    return response.text;
  } catch (e) {
    return '';
  }
  
  
}
