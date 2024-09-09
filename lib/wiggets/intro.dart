import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/recolecion.dart';


class InstructionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instrucciones del Juego'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Instrucciones del Juego de la Culebra para fomentar la recolecion:\n\n'
              '1. Utiliza tactil debes mantenerlo para mover la culebra.\n'
              '2. Recolecta las bolitas rojas que aparecen en la pantalla.\n'
              '3. Evita chocar con las paredes y contigo mismo.\n'
              '4. Completa la meta de recolectar 100 bolitas rojas.\n'
              '5. Si chocas con una pared, tendrás dos intentos para reaparecer. Si se te acaban los intentos, deberás intentar nuevamente.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SnakeGamePage()),
              );
            },
            child: Text('¡Listo! Comenzar el Juego'),
          ),
        ],
      ),
    );
  }
}

