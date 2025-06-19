import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String gender = 'Male';
  String education = 'Graduate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('First Name', firstNameController),
            _buildTextField('Last Name', lastNameController),
            _buildTextField('Age', ageController,
                keyboardType: TextInputType.number),
            _buildTextField('Mobile Number', mobileController,
                keyboardType: TextInputType.phone),
            _buildTextField('Email id', emailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 10),
            const Text('Gender'),
            DropdownButton<String>(
              value: gender,
              isExpanded: true,
              items: ['Male', 'Female', 'Other']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => gender = value!),
            ),
            const SizedBox(height: 10),
            const Text('Education'),
            DropdownButton<String>(
              value: education,
              isExpanded: true,
              items: ['Graduate', 'Postgraduate', 'Diploma']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => education = value!),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () {
                  // You can save or process data here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Patient Registered')),
                  );
                },
                child: const Text('Register',
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
