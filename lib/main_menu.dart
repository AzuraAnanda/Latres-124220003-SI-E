import 'package:flutter/material.dart';
import 'package:flutter_application_1/data_list.dart';

class MainMenu extends StatelessWidget {
  final String username;

  MainMenu({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hai, $username!'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'News',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildMenuItem(
              context,
              title: 'Get an overview of the latest spaceflight news, from various sources. Easily link your users to the right websites.',
              icon: Icons.newspaper,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataListScreen(menu: 'articles'),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Text(
              'Blog',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildMenuItem(
              context,
              title: 'Blogs often provide a more detailed overview of launches and missions. A must-have for the serious spaceflight enthusiast.',
              icon: Icons.article,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataListScreen(menu: 'blogs'),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Text(
              'Report',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildMenuItem(
              context,
              title : 'Reports provide in-depth analysis and insights into space missions and events. Perfect for those who want to dive deeper into the subject.',
              icon: Icons.assignment,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataListScreen(menu: 'reports'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
} 