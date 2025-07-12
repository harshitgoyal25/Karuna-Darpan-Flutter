import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallForHelpPage extends StatelessWidget {
  const CallForHelpPage({super.key});

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      final canLaunch = await canLaunchUrl(launchUri);
      if (!canLaunch) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Device cannot place calls.')),
        );
        return;
      }

      final launched = await launchUrl(
        launchUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to launch dialer.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = {
      'K SAATHI': '+911234567890',
      'AMBULANCE': '109',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Call For Help', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: options.entries.map((entry) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              title: Text(entry.key, style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.phone),
              onTap: () => _makePhoneCall(context, entry.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
