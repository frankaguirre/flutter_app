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

  void _startGame() {
    setState(() {
      _gameOver = false;
      _score = 0;
      _lives = 2;
      _snake = [Offset(0, 0)];
      _food = _generateRandomFood();
      _direction = Offset(1, 0); // Inicia moviéndose a la derecha
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (!_gameOver) {
        _moveSnake();
      }
    });
  }

  void _moveSnake() {
    setState(() {
      final newHead = _snake.first + _direction;
      if (_checkCollision(newHead)) {
        if (_lives > 0) {
          _lives--;
          _snake = [Offset(0, 0)];
          _direction = Offset(1, 0); // Reiniciar dirección después de perder una vida
        } else {
          _gameOver = true;
          _timer?.cancel();
        }
      } else {
        _snake.insert(0, newHead);
        if (newHead == _food) {
          _score += 10;
          _food = _generateRandomFood();
        } else {
          _snake.removeLast();
        }
      }
    });
  }

  bool _checkCollision(Offset head) {
    if (head.dx < 0 || head.dy < 0 || head.dx >= gridSize || head.dy >= gridSize) {
      return true;
    }
    return _snake.contains(head);
  }

  Offset _generateRandomFood() {
    final random = Random();
    return Offset(
      random.nextInt(gridSize.toInt()).toDouble(),
      random.nextInt(gridSize.toInt()).toDouble(),
    );
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final dx = details.localPosition.dx - _lastPanUpdate.dx;
    final dy = details.localPosition.dy - _lastPanUpdate.dy;

    if (dx.abs() > dy.abs()) {
      // Movimiento horizontal
      if (dx > 0) {
        _direction = Offset(1, 0); // Derecha
      } else {
        _direction = Offset(-1, 0); // Izquierda
      }
    } else {
      // Movimiento vertical
      if (dy > 0) {
        _direction = Offset(0, 1); // Abajo
      } else {
        _direction = Offset(0, -1); // Arriba
      }
    }
    
    _lastPanUpdate = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de la Culebra'),
        backgroundColor: Colors.green[700],
      ),
      body: GestureDetector(
        onPanUpdate: _handlePanUpdate,
        onPanEnd: (_) {
          _lastPanUpdate = Offset.zero; // Reinicia el punto de inicio del gesto
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
                        color: Colors.red,
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
              ] else if (_score >= 100) ...[
                SizedBox(height: 20),
                Text(
                  '¡Felicidades! Has recolectado 100 bolitas rojas.',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startGame,
        child: Text('Ready'),
      ),
    );
  }
}
