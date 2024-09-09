import 'dart:async';
import 'package:flutter/material.dart';

class PotGamePage extends StatefulWidget {
  @override
  _PotGamePageState createState() => _PotGamePageState();
}

class _PotGamePageState extends State<PotGamePage> {
  final List<Flower> _flowers = [];
  Timer? _growthTimer;
  int _maxFlowers = 3; // Máximo de tres flores simultáneas
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _startGrowthTimer();
  }

  // Inicia el temporizador para que las flores crezcan cada 1 minuto
  void _startGrowthTimer() {
    _growthTimer = Timer.periodic(Duration(seconds: 60), (timer) {
      setState(() {
        for (var flower in _flowers) {
          flower.grow();
        }
      });
    });
  }

  @override
  void dispose() {
    _growthTimer?.cancel();
    super.dispose();
  }

  // Crear la maceta cuadrada roja y dibujar la flor en su etapa
  Widget _buildPot(Flower flower) {
    return Positioned(
      left: flower.position.dx - 25, // Centrar la maceta
      top: flower.position.dy,
      child: Column(
        children: [
          // Flor sobre la maceta
          _buildFlower(flower),
          // Maceta cuadrada roja
          Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  // Dibuja la flor con el cuerpo verde, centro amarillo y pétalos blancos
  Widget _buildFlower(Flower flower) {
    if (flower.growthStage == 0) {
      return Container(); // No hay flor al principio
    } else if (flower.growthStage == 1) {
      // Cuerpo verde de la flor
      return Container(
        width: 10,
        height: 30,
        color: Colors.green,
      );
    } else if (flower.growthStage == 2) {
      // Cuerpo verde con centro amarillo
      return Column(
        children: [
          Container(width: 10, height: 30, color: Colors.green),
          Container(width: 20, height: 20, color: Colors.yellow),
        ],
      );
    } else {
      // Cuerpo verde, centro amarillo y pétalos blancos
      return Column(
        children: [
          Container(width: 10, height: 30, color: Colors.green),
          Container(width: 20, height: 20, color: Colors.yellow),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      );
    }
  }

  // Agregar los iconos para regar, abonar, y usar la pala
  Widget _buildActionButtons(Flower flower) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.water_drop),
          onPressed: () => _waterFlower(flower),
        ),
        IconButton(
          icon: Icon(Icons.local_florist),
          onPressed: () => _applyFertilizer(flower),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeFlower(flower),
        ),
      ],
    );
  }

  // Función para agregar una flor
  void _addFlower(Offset position) {
    if (_flowers.length < _maxFlowers) {
      setState(() {
        _flowers.add(Flower(position: position));
      });
    }
  }

  // Función para regar una flor (añadir tiempo de vida)
  void _waterFlower(Flower flower) {
    setState(() {
      flower.addLife(30); // Añadir 30 segundos de vida
    });
  }

  // Función para aplicar fertilizante (crecimiento instantáneo)
  void _applyFertilizer(Flower flower) {
    setState(() {
      flower.grow();
    });
  }

  // Función para remover una flor y maceta
  void _removeFlower(Flower flower) {
    setState(() {
      _flowers.remove(flower);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardín Zen Mejorado'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: [
          // Fondo verde para la pantalla
          Container(color: Colors.green[100]),
          // Mostrar las flores y macetas
          for (var flower in _flowers)
            ...[
              _buildPot(flower),
              Positioned(
                left: flower.position.dx - 25,
                top: flower.position.dy + 60,
                child: _buildActionButtons(flower),
              ),
            ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addFlower(Offset(150, 300)), // Añadir flor en una posición
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Clase para manejar las flores
class Flower {
  final Offset position;
  int growthStage = 0; // Etapas: 0 - sin flor, 1 - cuerpo verde, 2 - centro amarillo, 3 - pétalos
  int lifeTime = 180; // Tiempo de vida de la flor en segundos

  Flower({required this.position});

  // Función para hacer crecer la flor
  void grow() {
    if (growthStage < 3) {
      growthStage++;
    }
  }

  // Añadir tiempo de vida a la flor
  void addLife(int seconds) {
    lifeTime += seconds;
  }
}
