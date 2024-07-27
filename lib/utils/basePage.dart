import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:farm_and_food/utils/display_md.dart';
import 'package:farm_and_food/api/gemini_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  File? _image;
  bool _isLoading = false;

  String get title;
  Part get prompt;
  String get task;
  String get backgroundAsset;
  String get loaderAsset;

  @override
  void initState() {
    super.initState();
  }

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
      final imageBytes = await _image!.readAsBytes();
      final imagePart = DataPart('image/jpeg', imageBytes);
      final response = await geminiModel.generateContent([Content.multi([imagePart, prompt])]);

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
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 11, 1, 5),
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(backgroundAsset),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
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
                         Text(
                          task,
                          style: const TextStyle(
                            fontFamily: 'Intel-SemiBold',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 5, 8, 29)),
                            ),
                            onPressed: () => _pickImage(ImageSource.camera),
                            child: const Text('📷 Camera', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 9, 90, 47)),
                            ),
                            onPressed: () => _pickImage(ImageSource.gallery),
                            child: const Text('💿 Gallery', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 94, 11, 11)),
                            ),
                        onPressed: _sendImageToApi,
                        child: const Text('🔍 Analyze', style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Positioned(
              top: 10,
              left: (MediaQuery.of(context).size.width / 2) - (MediaQuery.of(context).size.width * 0.1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                child: Lottie.asset(loaderAsset),
              ),
            ),
        ],
      ),
    );
  }
}
