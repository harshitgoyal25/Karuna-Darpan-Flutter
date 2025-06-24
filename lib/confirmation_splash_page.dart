import 'package:flutter/material.dart';

class ConfirmationSplashPage extends StatefulWidget {
  const ConfirmationSplashPage({super.key});

  @override
  State<ConfirmationSplashPage> createState() => _ConfirmationSplashPageState();
}

class _ConfirmationSplashPageState extends State<ConfirmationSplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
      backgroundColor: const Color(0xFF3E1F99),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle,
                  size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Thank you!',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'A doctor will reach you shortly.\nPlease keep your phone nearby.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
