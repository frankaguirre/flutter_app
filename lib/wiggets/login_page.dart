import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/carga_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _iniciarSesion() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => CargaPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Fondo verde claro
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5), // Sombra verde
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Inicia tu viaje verde',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 20),
              // Reemplaza los campos de entrada con una imagen
              Container(
                width: 150,
                height: 150,
                child: Image.asset('assets/image/descarga.png', fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _iniciarSesion,
                child: Text('Comenzar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700], // Botón verde
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
