import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "./../.env");
  runApp(const HolyQuranForum());
}

class HolyQuranForum extends StatelessWidget {
  const HolyQuranForum({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
      ),
      body: const Column(
        children: [],
      ),
    ));
  }
}
