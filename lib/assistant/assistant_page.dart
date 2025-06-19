import 'package:flutter/material.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 92, 52, 213),
        title: const Text("Karuna Saathi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            _buildButton(context, '🧑‍⚕️ Patients', '/patients'),
            _buildButton(context, '✅ Today’s Tasks', '/tasks'),
            _buildButton(context, '📞 Call', '/calls'),
            _buildButton(context, '🧠 Learning', '/learning'),
            _buildButton(context, '📈 My Performance', '/performance'),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: Colors.grey.shade200,
          foregroundColor: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
