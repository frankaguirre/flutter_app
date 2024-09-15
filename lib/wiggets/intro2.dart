import 'package:Sena_conciencia_ambiental/wiggets/reforestacion.dart';
import 'package:flutter/material.dart';


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
- Cada maceta puede contener una flor que crece automáticamente cada 30 segundos.
- Usa las herramientas para cuidar las flores:
  • Riega la flor para agregar 30 segundos a su vida útil (cada riego tarda 2 minutos en reutilizarse).
  • Aplica abono para hacer crecer adicional (se puede usar solo una vez por flor).
  • Usa la pala para remover una maceta y la flor por completo.
- Las flores tienen una vida útil. Después, desaparecen.
- cuidas tus flores y haz que florezcan por completo.

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
