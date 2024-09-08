import 'package:flutter/material.dart';
import 'datos_ambientales_page.dart'; // Asegúrate de tener esta página implementada
import 'agregar_ambiental_page.dart'; // Asegúrate de tener esta página implementada

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> accionesAmbientales = [
    'Reducir la huella de carbono',
    'Conservación del agua',
    'Energías renovables',
    'Protección de la biodiversidad',
    'Reciclaje y gestión de residuos',
    'Reforestación y restauración ecológica',
  ];

  void _navigateToAddAccionAmbiental() {
    // Aquí podrías agregar la lógica para navegar a la página de agregar acciones
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AgregarAmbientalPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Color de fondo suave, relacionado con la naturaleza
      appBar: AppBar(
        title: Text(
          'Conciencia Ambiental',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700], // Verde oscuro para el AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white, // Icono blanco para contraste
            onPressed: _navigateToAddAccionAmbiental,
          ),
        ],
      ),
      body: accionesAmbientales.isNotEmpty
          ? ListView.builder(
              itemCount: accionesAmbientales.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(accionesAmbientales[index]),
                  leading: Icon(Icons.eco, color: Colors.green),
                );
              },
            )
          : Center(
              child: Text(
                'No se encontraron acciones',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: _navigateToAddAccionAmbiental,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
