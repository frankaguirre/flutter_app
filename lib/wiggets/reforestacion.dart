import 'package:flutter/material.dart';
import 'dart:async';

class PotGamePage extends StatefulWidget {
  @override
  _PotGamePageState createState() => _PotGamePageState();
}

class _PotGamePageState extends State<PotGamePage> {
  final List<Flower> _flowers = [];
  int _score = 0;
  Timer? _growthTimer;
  static const double _pixelSize = 5.0; // Tamaño de píxel más pequeño para estilo más detallado
  static const double _potWidth = 50.0; // Ancho de la maceta
  static const double _potHeight = 30.0; // Altura de la maceta

  @override
  void initState() {
    super.initState();
    _startGrowthTimer();
  }

  // Inicia el temporizador que controla el crecimiento de las flores
  void _startGrowthTimer() {
    _growthTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        for (var flower in _flowers) {
          flower.grow();
          if (flower.growthStage == 3) {
            _score += 10;
          }
        }
      });
    });
  }

  // Añadir una nueva flor en la posición donde el usuario toque
  void _addFlower(Offset position) {
    setState(() {
      _flowers.add(Flower(position: position));
    });
  }

  // Aplicar fertilizante para acelerar el crecimiento
  void _applyFertilizer(Flower flower) {
    setState(() {
      flower.applyFertilizer();
    });
  }

  // Regar la flor para que dure más tiempo
  void _waterFlower(Flower flower) {
    setState(() {
      flower.water();
    });
  }

  // Replantar una flor (la remueve y vuelve a plantar en la misma posición)
  void _replant(Flower flower) {
    setState(() {
      _flowers.remove(flower);
      _addFlower(flower.position);
    });
  }

  @override
  void dispose() {
    _growthTimer?.cancel();
    super.dispose();
  }

  // Dibuja la maceta usando píxeles
  Widget _buildPot(Offset position) {
    return Positioned(
      left: position.dx - _potWidth / 2,
      top: position.dy,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pixel(Colors.brown[700]!, 6), // Maceta izquierda
              _pixel(Colors.brown[600]!, 6), // Maceta centro
              _pixel(Colors.brown[700]!, 6), // Maceta derecha
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pixel(Colors.brown[800]!, 18), // Base de la maceta
            ],
          ),
        ],
      ),
    );
  }

  // Dibuja las flores en estilo pixelado con más detalles
  Widget _buildFlower(Flower flower) {
    List<Widget> pixels = [];

    if (flower.growthStage == 0) {
      // Etapa 0: Semilla pequeña (1 píxel marrón oscuro)
      pixels = [
        _pixel(Colors.brown[800]!, 1),
      ];
    } else if (flower.growthStage == 1) {
      // Etapa 1: Brote (varios píxeles verdes)
      pixels = [
        _pixel(Colors.green[900]!, 1),
        _pixel(Colors.green[800]!, 1),
      ];
    } else if (flower.growthStage == 2) {
      // Etapa 2: Planta media (más píxeles verdes)
      pixels = [
        _pixel(Colors.green[900]!, 1),
        _pixel(Colors.green[800]!, 1),
        _pixel(Colors.green[700]!, 1),
      ];
    } else {
      // Etapa 3: Flor completa (píxeles verdes y amarillos)
      pixels = [
        _pixel(Colors.green[900]!, 1),
        _pixel(Colors.green[800]!, 1),
        _pixel(Colors.yellow[700]!, 2),
        _pixel(Colors.green[700]!, 1),
      ];
    }

    return Positioned(
      left: flower.position.dx - _pixelSize / 2,
      top: flower.position.dy - _pixelSize * 5,
      child: GestureDetector(
        onTap: () => _applyFertilizer(flower),
        onLongPress: () => _waterFlower(flower),
        onDoubleTap: () => _replant(flower),
        child: Column(
          children: pixels,
        ),
      ),
    );
  }

  // Crear un píxel cuadrado de color
  Widget _pixel(Color color, int sizeMultiplier) {
    return Container(
      width: _pixelSize * sizeMultiplier.toDouble(),
      height: _pixelSize,
      color: color,
    );
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
          // Fondo con cuadrícula para estilo pixelado
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 50, // Número de píxeles por fila
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) => Container(
              color: Colors.green[100],
              width: _pixelSize,
              height: _pixelSize,
            ),
            itemCount: 2500, // Total de píxeles para el fondo
          ),
          GestureDetector(
            onTapUp: (details) {
              _addFlower(details.localPosition);
            },
            child: Center(
              child: Text(
                'Toca para plantar una flor',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // Mostrar las flores y macetas en la pantalla
          ..._flowers.map((flower) => Stack(
            children: [
              _buildPot(flower.position), // Dibujar la maceta
              _buildFlower(flower), // Dibujar la flor
            ],
          )),
          // Mostrar el puntaje actual en la esquina superior derecha
          Positioned(
            top: 20,
            right: 20,
            child: Text(
              'Puntuación: $_score',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Clase para manejar las flores
class Flower {
  final Offset position; // Posición donde la flor está plantada
  int growthStage = 0; // Etapas de crecimiento: 0 - semilla, 1 - brote, 2 - flor completa
  bool isWatered = false;
  bool isFertilized = false;

  Flower({required this.position});

  // Lógica para el crecimiento de la flor
  void grow() {
    if (growthStage < 3) {
      growthStage++;
    }
  }

  // Aplicar fertilizante para acelerar el crecimiento
  void applyFertilizer() {
    if (growthStage < 3) {
      growthStage++;
    }
  }

  // Regar la flor para que dure más tiempo o crezca más rápido
  void water() {
    isWatered = true;
  }
}

