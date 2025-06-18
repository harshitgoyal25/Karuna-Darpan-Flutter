import 'package:flutter/material.dart';

class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      {'name': 'Aarjoo Dahiya', 'time': '9:00 AM'},
      {'name': 'Aanchal Gupta', 'time': '11:00 AM'},
      {'name': 'Jot Ajmani', 'time': '12:30 PM'},
      {'name': 'Harish Gupta', 'time': '2:00 PM'},
      {'name':'Harshit Goyal','time':'5:30 PM'}
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: ListView(
        children: patients.map((p) => ListTile(
          tileColor: Colors.grey.shade200,
          title: Text(p['name']!),
          subtitle: Text(p['time']!, style: TextStyle(color: Colors.grey)),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.pushNamed(context, '/patient-profile'),
        )).toList(),
      ),
    );
  }
}