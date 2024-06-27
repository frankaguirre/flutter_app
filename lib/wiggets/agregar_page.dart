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
      appBar: AppBar(
        title: Text('Agregar Pokémon'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              TextField(
                controller: _psController,
                decoration: InputDecoration(labelText: 'PS'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _ataqueController,
                decoration: InputDecoration(labelText: 'Ataque'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _defensaController,
                decoration: InputDecoration(labelText: 'Defensa'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _fotoController,
                decoration: InputDecoration(labelText: 'URL de la Foto'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarPokemon,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
