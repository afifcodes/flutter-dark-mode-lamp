import 'package:flutter/material.dart';
import 'package:flutter_dark_mode_lamp/libs/system_ui.dart';
import 'package:lottie/lottie.dart';

void main() =>
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 500));
    _animationController.addListener(() {
      if (_animationController.value > 0.4) {
        setState(() {
          isDark = false;
        });
      } else {
        setState(() {
          isDark = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    systemUi();
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        width: double.infinity,
        color: isDark ? Colors.black87 : Colors.cyan.shade900,
        child: Center(
          child: Transform.scale(
            scale: 8,
            child: GestureDetector(
              onTap: () {
                if (isDark) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              },
              child: Lottie.asset('assets/lamp.json',
                  controller: _animationController, onLoaded: (composition) {
                _animationController.duration = composition.duration;
              }),
            ),
          ),
        ),
      ),
    );
  }
}
