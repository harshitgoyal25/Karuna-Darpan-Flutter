import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = [
      'General Medicine',
      'General Surgery',
      'Cardiology',
      'Neurology',
      'Orthopedics 🛠️',
      'Pediatrics',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Call',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              leading: const Icon(Icons.local_hospital_outlined,
                  color: Color(0xFF3E1F99)),
              title: Text(
                departments[index],
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              trailing: const Icon(Icons.call, color: Colors.grey),
              onTap: () {
                // TODO: Trigger call or view details
              },
            ),
          );
        },
      ),
    );
  }
}
