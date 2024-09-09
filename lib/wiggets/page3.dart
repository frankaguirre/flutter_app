import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aportes.dart';


class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page2State extends State<Page3> {
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
            child: Image.asset('assets/image/arbol.png', width: 500, height: 250),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Reforestación: La reforestación es un esfuerzo fundamental para restaurar nuestros ecosistemas y combatir el cambio climático. Plantar árboles ayuda a mejorar la calidad del aire, conservar el agua y proporcionar hábitats para la fauna silvestre. Además, contribuye a la lucha contra la erosión del suelo y promueve la biodiversidad. Cada árbol plantado es un paso hacia un planeta más saludable"

"¡Dame tus ideas! ¿Cómo puedes contribuir a la reforestación en tu comunidad o en tu entorno? Comparte tus ideas y trabajemos juntos para restaurar nuestros bosques y proteger el medio ambiente",
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
                MaterialPageRoute(builder: (context) => ()),
              );
            },
            child: Text('Jugar al mini-juego'),
          ),
        ],
      ),
    );
  }
}

