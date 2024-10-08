import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:farm_and_food/screens/food.dart';
import 'package:farm_and_food/screens/farm.dart';
import 'package:particles_fly/particles_fly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://rakeshjarupula.github.io/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double minSize = 150;
    double lottieSize = screenWidth * 0.13 < minSize ? minSize : screenWidth * 0.13;
    double circleSize = screenWidth * 0.15 < minSize ? minSize : screenWidth * 0.15;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 1,
            child: Lottie.asset('assets/Backgrounds/back_anim.json'),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 95, sigmaY: 95),
              child: const SizedBox(),
            ),
          ),
          ParticlesFly(
            height: screenHeight,
            width: screenWidth,
            lineStrokeWidth: 0.1,
            connectDots: true,
            numberOfParticles: 50,
            awayRadius: 100,
            speedOfParticles: 1,
            isRandomColor: true,
            maxParticleSize: 7,
            awayAnimationCurve: Curves.bounceOut,
            awayAnimationDuration: const Duration(milliseconds: 10),
            isRandSize: true,
            enableHover: true,
            hoverRadius: 30,
            lineColor: const Color.fromARGB(90, 149, 148, 149),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Farm & Food Insights💡',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Poppins',
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Analyze Plant Disease and Food Hygiene Using Gemini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Intel-SemiBold',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FarmPage()),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.95),
                              Colors.white.withOpacity(0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(7, 7),
                              blurRadius: 7,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              offset: const Offset(-3, -3),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Lottie.asset(
                            'assets/Backgrounds/farm_home.json',
                            width: lottieSize,
                            height: lottieSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FoodPage()),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.95),
                              Colors.white.withOpacity(0.7),
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(7, 7),
                              blurRadius: 7,
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.6),
                              offset: const Offset(-3, -3),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Lottie.asset(
                            'assets/Backgrounds/food_home.json',
                            width: lottieSize,
                            height: lottieSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Made with ❤️ by ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Rakesh Jarupula',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _launchUrl,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
