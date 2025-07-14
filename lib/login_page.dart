import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  String? selectedRole = 'Patient';
  final List<String> roles = ['Patient', 'Therapist', 'Assistant'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A3BFF),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("Email", emailController, false),
                  const SizedBox(height: 16),
                  _buildTextField("Password", passwordController, true),
                  const SizedBox(height: 16),
                  _buildRoleDropdown(),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forget-password'),
                      child: const Text("Forgot password?",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E1F99),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text("Login",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                  _buildRegisterButtons(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, '/admin-login-page'),
              icon: const Icon(Icons.admin_panel_settings, size: 16),
              label: const Text("Admin", style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, bool obscure) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType:
            hint == "Email" ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          dropdownColor: Colors.white,
          onChanged: (String? newValue) {
            setState(() {
              selectedRole = newValue!;
            });
          },
          items: roles.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRegisterButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/create-account'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            "New Patient Registration",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String endpoint = '';
    String redirectRoute = '';
    String userKey = '';

    switch (selectedRole) {
      case 'Patient':
        endpoint = 'https://karuna-backend.onrender.com/api/patients/login';
        redirectRoute = '/patient-dashboard';
        userKey = 'patient';
        break;
      case 'Therapist':
        endpoint = 'https://karuna-backend.onrender.com/api/therapists/login';
        redirectRoute = '/assistant';
        userKey = 'therapist';
        break;
      case 'Assistant':
        endpoint = 'https://karuna-backend.onrender.com/api/assistants/login';
        redirectRoute = '/assistant';
        userKey = 'assistant';
        break;
    }

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);
      print("Login Response: $data");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = data[userKey] ?? {};
        final userId = user['_id'] ?? user['id']; // fallback if _id is missing

        print(" User object: $user");
        print(" Extracted user ID: $userId");

        if (userId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login succeeded but user ID is missing'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

// Continue to dashboard
        Navigator.pushNamed(
          context,
          redirectRoute,
          arguments: {'id': userId, 'name': user['name'] ?? 'User'},
        );

        Navigator.pushNamed(
  context,
  redirectRoute,
  arguments: {
    'id': user['_id'], // for dashboard
    'name': user['name'] ?? 'User',
    'patientId': user['_id'], // for health history navigation
  },
);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Login failed: ${data['message'] ?? 'Invalid credentials'}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Network error. Please check your connection.'),
            backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
