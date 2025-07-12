import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthHistoryPage extends StatefulWidget {
  final String patientId;

  const HealthHistoryPage({super.key, required this.patientId});

  @override
  State<HealthHistoryPage> createState() => _HealthHistoryPageState();
}

class _HealthHistoryPageState extends State<HealthHistoryPage> {
  List<dynamic> records = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHealthRecords();
  }

  Future<void> fetchHealthRecords() async {
    final res = await http.get(Uri.parse('http://10.0.2.2:5000/api/patients/${widget.patientId}'));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List<dynamic> fetchedRecords = data['healthRecords'] ?? [];

      fetchedRecords.sort((a, b) => DateTime.parse(b['createdAt']).compareTo(DateTime.parse(a['createdAt'])));

      setState(() {
        records = fetchedRecords;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  void _goToAddRecord() async {
    final result = await Navigator.pushNamed(
      context,
      '/add-health-record',
      arguments: {'patientId': widget.patientId},
    );

    if (result == true) {
      fetchHealthRecords(); // refresh
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health History")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : records.isEmpty
              ? const Center(child: Text('No records found.'))
              : ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(record['description']),
                        subtitle: Text(
                          DateTime.parse(record['createdAt']).toLocal().toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddRecord,
        child: const Icon(Icons.add),
      ),
    );
  }
}
