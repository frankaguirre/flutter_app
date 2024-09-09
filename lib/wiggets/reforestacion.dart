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
            _buildPotShape(),
            if (flower.growthStage >= 2) _buildStem(),
            if (flower.growthStage >= 3) _buildFlower(flower),
            _buildActionButtons(flower),
          ],
        ),
      ),
    );
  }

  Widget _buildFlower(Flower flower) {
    return Container(
      width: flower.growthStage == 3 ? 50 : 30,
      height: flower.growthStage == 3 ? 50 : 30,
      color: flower.growthStage == 3 ? Color.fromARGB(255, 230, 124, 4) : Color.fromARGB(255, 231, 244, 54),
      margin: EdgeInsets.only(bottom: 5),
      child: flower.growthStage == 3 ? Center(
        child: Container(
          width: 10,
          height: 10,
          
        ),
      ) : null,
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

  Widget _buildPotShape() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color.fromARGB(255, 243, 240, 239),
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 246, 250, 7),
          ),
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
  int growthStage = 3; // Inicialmente con todos los componentes
  int life = 180; // Vida útil de 3 minutos en segundos
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
    growthStage = 3;
    hasFertilized = true;
  }

  void _startFlowerTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      life -= 1;
      if (life <= 0) {
        life = 0;
        timer.cancel();
      }
    });
  }
}
