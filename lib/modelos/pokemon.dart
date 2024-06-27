import 'dart:convert';

List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

String pokemonToJson(List<Pokemon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pokemon {
  Pokemon({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.ps,
    required this.ataque,
    required this.defensa,
    required this.foto,
  });

  int id;
  String nombre;
  String tipo;
  String ps;
  String ataque;
  String defensa;
  String foto;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: json["id"],
        nombre: json["nombre"],
        tipo: json["tipo"],
        ps: json["ps"],
        ataque: json["ataque"],
        defensa: json["defensa"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "tipo": tipo,
        "ps": ps,
        "ataque": ataque,
        "defensa": defensa,
        "foto": foto,
      };
}
