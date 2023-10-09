import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map<String, dynamic>> news;

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&apiKey=a481486cec3745ddae53821bb5132799"));
    return response.statusCode != 200
        ? <String, dynamic>{}
        : jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    news = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: news,
        builder: (content, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return const Center(child: Text("Something"));
        },
      ),
    );
  }
}
