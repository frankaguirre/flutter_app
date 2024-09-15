import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aportes.dart';


class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
        title: Text('Página 4 - Motivacion'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/image/movitar.png', width: 500, height: 250),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "La Tierra no es una herencia de nuestros padres, es un préstamo de nuestros hijos."

"Cada pequeño acto cuenta. Plantar un árbol hoy es asegurar un futuro más verde mañana."

"Cuidar del planeta es cuidar de nuestro hogar, el único que tenemos."

"El cambio climático es real, pero también lo es nuestra capacidad para detenerlo."

"La naturaleza no nos necesita, nosotros necesitamos a la naturaleza. Protejámosla."

"Reducir, reutilizar y reciclar no son solo acciones, son formas de cambiar el mundo."

"Las grandes transformaciones comienzan con pequeños pasos. ¡Haz tu parte por el planeta!"

"Tu huella en la Tierra puede ser pequeña, pero el impacto de tus acciones puede ser enorme."

"El mejor momento para plantar un árbol fue hace 20 años. El segundo mejor momento es ahora."

"Cada vez que reciclas, reduces la cantidad de residuos que el planeta tiene que soportar."
              ,
              style: TextStyle(fontSize: 12),
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
        ],
      ),
    );
  }
}

