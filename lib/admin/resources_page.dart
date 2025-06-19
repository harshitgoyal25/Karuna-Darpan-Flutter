import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E1F99),
      appBar: AppBar(
         title: const Text('Recources',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white,),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.menu, color: Colors.white),
              ),
              Text('C H C Name',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Padding(
                padding: EdgeInsets.all(16),
                child: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png')),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Resources'),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Training Materials',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _resourceTile('Volunteer Training Guide'),
                  _resourceTile('Symptom Management Handbook'),
                  _resourceTile('Home Care Essentials'),
                  const SizedBox(height: 20),
                  const Text('Other Links',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _resourceTile('WHO Palliative Care Resources'),
                  _resourceTile('Government Schemes'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resourceTile(String title) => Card(
        child: ListTile(
          title: Text(title),
          trailing: const Icon(Icons.open_in_new),
          onTap: () {},
        ),
      );
}
