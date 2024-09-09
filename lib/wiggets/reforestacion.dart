import 'package:flutter/material.dart';
import 'dart:async';

class PotGamePage extends StatefulWidget {
  @override
  _PotGamePageState createState() => _PotGamePageState();
}

class _PotGamePageState extends State<PotGamePage> {
  List<Flower> flowers = [];
  final int _maxFlowers = 3;
  final int _flowerLife = 180; // Vida útil de 3 minutos en segundos
  final int _wateringBoost = 30; // 30 segundos de vida extra
  final int _wateringCooldown = 120; // 2 minutos de reutilización del riego
  final int _wateringDuration = 60; // Duración en segundos para agregar agua
  final int _fertilizerBoost = 1; // Incremento de píxeles por fertilizante

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
          for (Flower flower in flowers) _buildPot(flower),
          _buildActionButtons(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (flowers.length < _maxFlowers) {
            setState(() {
              flowers.add(Flower(position: Offset(150, 300)));
              _startFlowerTimer(flowers.last);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
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
            if (flower.growthStage >= 3) _buildFlower(flower),
            if (flower.growthStage >= 2) _buildStem(),
            if (flower.growthStage >= 1) _buildPotShape(),
          ],
        ),
      ),
    );
  }

  Widget _buildFlower(Flower flower) {
    if (flower.growthStage == 3) {
      return Container(
        width: 50,
        height: 50,
        color: const Color.fromARGB(255, 238, 234, 236),
        margin: EdgeInsets.only(bottom: 5),
        child: Center(
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 236, 240, 6),
            ),
          ),
        ),
      );
    } else if (flower.growthStage == 2) {
      return Container(
        width: 30,
        height: 30,
        color: const Color.fromARGB(255, 231, 244, 54),
        margin: EdgeInsets.only(bottom: 5),
      );
    } else {
      return Container();
    }
  }

  Widget _buildStem() {
    return Container(
      width: 10,
      height: 30,
      color: Colors.green,
      margin: EdgeInsets.only(bottom: 5),
    );
  }

  Widget _buildPotShape() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color.fromARGB(255, 212, 59, 3),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.opacity), // Ícono de regar
            onPressed: () {
              setState(() {
                for (var flower in flowers) {
                  if (flower.canWater) {
                    flower.addWater(_wateringBoost, _wateringCooldown);
                  }
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.local_florist), // Ícono de fertilizar
            onPressed: () {
              setState(() {
                for (var flower in flowers) {
                  if (flower.growthStage < 3 && !flower.hasFertilized) {
                    flower.addFertilizer(_fertilizerBoost);
                  }
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete), // Ícono de eliminar planta
            onPressed: () {
              setState(() {
                flowers.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  void _startFlowerTimer(Flower flower) {
    flower.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        flower.life -= 1;
        if (flower.life <= 0) {
          flower.life = 0;
          flowers.remove(flower);
          timer.cancel();
        }
      });
    });
  }
}

class Flower {
  Offset position;
  int growthStage = 1; // Inicialmente crece desde la etapa 1
  int life = 180; // Vida útil de 3 minutos en segundos
  bool canWater = true;
  bool hasFertilized = false;
  Timer? timer;

  Flower({required this.position});

  void addWater(int boost, int cooldown) {
    life = (life + boost).clamp(0, 180);
    canWater = false;
    Timer(Duration(seconds: cooldown), () {
      canWater = true;
    });
  }

  void addFertilizer(int boost) {
    if (!hasFertilized) {
      growthStage = (growthStage + boost).clamp(1, 3);
      hasFertilized = true;
    }
  }
}
