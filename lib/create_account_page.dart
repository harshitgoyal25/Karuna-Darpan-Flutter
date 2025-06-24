import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedGender = 'Male';

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
            const Text(
              'Basic Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildTextField('Full Name', nameController,
                hint: 'e.g., Ramesh Sharma'),
            _buildDropdown(),
            _buildTextField('Age', ageController,
                keyboardType: TextInputType.number, hint: 'e.g., 25'),
            _buildTextField('Phone Number', phoneController,
                keyboardType: TextInputType.phone, hint: '10-digit number'),
            _buildTextField('Aadhar Number', aadharController,
                keyboardType: TextInputType.number, hint: '12-digit number'),
            const SizedBox(height: 20),
            const Text(
              'Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildTextField('Village', villageController),
            _buildTextField('District', districtController),
            _buildTextField('State', stateController),
            const SizedBox(height: 20),
            const Text(
              'Create Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildTextField('Password', passwordController,
                obscureText: true, hint: 'Choose a strong password'),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/patient-health-info');
              },
              child:
                  const Text('Proceed', style: TextStyle(color: Colors.white)),
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
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedGender = value);
          }
        },
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
}
