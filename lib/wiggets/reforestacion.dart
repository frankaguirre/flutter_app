import 'package:flutter/material.dart';
import 'dart:async';

class PotGamePage extends StatefulWidget {
  @override
  _PotGamePageState createState() => _PotGamePageState();
}

class _PotGamePageState extends State<PotGamePage> {
  List<Flower> flowers = [];
  final int _maxFlowers = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardín Zen Mejorado'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        children: [
          Container(color: Colors.green[100]), // Fondo verde
          for (Flower flower in flowers)
            _buildPot(flower),
          if (flowers.length < _maxFlowers) _buildAddFlowerButton(),
        ],
      ),
    );
  }

  Widget _buildPot(Flower flower) {
    return Positioned(
      left: flower.position.dx,
      top: flower.position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            flower.position = Offset(
              flower.position.dx + details.delta.dx,
              flower.position.dy + details.delta.dy,
            );
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (flower.growthStage >= 4) _buildFlower(flower), // La flor en la parte superior (etapa 4)
            if (flower.growthStage >= 2) _buildStem(), // El tallo aparece en la etapa 2
            _buildPotShape(flower.growthStage), // La maceta en la parte inferior desde el inicio
            _buildActionButtons(flower),
          ],
        ),
      ),
    );
  }

  Widget _buildFlower(Flower flower) {
    return Column(
      children: [
        if (flower.growthStage == 4) // Etapa 4: círculo amarillo
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow, // Círculo amarillo en la etapa 4
            ),
            margin: EdgeInsets.only(bottom: 5),
          ),
        if (flower.growthStage == 5) // Etapa 5: círculo blanco alrededor
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Círculo blanco alrededor en la etapa 5
            ),
            margin: EdgeInsets.only(bottom: 5),
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow, // Círculo amarillo dentro del blanco
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStem() {
    return Container(
      width: 10,
      height: 30,
      color: Colors.green,
      margin: EdgeInsets.only(bottom: 5),
    );
  }

  Widget _buildPotShape(int growthStage) {
    // Maceta marrón desde el inicio
    Color potColor = Color.fromARGB(255, 139, 69, 19); // Color marrón

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: potColor,
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
        ),
      ),
    );
  }

  Widget _buildActionButtons(Flower flower) {
    return Container(
      width: 144,
      height: 144, // Altura ajustada para botones
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.opacity), // Ícono de regar
            onPressed: flower.canWater ? () {
              setState(() {
                flower.addWater();
              });
            } : null,
          ),
          IconButton(
            icon: Icon(Icons.local_florist), // Ícono de fertilizar
            onPressed: !flower.hasFertilized && flower.growthStage == 1 ? () {
              setState(() {
                flower.fertilize();
              });
            } : null,
          ),
          IconButton(
            icon: Icon(Icons.delete), // Ícono de eliminar planta
            onPressed: () {
              setState(() {
                flowers.remove(flower);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddFlowerButton() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {
          if (flowers.length < _maxFlowers) {
            setState(() {
              flowers.add(Flower(position: Offset(150, 300)));
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class Flower {
  Offset position;
  int growthStage = 1; // Inicialmente solo con la maceta
  int life = 240; // Vida útil de 3 minutos en segundos
  bool canWater = true;
  bool hasFertilized = false;
  Timer? timer;

  Flower({required this.position}) {
    _startFlowerTimer();
  }

  void addWater() {
    life = (life + 30).clamp(0, 180);
    canWater = false;
    Timer(Duration(seconds: 120), () {
      canWater = true;
    });
  }

  void fertilize() {
    growthStage += 1; // Incrementa la etapa de crecimiento
    hasFertilized = true;
  }

  void _startFlowerTimer() {
    // Incremento de las etapas de crecimiento cada 30 segundos
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (growthStage < 5) {
        growthStage += 1;
      }
      if (life <= 0) {
        timer.cancel();
      }
    });
  }
}
