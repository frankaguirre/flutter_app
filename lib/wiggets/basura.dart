import 'package:flutter/material.dart';

class BasuraGame extends StatefulWidget {
  @override
  _BasuraGameState createState() => _BasuraGameState();
}

class _BasuraGameState extends State<BasuraGame> {
  final List<String> _basura = ['lata', 'tela', 'plástico', 'madera', 'metal'];
  final Map<String, bool> _correctlyDropped = {
    'lata': false,
    'tela': false,
    'plástico': false,
    'madera': false,
    'metal': false,
  };

  void _onDragCompleted(String type) {
    setState(() {
      _correctlyDropped[type] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini-Juego de Basura'),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Títulos de categorías
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDragTarget('lata', 'Reciclaje'),
              _buildDragTarget('tela', 'Textiles'),
              _buildDragTarget('plástico', 'Plásticos'),
              _buildDragTarget('madera', 'Madera'),
              _buildDragTarget('metal', 'Metales'),
            ],
          ),
          SizedBox(height: 15),
          // Tipos de basura para arrastrar
          Wrap(
            spacing: 20,
            children: _basura.map((type) {
              return Draggable<String>(
                data: type,
                child: _buildTrashItem(type),
                feedback: _buildTrashItem(type),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: _buildTrashItem(type),
                ),
                onDragCompleted: () => _onDragCompleted(type),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Mensaje de fin de juego
          Text(
            _correctlyDropped.values.every((dropped) => dropped)
                ? '¡Felicidades! Has clasificado toda la basura correctamente.'
                : 'Arrastra la basura a las categorías correspondientes.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTrashItem(String type) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildDragTarget(String type, String category) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        bool isCorrect = _correctlyDropped[type] ?? false;
        return Container(
          width: 70,
          height: 70,
          color: isCorrect ? Colors.green : Colors.grey[200],
          child: Center(
            child: Text(
              category,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      onAccept: (receivedItem) {
        if (receivedItem == type) {
          _onDragCompleted(receivedItem);
        }
      },
    );
  }
}
