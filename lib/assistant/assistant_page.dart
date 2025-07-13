import 'package:flutter/material.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF3E1F99),
        title: const Text(
          "Karuna Saathi",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          _buildButton(context, '🧑‍⚕️ Patients', '/patients'),
          _buildButton(context, '✅ Today’s Visit', '/visit'),
          _buildButton(context, '📞 Call', '/calls'),
          _buildButton(context, '🧠 Learning', '/learning'),
          _buildButton(context, '📈 My Performance', '/performance'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
