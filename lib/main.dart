
import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/login_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conciencia ambiental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color.fromARGB(255, 146, 131, 131),
      ),
      home: LoginPage(),
    );
  }
}
