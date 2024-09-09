import 'package:flutter/material.dart';
import 'dart:async';

class PotGamePage extends StatefulWidget {
  @override
  _PotGamePageState createState() => _PotGamePageState();
}

class _PotGamePageState extends State<PotGamePage> {
  final List<Flower> _flowers = [];
  int _score = 0;
  static const int _maxFlowers = 3;
  Timer? _growthTimer;
  Timer? _lifeTimer;
  static const double _pixelSize = 5.0;
  static const double _potWidth = 50.0;
  static const double _potHeight = 30.0;

  @override
  void initState() {
    super.initState();
    _startGrowthTimer();
    _startLifeTimer();
  }

  void _startGrowthTimer() {
    _growthTimer = Timer.periodic(Duration(seconds: 60), (timer) {
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

  void _startLifeTimer() {
    _lifeTimer = Timer.periodic(Duration(minutes: 3), (timer) {
      setState(() {
        _flowers.removeWhere((flower) => flower.lifetimeExpired);
      });
    });
  }

  void _addFlower(Offset position) {
    if (_flowers.length < _maxFlowers) {
      setState(() {
        _flowers.add(Flower(position: position));
      });
    }
  }

  void _applyFertilizer(Flower flower) {
    setState(() {
      flower.applyFertilizer();
    });
  }

  void _waterFlower(Flower flower) {
    setState(() {
      if (flower.canWater) {
        flower.water();
      }
    });
  }

  void _replant(Flower flower) {
    setState(() {
      _flowers.remove(flower);
      _addFlower(flower.position);
    });
  }

  void _removeFlower(Flower flower) {
    setState(() {
      _flowers.remove(flower);
    });
  }

  @override
  void dispose() {
    _growthTimer?.cancel();
    _lifeTimer?.cancel();
    super.dispose();
  }

  Widget _buildPot(Offset position) {
    return Positioned(
      left: position.dx - _potWidth / 2,
      top: position.dy,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pixel(Colors.brown[700]!, 6),
              _pixel(Colors.brown[600]!, 6),
              _pixel(Colors.brown[700]!, 6),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pixel(Colors.brown[800]!, 18),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.opacity),
                onPressed: () => _waterFlower(_flowers.firstWhere((f) => f.position == position)),
              ),
              IconButton(
                icon: Icon(Icons.local_florist),
                onPressed: () => _applyFertilizer(_flowers.firstWhere((f) => f.position == position)),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeFlower(_flowers.firstWhere((f) => f.position == position)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlower(Flower flower) {
    List<Widget> pixels = [];

    if (flower.growthStage == 0) {
      pixels = [_pixel(Colors.brown[800]!, 1)];
    } else if (flower.growthStage == 1) {
      pixels = [_pixel(Colors.green[900]!, 1), _pixel(Colors.green[800]!, 1)];
    } else if (flower.growthStage == 2) {
      pixels = [
        _pixel(Colors.green[900]!, 1),
        _pixel(Colors.green[800]!, 1),
        _pixel(Colors.green[700]!, 1),
      ];
    } else {
      pixels = [
        _pixel(Colors.green[900]!, 1),
        _pixel(Colors.green[800]!, 1),
        _pixel(Colors.yellow[700]!, 2),
        _pixel(Colors.white, 2),
      ];
    }

    return Positioned(
      left: flower.position.dx - _pixelSize / 2,
      top: flower.position.dy - _pixelSize * 5,
      child: Column(
        children: pixels,
      ),
    );
  }

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
          ..._flowers.map((flower) => Stack(
            children: [
              _buildPot(flower.position),
              _buildFlower(flower),
            ],
          )),
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

class Flower {
  final Offset position;
  int growthStage = 0;
  bool isWatered = false;
  bool isFertilized = false;
  DateTime _plantTime = DateTime.now();

  Flower({required this.position});

  bool get lifetimeExpired => DateTime.now().difference(_plantTime).inMinutes >= 3;

  bool get canWater => DateTime.now().difference(_plantTime).inMinutes >= 2;

  void grow() {
    if (growthStage < 3) {
      growthStage++;
    }
  }

  void applyFertilizer() {
    if (!isFertilized) {
      growthStage++;
      isFertilized = true;
    }
  }

  void water() {
    if (canWater) {
      _plantTime = _plantTime.add(Duration(seconds: 30));
    }
  }
}
