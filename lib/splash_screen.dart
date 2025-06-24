import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    // Start fade-out after a delay
    Timer(const Duration(seconds: 2), () {
      _controller.forward(); // Start fade-out
    });

    // Navigate to login page after fade-out completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Image.asset(
            'assets/image/karuna_darpan_logo.jpg',
            width: 250,
          ),
        ),
      ),
    );
  }
}
