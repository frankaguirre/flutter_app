import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarPage extends StatefulWidget {
  @override
  _AgregarPageState createState() => _AgregarPageState();
}

class _AgregarPageState extends State<AgregarPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _psController = TextEditingController();
  final TextEditingController _ataqueController = TextEditingController();
  final TextEditingController _defensaController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  void _guardarPokemon() async {
    final newPokemon = {
      'nombre': _nombreController.text,
      'tipo': _tipoController.text,
      'ps': _psController.text,
      'ataque': _ataqueController.text,
      'defensa': _defensaController.text,
      'foto': _fotoController.text,
    };

    final response = await http.post(
      Uri.parse('https://7db1-179-19-199-140.ngrok-free.app/pokemons'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newPokemon),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pokémon agregado correctamente')),
      );
      Navigator.pop(context); // Volver a la página anterior después de guardar
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Fondo verde suave
      appBar: AppBar(
        title: Text(
          'Agregar Datos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700], // Verde oscuro
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white, // Fondo blanco para los inputs
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tipoController,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _psController,
                decoration: InputDecoration(
                  labelText: 'PS',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _ataqueController,
                decoration: InputDecoration(
                  labelText: 'Ataque',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _defensaController,
                decoration: InputDecoration(
                  labelText: 'Defensa',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _fotoController,
                decoration: InputDecoration(
                  labelText: 'URL de la Foto',
                  labelStyle: TextStyle(color: Colors.green[900]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[700], // Color verde para el botón
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Botones redondeados
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _guardarPokemon,
                child: Text(
                  'Guardar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
