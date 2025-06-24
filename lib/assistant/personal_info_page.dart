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
  final TextEditingController abhaController = TextEditingController();

  String gender = 'Male';
  // String education = 'Graduate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Enter Full Name', firstNameController),
            // _buildTextField('Last Name', lastNameController),
            _buildTextField('Age', ageController,
                keyboardType: TextInputType.number),
            _buildTextField('Mobile Number', mobileController,
                keyboardType: TextInputType.phone),
            _buildTextField('Abha ID', abhaController),
            const SizedBox(height: 20),
            const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            _buildDropdown(
              value: gender,
              items: ['Male', 'Female', 'Other'],
              onChanged: (val) => setState(() => gender = val),
            ),
            const SizedBox(height: 20),
            // // const Text('Education',
            // //     style: TextStyle(fontWeight: FontWeight.bold)),
            // const SizedBox(height: 6),
            // _buildDropdown(
            //   value: education,
            //   items: ['Graduate', 'Postgraduate', 'Diploma'],
            //   onChanged: (val) => setState(() => education = val),
            // ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Patient Registered')),
                  );
                },
                child: const Text('Register',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) => onChanged(val!),
    );
  }
}
