import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminForgetPasswordPage extends StatefulWidget {
  const AdminForgetPasswordPage({super.key});

  @override
  State<AdminForgetPasswordPage> createState() =>
      _AdminForgetPasswordPageState();
}

class _AdminForgetPasswordPageState extends State<AdminForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool isLoading = false;
  String? message;

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
      message = null;
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/admins/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailController.text.trim(),
        'newPassword': newPasswordController.text.trim(),
      }),
    );

    setState(() {
      isLoading = false;
      if (response.statusCode == 200) {
        message = "Password reset successful. You can now login.";
      } else {
        message = json.decode(response.body)['message'] ??
            'Failed to reset password.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3BFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E1F99),
        elevation: 0,
        title: const Text('Forgot Password',
            style: TextStyle(color: Colors.white)),
        leading: const BackButton(color: Colors.white),
      ),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_reset, color: Colors.white, size: 50),
              const SizedBox(height: 20),
              const Text(
                'Reset Admin Password',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField("Email/user", emailController, false),
              const SizedBox(height: 16),
              _buildTextField("New Password", newPasswordController, true),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Reset",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 20),
              if (message != null)
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, bool obscure) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
