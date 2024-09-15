import 'package:flutter/material.dart';

class BasuraGame extends StatefulWidget {
  @override
  _BasuraGameState createState() => _BasuraGameState();
}

class _BasuraGameState extends State<BasuraGame> {
  final List<String> _basura = [
    'botella de vidrio',
    'frasco de vidrio',
    'lata de refresco',
    'lata de comida',
    'botella de plástico',
    'bolsa de plástico',
    'periódico',
    'revista',
    'cáscara de plátano',
    'restos de comida'
  ];

  final Map<String, bool> _correctlyDropped = {
    'vidrio': false,
    'plástico': false,
    'lata': false,
    'papel': false,
    'orgánico': false,
  };

  String _message = '';

  final Map<String, String> _basuraCategorias = {
    'botella de vidrio': 'vidrio',
    'frasco de vidrio': 'vidrio',
    'lata de refresco': 'lata',
    'lata de comida': 'lata',
    'botella de plástico': 'plástico',
    'bolsa de plástico': 'plástico',
    'periódico': 'papel',
    'revista': 'papel',
    'cáscara de plátano': 'orgánico',
    'restos de comida': 'orgánico',
  };

  void _onDragCompleted(String type) {
    setState(() {
      _correctlyDropped[_basuraCategorias[type]!] = true;
      _basura.remove(type);
      if (_correctlyDropped.values.every((dropped) => dropped) && _basura.isEmpty) {
        _message = '¡Felicidades! Has clasificado toda la basura correctamente.';
      }
    });
  }

  void _onDragFailed() {
    setState(() {
      _message = 'Te equivocaste, intenta de nuevo.';
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
          // Títulos de categorías y cuadros
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDragTarget('vidrio', 'Vidrio', Colors.green),
              _buildDragTarget('plástico', 'Plásticos', Colors.yellow),
              _buildDragTarget('lata', 'Latas y Metales', Colors.grey),
              _buildDragTarget('papel', 'Papel', Colors.blue),
              _buildDragTarget('orgánico', 'Orgánicos', Colors.white),
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
                feedback: _buildTrashItem(type, opacity: 0.7),
                childWhenDragging: Opacity(
                  opacity: 0.5,
                  child: _buildTrashItem(type),
                ),
                onDragCompleted: () => _onDragCompleted(type),
                onDraggableCanceled: (velocity, offset) => _onDragFailed(),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Mensaje de éxito o error
          Text(
            _message.isNotEmpty ? _message : 'Arrastra la basura a las categorías correspondientes.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildTrashItem(String type, {double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          type,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildDragTarget(String type, String category, Color color) {
    return Column(
      children: [
        DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            bool isCorrect = _correctlyDropped[type] ?? false;
            return Container(
              width: 70,
              height: 70,
              color: isCorrect ? Colors.green : color.withOpacity(0.5),
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
            if (_basuraCategorias[receivedItem] == type) {
              _onDragCompleted(receivedItem);
            } else {
              _onDragFailed();
            }
          },
        ),
        SizedBox(height: 5),
        Text(
          category,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
