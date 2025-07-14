import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController abhaController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Added health info controllers
  final TextEditingController medicalHistoryController =
      TextEditingController();
  final TextEditingController currentProblemsController =
      TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();

  String selectedGender = 'Male';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text('Create Account', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Basic Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTextField('Full Name', nameController,
                hint: 'e.g., Ramesh Sharma'),
            _buildTextField('Email', emailController,
                keyboardType: TextInputType.emailAddress,
                hint: 'e.g., ramesh@gmail.com'),
            _buildDropdown(),
            _buildTextField('Age', ageController,
                keyboardType: TextInputType.number, hint: 'e.g., 25'),
            _buildTextField('Phone Number', phoneController,
                keyboardType: TextInputType.phone, hint: '10-digit number'),
            _buildTextField('Aadhar Number', aadharController,
                keyboardType: TextInputType.number, hint: '12-digit number'),
            _buildTextField('ABHA ID', abhaController,
                keyboardType: TextInputType.number, hint: '14-digit ABHA ID'),
            const SizedBox(height: 20),
            const Text('Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTextField('Village', villageController),
            _buildTextField('District', districtController),
            _buildTextField('State', stateController),
            const SizedBox(height: 20),
            const Text('Create Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTextField('Password', passwordController,
                obscureText: true, hint: 'Choose a strong password'),
            const SizedBox(height: 20),
            const Text('Medical Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildMultiLineField('Medical History', medicalHistoryController,
                'Any previous surgeries, chronic conditions, family history, etc.'),
            _buildMultiLineField(
                'Current Health Problems',
                currentProblemsController,
                'Describe your current symptoms or health concerns'),
            _buildMultiLineField('Allergies', allergiesController,
                'Food allergies, drug allergies, environmental allergies, etc.'),
            _buildMultiLineField('Current Medications', medicationsController,
                'List all medications you are currently taking'),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: isLoading ? null : _createAccount,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Create Account',
                      style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: ['Male', 'Female', 'Other'].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        onChanged: (value) => setState(() => selectedGender = value ?? 'Male'),
        decoration: InputDecoration(
          labelText: 'Gender',
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      bool obscureText = false,
      String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildMultiLineField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  void _createAccount() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        abhaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('https://karuna-backend.onrender.com/api/patients/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'age': int.tryParse(ageController.text.trim()) ?? 0,
          'gender': selectedGender,
          'phone': phoneController.text.trim(),
          'aadhar': aadharController.text.trim(),
          'abhaId': abhaController.text.trim(),
          'village': villageController.text.trim(),
          'district': districtController.text.trim(),
          'state': stateController.text.trim(),
          'medicalHistory': medicalHistoryController.text.trim(),
          'currentproblems': currentProblemsController.text.trim(),
          'allergies': allergiesController.text.trim(),
          'currentmedications': medicationsController.text.trim(),
        }),
      );

      print('📥 Status Code: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print("✅ Account created successfully: $data");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        final patient = data['patient'];
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/patient-dashboard',
          (route) => false,
          arguments: {
            'id': patient['_id'], // for dashboard
            'name': patient['name'], // for greeting
            'patientId':
                patient['_id'], // for health-history and medical routes
          },
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${data['message'] ?? 'Unknown error'}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("💥 Error during account creation: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please check your connection.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
}
