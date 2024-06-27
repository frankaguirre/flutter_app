import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../modelos/pokemon.dart';
import 'datos_page.dart';
import 'agregar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Pokemon>> futurePokemons;

  @override
  void initState() {
    super.initState();
    futurePokemons = getList();
  }

  Future<List<Pokemon>> getList() async {
    final response = await http.get(
        Uri.parse('https://7db1-179-19-199-140.ngrok-free.app/pokemons'));
    if (response.statusCode == 200) {
      final info = jsonDecode(response.body);
      return pokemonFromJson(jsonEncode(info));
    } else {
      throw Exception('Fallo al traer los datos');
    }
  }

  void _navigateToAddPokemon() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AgregarPage()),
    ).then((_) {
      // Cuando regresamos de AgregarPage, actualizamos la lista de pokemons
      setState(() {
        futurePokemons = getList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Pokemons'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddPokemon,
          ),
        ],
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return DatosPage(pokemons: snapshot.data!);
          } else {
            return Center(child: Text('No se encontraron Pokémons'));
          }
        },
      ),
    );
  }
}
