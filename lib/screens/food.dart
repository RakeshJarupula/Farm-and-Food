import 'dart:io';
import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farm_and_food/utils/display_mk.dart';
import 'package:farm_and_food/api/gemini_service.dart';
import 'package:farm_and_food/constants/promts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});
  
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  File? _image;
  bool _isLoading = false;

  void _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _sendImageToApi() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final prompt = FOOD_PROMPT;
      final imageBytes = await _image!.readAsBytes();
      final imagePart = DataPart('image/jpeg', imageBytes);
      final response = await geminiModel.generateContent([Content.multi([prompt, imagePart])]);

      showResponseDialog(context, response.text);
    } catch (e) {
      showResponseDialog(context, '{$e}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analyze Food',
          style: TextStyle(
            color: Color.fromARGB(255, 11, 1, 5),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset('assets/Backgrounds/food_home_bk.json'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                  )
                else
                  const Text(
                    'Select A Food Image To Explore It.',
                    style: TextStyle(
                      fontFamily: 'Intel-SemiBold',
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: const Text('📷 Camera', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: const Text('💿 Gallery', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendImageToApi,
                  child: const Text('🔍 Analyze', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Positioned(
              top: 10,
              left: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width * 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                child: Lottie.asset('assets/Backgrounds/food_loader.json'),
              ),
            ),
        ],
      ),
    );
  }
}
