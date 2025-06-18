import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today’s Task'),
        backgroundColor: const Color(0xFF3E1F99),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: [
          _buildTile('Visits to pateint'),
          _buildTile('Visits to Doctors'),
          _buildTile('Others'),
          _buildTile(''),
          _buildTile(''),
        ],
      ),
    );
  }

  Widget _buildTile(String title) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
      );
}
