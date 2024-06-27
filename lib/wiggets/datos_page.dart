import 'package:flutter/material.dart';
import '../modelos/pokemon.dart';

class DatosPage extends StatefulWidget {
  final List<Pokemon> pokemons;

  DatosPage({required this.pokemons});

  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  List<Pokemon> selectedPokemons = [];

  void _toggleSelection(Pokemon pokemon) {
    setState(() {
      if (selectedPokemons.contains(pokemon)) {
        selectedPokemons.remove(pokemon);
      } else if (selectedPokemons.length < 3) {
        selectedPokemons.add(pokemon);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Solo puedes tener 3 Pokémons')),
        );
      }
    });
  }

  void _eliminarPokemon(Pokemon pokemon) {
    setState(() {
      widget.pokemons.remove(pokemon);
      selectedPokemons.remove(pokemon);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${pokemon.nombre} ha sido eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: widget.pokemons.length,
          itemBuilder: (context, index) {
            final pokemon = widget.pokemons[index];
            final isSelected = selectedPokemons.contains(pokemon);
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: isSelected ? Colors.lightBlueAccent : Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      pokemon.foto,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pokemon.nombre,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Tipo: ${pokemon.tipo}', style: TextStyle(fontSize: 14)),
                        Text('PS: ${pokemon.ps}', style: TextStyle(fontSize: 14)),
                        Text('Ataque: ${pokemon.ataque}', style: TextStyle(fontSize: 14)),
                        Text('Defensa: ${pokemon.defensa}', style: TextStyle(fontSize: 14)),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _eliminarPokemon(pokemon),
                          child: Text('Eliminar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
