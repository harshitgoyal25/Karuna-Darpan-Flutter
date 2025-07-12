// lib/patient/add_health_record_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddHealthRecordPage extends StatefulWidget {
  final String patientId;

  const AddHealthRecordPage({super.key, required this.patientId});

  @override
  State<AddHealthRecordPage> createState() => _AddHealthRecordPageState();
}

class _AddHealthRecordPageState extends State<AddHealthRecordPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _error;

  Future<void> _submitRecord() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final response = await http.put(
      Uri.parse('http://10.0.2.2:5000/api/patients/update/${widget.patientId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        r'$push': {
          'healthRecords': {
            'description': _controller.text,
            'createdAt': DateTime.now().toIso8601String()
          }
        }
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true); // return true to indicate record was added
    } else {
      setState(() => _error = 'Failed to add record');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Health Record')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter health update',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitRecord,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
