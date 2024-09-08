import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_application_10/wiggets/aportes.dart';

class CargaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage1()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/reciclaje.gif', 
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Cargando...',
              style: TextStyle(fontSize: 16, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}

