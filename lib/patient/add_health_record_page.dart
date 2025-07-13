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
  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _healthRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchHealthRecords();
  }

  Future<void> _fetchHealthRecords() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://karuna-backend.onrender.com/api/patients/${widget.patientId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _healthRecords = List<Map<String, dynamic>>.from(
            (data['healthRecords'] ?? []).reversed,
          );
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load health records.';
        _isLoading = false;
      });
    }
  }

  Future<void> _submitRecord() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final newRecord = {
      'description': text,
      'createdAt': DateTime.now().toIso8601String(),
    };

    final response = await http.put(
      Uri.parse(
          'https://karuna-backend.onrender.com/api/patients/update/${widget.patientId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        r'$push': {'healthRecords': newRecord}
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _healthRecords.insert(0, newRecord);
        _controller.clear();
      });
    } else {
      setState(() => _error = 'Failed to add record');
    }

    setState(() => _isLoading = false);
  }

  Widget _buildHealthRecord(Map<String, dynamic> record) {
    final date = DateTime.tryParse(record['createdAt'] ?? '')?.toLocal();
    final formattedDate = date != null
        ? '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}'
        : 'Unknown date';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        title: Text(record['description']),
        subtitle: Text(formattedDate),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health History')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _controller,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Enter health update',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _submitRecord,
                    child: const Text('Submit'),
                  ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(_error!,
                          style: const TextStyle(color: Colors.red)),
                    ),
                  const Divider(height: 32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Health History:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _healthRecords.isEmpty
                        ? const Text('No health records yet.')
                        : ListView.builder(
                            itemCount: _healthRecords.length,
                            itemBuilder: (context, index) =>
                                _buildHealthRecord(_healthRecords[index]),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
