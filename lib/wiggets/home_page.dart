import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> accionesAmbientales = [];

  void _navigateToPage(String pageName) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PlaceholderPage(pageName: pageName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text(
          'Conciencia Ambiental',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Información Inicial',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Aquí va la información relevante sobre la aplicación o el tema ambiental.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset('', width: 150, height: 150),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Más información sobre el tema.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 4,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _navigateToPage('Página ${index + 1}'),
                child: Container(
                  color: Colors.green[200],
                  child: Center(
                    child: Text(
                      'Botón ${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Center(
            child: Image.asset('', width: 100, height: 100),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Objetivo de la aplicación: fomentar la conciencia ambiental a través de acciones diarias.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue),
              SizedBox(width: 20),
              FaIcon(FontAwesomeIcons.twitter, size: 30, color: Colors.blue),
              SizedBox(width: 20),
              FaIcon(FontAwesomeIcons.instagram, size: 30, color: Colors.purple),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {
          // Acción del botón flotante si es necesario
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String pageName;

  PlaceholderPage({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Center(
        child: Text('Contenido para $pageName'),
      ),
    );
  }
}
