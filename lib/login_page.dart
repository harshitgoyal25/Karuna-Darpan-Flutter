import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Patient';

  final List<String> roles = ['Patient', 'Assistant', 'Therapist'];

  // 🔄 API CALL FUNCTION
  Future<void> _fetchPatientsData() async {
    print("🌐 Starting API call...");

    try {
      final response = await http.get(
        Uri.parse('https://karuna-backend.onrender.com/api/patients/getAll'),
      );

      print("📥 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("✅ Data fetched successfully:");
        print(data);

        if (data is List) {
          for (var patient in data) {
            print("🧑 Patient: $patient");
          }
        }
      } else {
        print("❌ Failed to fetch data. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("💥 Error occurred: $e");
    }
  }

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
                    child: Icon(Icons.lock_open, color: Colors.white, size: 40),
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
                  _buildDropdown(),
                  const SizedBox(height: 16),
                  _buildTextField("Username", usernameController, false),
                  const SizedBox(height: 16),
                  _buildTextField("Password", passwordController, true),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forget-password'),
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E1F99),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/create-account'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Text(
                          "New Patient Registration",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/fetch-patients');
                        },
                        child: const Text(
                          "Go to Patient List",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      items: roles.map((role) {
        return DropdownMenuItem(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => selectedRole = value);
        }
      },
    );
  }

  void _handleLogin() async {
    print("🔐 Login process started...");
    print("Selected role: $selectedRole");
    print("Username: ${usernameController.text}");
    print("Password: ${passwordController.text}");

    print("📡 Sending credentials to server...");

    try {
      await Future.delayed(const Duration(seconds: 2));
      print("⏳ Waiting for server response...");

      final success = usernameController.text == 'test' &&
          passwordController.text == '1234';

      await Future.delayed(const Duration(seconds: 1));

      if (success) {
        print("✅ Login successful!");

        if (selectedRole == 'Therapist') {
          print("🔁 Redirecting to Therapist Dashboard...");
          Navigator.pushNamed(context, '/assistant');
        } else if (selectedRole == 'Patient') {
          print("🔁 Redirecting to Patient Dashboard...");
          Navigator.pushNamed(context, '/patient-dashboard');
        } else {
          print("❌ No route configured for role: $selectedRole");
        }
      } else {
        print("❌ Invalid credentials. Login failed.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed: Invalid credentials')),
        );
      }
    } catch (e) {
      print("💥 Error occurred during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred during login')),
      );
    }
  }
}
