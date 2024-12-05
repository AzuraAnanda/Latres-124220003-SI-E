import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final String menu;
  final int id;

  DetailScreen({required this.menu, required this.id});

  // Fungsi untuk mengambil detail data dari API
  Future<Map<String, dynamic>> fetchDetail() async {
    final response = await http.get(Uri.parse('https://api.spaceflightnewsapi.net/v4/$menu/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load detail');
    }
  }

  // Fungsi untuk membuka URL di browser
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchDetail(), // Mengambil data detail
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final detail = snapshot.data!;  // Mendapatkan data detail
            final imageUrl = detail['imageUrl']; // Mengambil URL gambar dari API

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menampilkan gambar jika ada
                    if (imageUrl != null)
                      Image.network(
                        imageUrl,  // URL gambar dari API
                        fit: BoxFit.cover,
                        width: double.infinity,  // Menyesuaikan lebar layar
                        height: 250,  // Menentukan tinggi gambar
                      ),
                    SizedBox(height: 16),
                    // Menampilkan judul artikel
                    Text(
                      detail['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Menampilkan kategori
                    Text(
                      'Category: ${menu.toUpperCase()}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Menampilkan ringkasan artikel
                    Text(
                      detail['summary'] ?? 'No summary available',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    // Tombol untuk membaca lebih lanjut
                    ElevatedButton(
                      onPressed: () {
                        if (detail.containsKey('url') && detail['url'] != null) {
                          _launchURL(detail['url']);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('URL not available')),
                          );
                        }
                      },
                      child: Text('Read More'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
