import 'package:farm_and_food/constants/gemini_api.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final GenerativeModel geminiModel = GenerativeModel(
  model: 'gemini-1.5-pro',
  apiKey: GEMINI_API_KEY,
);