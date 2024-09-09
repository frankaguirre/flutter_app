import 'package:flutter/material.dart';
import 'package:flutter_application_10/wiggets/intro.dart';
import 'package:provider/provider.dart';
import 'aportes.dart';
import 'basura.dart'; // Importa el widget BasuraGame

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final _ideasController = TextEditingController();
  final List<String> _ideas = [];

  void _addIdea() {
    if (_ideas.length < 5) {
      setState(() {
        _ideas.add(_ideasController.text);
        _ideasController.clear();
      });
      Provider.of<AportesProvider>(context, listen: false).incrementAportes();
    } else {
      // Muestra un mensaje de error si se alcanzó el límite
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Has alcanzado el límite de 5 ideas!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página 1 - Recolecion'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/image/derr.png', width: 300, height: 150),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "La recolección adecuada de residuos es fundamental para preservar nuestro medio ambiente y reducir la contaminación. Con tu participación activa, podemos mejorar la gestión y clasificación de desechos, fomentando la reutilización y el reciclaje"

"Aquí te presentamos algunas ideas para optimizar la recolección de residuos:"

"Implementa sistemas de separación de residuos en tu comunidad: Facilita la clasificación de materiales reciclables y no reciclables"
"Promueve campañas educativas: Informa a los ciudadanos sobre la importancia de la separación de residuos y la correcta disposición de cada tipo de material"
"Instala puntos de recolección en lugares clave: Ubica contenedores en áreas accesibles para facilitar la entrega de residuos reciclables"
"Organiza eventos de limpieza comunitaria: Incentiva la participación de la comunidad en la recolección de desechos en espacios públicos"
              ,
              style: TextStyle(fontSize: 13),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _ideasController,
              decoration: InputDecoration(labelText: 'Agrega tus ideas'),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addIdea,
            child: Text('Aportar'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InstructionsPage ()),
              );
            },
            child: Text('Jugar al mini-juego'),
          ),
        ],
      ),
    );
  }
}

