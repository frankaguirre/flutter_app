import 'package:flutter/material.dart';
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
        title: Text('Página 2 - Reciclaje'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/image/page2_image.png', width: 500, height: 250),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Reciclaje: El reciclaje es el proceso de transformar materiales usados en nuevos productos, reduciendo así la necesidad de recursos naturales y minimizando los residuos. Al reciclar, ayudamos a conservar el medio ambiente, disminuimos la contaminación y promovemos la sostenibilidad.\n\n"
              "¡Dame tus ideas! ¿Tienes ideas sobre cómo mejorar el reciclaje en tu comunidad o en tu vida diaria? Compártelas con nosotros y juntos hagamos una diferencia.",
              style: TextStyle(fontSize: 16),
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
                MaterialPageRoute(builder: (context) => BasuraGame()),
              );
            },
            child: Text('Jugar al mini-juego'),
          ),
        ],
      ),
    );
  }
}

