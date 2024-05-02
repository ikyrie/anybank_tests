import 'package:flutter/material.dart';
import 'package:flutter_tdd/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AnyBank());
}

class AnyBank extends StatelessWidget {
  const AnyBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AnyBank",
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6BD1FF),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const Dashboard(),
    );
  }
}
