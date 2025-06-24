import 'package:flutter/material.dart';

class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      {'name': 'Aarjoo Dahiya', 'age': '21'},
      {'name': 'Aanchal Gupta', 'age': '21'},
      {'name': 'Jot Ajmani', 'age': '21'},
      {'name': 'Harish Gupta', 'age': '21'},
      {'name': 'Harshit Goyal', 'age': '21'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            const Text('Patient List', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final p = patients[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Text(
                p['name']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                p['age']!,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 18),
              onTap: () => Navigator.pushNamed(context, '/patient-profile'),
            ),
          );
        },
      ),
    );
  }
}
