import 'package:flutter/material.dart';

class DatosAmbientalesPage extends StatelessWidget {
  final String accionAmbiental;

  DatosAmbientalesPage({required this.accionAmbiental});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Acción Ambiental',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700], // Verde para mantener la coherencia
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles sobre la acción:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 20),
            Text(
              accionAmbiental,
              style: TextStyle(
                fontSize: 18,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Esta acción es crucial para proteger el medio ambiente y promover la sostenibilidad en nuestro planeta.',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
