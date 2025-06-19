import 'package:flutter/material.dart';

class AdminDashboardMainPage extends StatelessWidget {
  const AdminDashboardMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
         title: const Text('Admin Dashboard',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white,),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _boxTile('Select Date Range', Icons.chevron_right, () {}),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _StatCard(value: '154', label: 'Active Patients'),
              _StatCard(value: '23', label: 'Missed Visits'),
              _StatCard(value: '74', label: 'Volunteer Score'),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
  onTap: () => Navigator.pushNamed(context, '/high-risk'),
  child: _alertBox(Icons.cancel, '4 High-Risk Patient today', Colors.orange),
),
GestureDetector(
  onTap: () => Navigator.pushNamed(context, '/morphine-stock'),
  child: _alertBox(Icons.warning_amber, 'Morphine stock low', Colors.amber),
),

          const SizedBox(height: 16),
          _buttonRow(context, [
            ['View Visit Trends', Icons.trending_up, '/visit-trends'],
            ['Team Heatmap', Icons.grid_view, '/team-heatmap'],
          ]),
          const SizedBox(height: 12),
          _buttonRow(context, [
            ['Resources', Icons.medical_services, '/resources'],
            ['Referrals', Icons.send, '/referrals'],
          ]),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.open_in_new, color: Colors.white),
            label: const Text('Export Report', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxTile(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            Icon(icon),
          ],
        ),
      ),
    );
  }

  Widget _alertBox(IconData icon, String message, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }

  Widget _buttonRow(BuildContext context, List<List<dynamic>> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((b) => _navButton(context, b[0], b[1], b[2])).toList(),
    );
  }

  Widget _navButton(BuildContext context, String label, IconData icon, String route) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(label, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
