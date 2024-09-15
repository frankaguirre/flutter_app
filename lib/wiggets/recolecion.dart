import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SnakeGamePage extends StatefulWidget {
  @override
  _SnakeGamePageState createState() => _SnakeGamePageState();
}

class _SnakeGamePageState extends State<SnakeGamePage> {
  static const int gridSize = 20;
  static const double boxSize = 20.0;
  List<Offset> _snake = [Offset(0, 0)];
  Offset _food = Offset(10, 10);
  int _score = 0;
  int _lives = 2;
  bool _gameOver = false;
  Timer? _timer;
  Offset _direction = Offset(1, 0);
  Offset _lastPanUpdate = Offset.zero;
  int _speed = 200;
  Map<Color, String> _colorDescriptions = {
    Colors.green: "Vidrio",
    Colors.yellow: "Plástico",
    Colors.red: "Tetra Pak",
    Colors.grey: "Latas y Metales",
    Colors.blue: "Papel",
  };
  Color _currentColor = Colors.green;
  String _currentObjective = "Vidrio";

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _gameOver = false;
      _score = 0;
      _lives = 2;
      _snake = [Offset(0, 0)];
      _direction = Offset(1, 0);
      _speed = 200;
      _food = _generateRandomFood();
      _generateRandomObjective();
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: _speed), (timer) {
      if (!_gameOver) {
        _moveSnake();
      }
    });
  }

  void _moveSnake() {
    setState(() {
      final newHead = _snake.first + _direction;
      if (_checkWallCollision(newHead)) {
        if (_lives > 0) {
          _lives--;
          _snake = [Offset(0, 0)];
          _direction = Offset(1, 0);
          _speed = 200;
          _timer?.cancel();
          _timer = Timer.periodic(Duration(milliseconds: _speed), (timer) {
            if (!_gameOver) {
              _moveSnake();
            }
          });
        } else {
          _gameOver = true;
          _timer?.cancel();
        }
      } else {
        _snake.insert(0, newHead);
        if (newHead == _food) {
          _score += 10;
          _generateRandomObjective();
          _food = _generateRandomFood();
          _increaseSpeed();
        } else {
          _snake.removeLast();
        }
      }
    });
  }

  bool _checkWallCollision(Offset head) {
    return head.dx < 0 || head.dy < 0 || head.dx >= gridSize || head.dy >= gridSize;
  }

  Offset _generateRandomFood() {
    final random = Random();
    Offset newFood;
    do {
      newFood = Offset(
        random.nextInt(gridSize.toInt()).toDouble(),
        random.nextInt(gridSize.toInt()).toDouble(),
      );
    } while (_snake.contains(newFood));
    return newFood;
  }

  void _generateRandomObjective() {
    final randomIndex = Random().nextInt(_colorDescriptions.length);
    _currentColor = _colorDescriptions.keys.elementAt(randomIndex);
    _currentObjective = _colorDescriptions[_currentColor]!;
  }

  void _increaseSpeed() {
    _speed = (_speed * 0.9).toInt();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: _speed), (timer) {
      if (!_gameOver) {
        _moveSnake();
      }
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final dx = details.localPosition.dx - _lastPanUpdate.dx;
    final dy = details.localPosition.dy - _lastPanUpdate.dy;

    if (dx.abs() > dy.abs()) {
      _direction = dx > 0 ? Offset(1, 0) : Offset(-1, 0);
    } else {
      _direction = dy > 0 ? Offset(0, 1) : Offset(0, -1);
    }
    _lastPanUpdate = details.localPosition;
  }

  Future<bool> _onWillPop() async {
    _timer?.cancel(); // Detiene el juego
    return true; // Permite salir de la página
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Captura el evento del botón atrás
      child: Scaffold(
        appBar: AppBar(
          title: Text('Juego de la Serpiente - Recolección'),
          backgroundColor: Colors.green[700],
        ),
        body: GestureDetector(
          onPanUpdate: _handlePanUpdate,
          onPanEnd: (_) {
            _lastPanUpdate = Offset.zero;
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: gridSize * boxSize,
                  height: gridSize * boxSize,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Positioned(
                        left: _food.dx * boxSize,
                        top: _food.dy * boxSize,
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          color: _currentColor,
                        ),
                      ),
                      ..._snake.map((segment) => Positioned(
                            left: segment.dx * boxSize,
                            top: segment.dy * boxSize,
                            child: Container(
                              width: boxSize,
                              height: boxSize,
                              color: Colors.green,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Recolección: $_score\nIntentos restantes: $_lives',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                if (_gameOver) ...[
                  SizedBox(height: 20),
                  Text(
                    '¡Juego Terminado! Inténtalo de nuevo.',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: _startGame,
                    child: Text('Reiniciar Juego'),
                  ),
                ] else if (_score >= 1000) ...[
                  SizedBox(height: 20),
                  Text(
                    '¡Felicidades! Has recolectado 1000 puntos.',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
                SizedBox(height: 20),
                Text(
                  'Objetivo Actual:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 20, height: 20, color: _currentColor),
                    SizedBox(width: 10),
                    Text(_currentObjective, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

