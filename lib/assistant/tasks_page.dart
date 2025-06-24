import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<Map<String, String>> patients = [
    {'name': 'Aarjoo Dahiya', 'age': '21'},
    {'name': 'Aanchal Gupta', 'age': '21'},
    {'name': 'Jot Ajmani', 'age': '21'},
    {'name': 'Harish Gupta', 'age': '21'},
    {'name': 'Harshit Goyal', 'age': '21'},
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  void _addNewPatient() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add New Patient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  final age = ageController.text.trim();
                  if (name.isNotEmpty && age.isNotEmpty) {
                    setState(() {
                      patients.add({'name': name, 'age': age});
                    });
                    nameController.clear();
                    ageController.clear();
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Add Patient'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Today’s Visits',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              title: Text(
                patient['name']!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Text("Age: ${patient['age']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // You can navigate to a patient detail page here
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPatient,
        backgroundColor: const Color(0xFF3E1F99),
        child: const Icon(Icons.add),
        tooltip: 'Add Patient',
      ),
    );
  }
}
