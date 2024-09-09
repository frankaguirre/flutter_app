import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/reforestacion.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Introducción al Jardín Zen'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido al Jardín Zen!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Instrucciones del juego:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '''- Tienes un jardín con tres macetas.
- Cada maceta puede contener una flor que crece automáticamente en 1 minuto.
- Usa las herramientas para cuidar las flores:
  • Riega la flor para agregar 30 segundos a su vida útil (cada riego tarda 2 minutos en reutilizarse).
  • Aplica abono para hacer crecer un píxel adicional (se puede usar solo una vez por flor).
  • Usa la pala para remover una maceta y la flor por completo.
- Las flores tienen una vida útil de 3 minutos. Después, desaparecen.
- Gana puntos mientras cuidas tus flores y haz que florezcan por completo.

¡Buena suerte y disfruta del Jardín Zen!''',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PotGamePage()),
                );
              },
              child: Text('Comenzar Juego'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
